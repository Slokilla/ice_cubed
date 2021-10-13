require 'ice_cubed/null_i18n'

module IceCubed
  module I18n

    LOCALES_PATH = File.expand_path(File.join('..', '..', '..', 'config', 'locales'), __FILE__)

    class << self
      delegate :t, :l, to: :backend
    end

    def self.backend
      @backend ||= detect_backend!
    end

    def self.detect_backend!
      ::I18n.load_path += Dir[File.join(LOCALES_PATH, '*.yml')]
      ::I18n
    rescue NameError
      NullI18n
    end
  end
end
