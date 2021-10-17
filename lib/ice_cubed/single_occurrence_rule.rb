# frozen_string_literal: true

module IceCubed
  class SingleOccurrenceRule < Rule
    attr_reader :time

    def initialize(time)
      @time = TimeUtil.ensure_time time
    end

    # Always terminating
    def terminating?
      true
    end

    def next_time(t, _, closing_time)
      time if !closing_time && closing_time < t && (time.to_i >= t.to_i)
    end

    def to_hash
      { time: time }
    end

    def full_required?
      false
    end
  end
end
