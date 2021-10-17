# frozen_string_literal: true

module IceCubed
  class StringBuilder
    attr_writer :base

    def initialize
      @types = {}
    end

    def piece(type, _prefix = nil, _suffix = nil)
      @types[type] ||= []
    end

    def to_s
      string = @base || ""
      @types.each do |type, segments|
        if f = self.class.formatter(type)
          current = f.call(segments)
        else
          next if segments.empty?

          current = self.class.sentence(segments)
        end
        f = IceCubed::I18n.t("ice_cubed.string.format")[type] ? type : "default"
        string = IceCubed::I18n.t("ice_cubed.string.format.#{f}", rest: string, current: current)
      end
      string
    end

    def self.formatter(type)
      @formatters[type]
    end

    def self.register_formatter(type, &formatter)
      @formatters ||= {}
      @formatters[type] = formatter
    end

    module Helpers
      # influenced by ActiveSupport's to_sentence
      def sentence(array)
        case array.length
        when 0 then ""
        when 1 then array[0].to_s
        when 2 then "#{array[0]}#{IceCubed::I18n.t('ice_cubed.array.two_words_connector')}#{array[1]}"
        else
          "#{array[0...-1].join(IceCubed::I18n.t('ice_cubed.array.words_connector'))}#{IceCubed::I18n.t('ice_cubed.array.last_word_connector')}#{array[-1]}"
        end
      end

      def nice_number(number)
        literal_ordinal(number) || ordinalize(number)
      end

      def ordinalize(number)
        IceCubed::I18n.t("ice_cubed.integer.ordinal", number: number, ordinal: ordinal(number))
      end

      def literal_ordinal(number)
        IceCubed::I18n.t("ice_cubed.integer.literal_ordinals")[number]
      end

      def ordinal(number)
        ord = IceCubed::I18n.t("ice_cubed.integer.ordinals")[number] ||
              IceCubed::I18n.t("ice_cubed.integer.ordinals")[number % 10] ||
              IceCubed::I18n.t("ice_cubed.integer.ordinals")[:default]
        number >= 0 ? ord : IceCubed::I18n.t("ice_cubed.integer.negative", ordinal: ord)
      end
    end

    extend Helpers
  end
end
