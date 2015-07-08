require 'capybara'
require 'capybara/rspec'
require 'capybara/cucumber'

require_relative "../../overlord"

Capybara.app = Overlord
