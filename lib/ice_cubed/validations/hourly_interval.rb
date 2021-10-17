# frozen_string_literal: true

module IceCubed
  module Validations
    module HourlyInterval
      def interval(interval)
        verify_alignment(interval, :hour, :interval) { |error| raise error }

        @interval = normalized_interval(interval)
        replace_validations_for(:interval, [Validation.new(@interval)])
        clobber_base_validations(:hour)
        self
      end

      class Validation
        attr_reader :interval

        def initialize(interval)
          @interval = interval
        end

        def type
          :hour
        end

        def dst_adjust?
          false
        end

        def validate(step_time, start_time)
          t0 = start_time.to_i
          t1 = step_time.to_i
          sec = (t1 - (t1 % ONE_HOUR)) -
                (t0 - (t0 % ONE_HOUR))
          hours = sec / ONE_HOUR
          offset = (hours % interval).nonzero?
          interval - offset if offset
        end

        def build_s(builder)
          builder.base = IceCubed::I18n.t("ice_cubed.each_hour", count: interval)
        end

        def build_hash(builder)
          builder[:interval] = interval
        end

        def build_ical(builder)
          builder["FREQ"] << "HOURLY"
          builder["INTERVAL"] << interval unless interval == 1
        end
      end
    end
  end
end
