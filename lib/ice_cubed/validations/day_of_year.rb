# frozen_string_literal: true

module IceCubed
  module Validations
    module DayOfYear
      def day_of_year(*days)
        days.flatten.each do |day|
          raise ArgumentError, "expecting Integer value for day, got #{day.inspect}" unless day.is_a?(Integer)

          validations_for(:day_of_year) << Validation.new(day)
        end
        clobber_base_validations(:month, :day, :wday)
        self
      end

      class Validation
        attr_reader :day

        def initialize(day)
          @day = day
        end

        def type
          :day
        end

        def dst_adjust?
          true
        end

        def validate(step_time, _start_time)
          days_in_year = TimeUtil.days_in_year(step_time)
          yday = day.negative? ? day + days_in_year + 1 : day
          offset = yday - step_time.yday
          offset >= 0 ? offset : offset + days_in_year
        end

        def build_s(builder)
          builder.piece(:day_of_year) << StringBuilder.nice_number(day)
        end

        def build_hash(builder)
          builder.validations_array(:day_of_year) << day
        end

        def build_ical(builder)
          builder["BYYEARDAY"] << day
        end

        StringBuilder.register_formatter(:day_of_year) do |entries|
          str = StringBuilder.sentence(entries)
          sentence = IceCubed::I18n.t("ice_cubed.days_of_year", count: entries.size, segments: str)
          IceCubed::I18n.t("ice_cubed.on", sentence: sentence)
        end
      end
    end
  end
end
