module IceCubed

  module Validations::MonthOfYear

    def month_of_year(*months)
      months.flatten.each do |month|
        unless month.is_a?(Integer) || month.is_a?(Symbol)
          raise ArgumentError, "expecting Integer or Symbol value for month, got #{month.inspect}"
        end
        month = TimeUtil.sym_to_month(month)
        verify_alignment(month, :month, :month_of_year) { |error| raise error }
        validations_for(:month_of_year) << Validation.new(month)
      end
      clobber_base_validations :month
      self
    end

    class Validation < Validations::FixedValue

      attr_reader :month
      alias :value :month

      def initialize(month)
        @month = month
      end

      def key
        :month_of_year
      end

      def type
        :month
      end

      def dst_adjust?
        true
      end

      def build_s(builder)
        builder.piece(:month_of_year) << IceCubed::I18n.t("date.month_names")[month]
      end

      def build_hash(builder)
        builder.validations_array(:month_of_year) << month
      end

      def build_ical(builder)
        builder['BYMONTH'] << month
      end

      StringBuilder.register_formatter(:month_of_year) do |segments|
        IceCubed::I18n.t("ice_cubed.in", target: StringBuilder.sentence(segments))
      end

    end

  end

end
