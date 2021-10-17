# frozen_string_literal: true

require "date"
require "ice_cubed/deprecated"

module IceCubed
  autoload :VERSION, "ice_cubed/version"

  autoload :TimeUtil, "ice_cubed/time_util"
  autoload :FlexibleHash, "ice_cubed/flexible_hash"
  autoload :I18n, "ice_cubed/i18n"

  autoload :Rule, "ice_cubed/rule"
  autoload :Schedule, "ice_cubed/schedule"
  autoload :Occurrence, "ice_cubed/occurrence"

  autoload :IcalBuilder, "ice_cubed/builders/ical_builder"
  autoload :HashBuilder, "ice_cubed/builders/hash_builder"
  autoload :StringBuilder, "ice_cubed/builders/string_builder"

  autoload :HashParser, "ice_cubed/parsers/hash_parser"
  autoload :YamlParser, "ice_cubed/parsers/yaml_parser"
  autoload :IcalParser, "ice_cubed/parsers/ical_parser"

  autoload :CountExceeded, "ice_cubed/errors/count_exceeded"
  autoload :UntilExceeded, "ice_cubed/errors/until_exceeded"

  autoload :ValidatedRule, "ice_cubed/validated_rule"
  autoload :SingleOccurrenceRule, "ice_cubed/single_occurrence_rule"

  autoload :SecondlyRule, "ice_cubed/rules/secondly_rule"
  autoload :MinutelyRule, "ice_cubed/rules/minutely_rule"
  autoload :HourlyRule, "ice_cubed/rules/hourly_rule"
  autoload :DailyRule, "ice_cubed/rules/daily_rule"
  autoload :WeeklyRule, "ice_cubed/rules/weekly_rule"
  autoload :MonthlyRule, "ice_cubed/rules/monthly_rule"
  autoload :YearlyRule, "ice_cubed/rules/yearly_rule"

  module Validations
    autoload :FixedValue, "ice_cubed/validations/fixed_value"
    autoload :ScheduleLock, "ice_cubed/validations/schedule_lock"

    autoload :Count, "ice_cubed/validations/count"
    autoload :Until, "ice_cubed/validations/until"

    autoload :SecondlyInterval, "ice_cubed/validations/secondly_interval"
    autoload :MinutelyInterval, "ice_cubed/validations/minutely_interval"
    autoload :DailyInterval, "ice_cubed/validations/daily_interval"
    autoload :WeeklyInterval, "ice_cubed/validations/weekly_interval"
    autoload :MonthlyInterval, "ice_cubed/validations/monthly_interval"
    autoload :YearlyInterval, "ice_cubed/validations/yearly_interval"
    autoload :HourlyInterval, "ice_cubed/validations/hourly_interval"

    autoload :HourOfDay, "ice_cubed/validations/hour_of_day"
    autoload :MonthOfYear, "ice_cubed/validations/month_of_year"
    autoload :MinuteOfHour, "ice_cubed/validations/minute_of_hour"
    autoload :SecondOfMinute, "ice_cubed/validations/second_of_minute"
    autoload :DayOfMonth, "ice_cubed/validations/day_of_month"
    autoload :DayOfWeek, "ice_cubed/validations/day_of_week"
    autoload :Day, "ice_cubed/validations/day"
    autoload :DayOfYear, "ice_cubed/validations/day_of_year"
  end

  # Define some useful constants
  ONE_SECOND = 1
  ONE_MINUTE = ONE_SECOND * 60
  ONE_HOUR =   ONE_MINUTE * 60
  ONE_DAY =    ONE_HOUR   * 24
  ONE_WEEK =   ONE_DAY    * 7

  # Defines the format used by IceCube when printing out Schedule#to_s.
  # Defaults to '%B %e, %Y'
  def self.to_s_time_format
    IceCubed::I18n.t("ice_cubed.date.formats.default")
  end

  # Sets the format used by IceCube when printing out Schedule#to_s.
  def self.to_s_time_format=(format)
    @to_s_time_format = format
  end

  # Retain backwards compatibility for schedules exported from older versions
  # This represents the version number, 11 = 0.11, 1.0 will be 100
  def self.compatibility
    @compatibility ||= IceCubed::VERSION.scan(/\d+/)[0..1].join.to_i
  end

  def self.compatibility=(version)
    @compatibility = version
  end
end
