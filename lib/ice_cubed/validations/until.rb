module IceCubed
  module Validations::Until
    extend Deprecated

    # Value reader for limit
    def until_time
      (arr = @validations[:until]) && (val = arr[0]) && val.time
    end
    deprecated_alias :until_date, :until_time

    def until(time)
      replace_validations_for(:until, time.nil? ? nil : [Validation.new(time)])
      self
    end

    class Validation
      attr_reader :time

      def initialize(time)
        @time = time
      end

      def type
        :limit
      end

      def dst_adjust?
        false
      end

      def validate(step_time, start_time)
        end_time = TimeUtil.ensure_time(time, start_time, true)
        raise UntilExceeded if step_time > end_time
      end

      def build_s(builder)
        date = IceCubed::I18n.l(time, format: IceCubed.to_s_time_format)
        builder.piece(:until) << IceCubed::I18n.t("ice_cubed.until", date: date)
      end

      def build_hash(builder)
        builder[:until] = TimeUtil.serialize_time(time)
      end

      def build_ical(builder)
        builder["UNTIL"] << IcalBuilder.ical_utc_format(time)
      end
    end
  end
end
