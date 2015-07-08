require 'capybara'
require 'capybara/rspec'
require 'capybara/cucumber'
require 'coveralls'
Coveralls.wear!

require_relative "../../overlord"

Capybara.app = Overlord
