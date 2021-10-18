# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ice_cubed/version'

Gem::Specification.new do |s|
  s.name          = 'ice_cubed'
  s.summary       = 'Ruby Date Recurrence Library'
  s.description   = 'ice_cubed is a recurring date library for Ruby.  It allows for quick, programatic expansion of recurring date rules.'
  s.authors       = ['John Crepezzi']
  s.homepage      = 'https://github.com/configua/ice_cubed/'
  s.license       = 'MIT'

  s.version       = IceCubed::VERSION
  s.platform      = Gem::Platform::RUBY
  s.files         = Dir['lib/**/*.rb', 'config/**/*.yml']
  s.test_files    = Dir.glob('spec/*.rb')
  s.require_paths = ['lib']

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '> 3')
end
