# frozen_string_literal: true

module IceCubed
  class IcalBuilder
    ICAL_DAYS = %w[SU MO TU WE TH FR SA].freeze

    def initialize
      @hash = {}
    end

    def self.fixnum_to_ical_day(num)
      ICAL_DAYS[num]
    end

    def [](key)
      @hash[key] ||= []
    end

    # Build for a single rule entry
    def to_s
      arr = []
      if freq = @hash.delete("FREQ")
        arr << "FREQ=#{freq.join(',')}"
      end
      arr.concat(@hash.map do |key, value|
        "#{key}=#{value.join(',')}" if value.is_a?(Array)
      end.compact)
      arr.join(";")
    end

    def self.ical_utc_format(time)
      time = time.dup.utc
      IceCubed::I18n.l(time, format: "%Y%m%dT%H%M%SZ") # utc time
    end

    def self.ical_format(time, force_utc)
      time = time.dup.utc if force_utc
      if time.utc?
        ":#{IceCubed::I18n.l(time, format: '%Y%m%dT%H%M%SZ')}" # utc time
      else
        ";TZID=#{IceCubed::I18n.l(time, format: '%Z:%Y%m%dT%H%M%S')}" # local time specified
      end
    end

    def self.ical_duration(duration)
      hours = duration / 3600
      duration %= 3600
      minutes = duration / 60
      duration %= 60
      repr = ""
      repr << "#{hours}H" if hours.positive?
      repr << "#{minutes}M" if minutes.positive?
      repr << "#{duration}S" if duration.positive?
      "PT#{repr}"
    end
  end
end
