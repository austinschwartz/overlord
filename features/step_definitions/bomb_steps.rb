require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'
require 'bundler/setup'
require 'sinatra'
require_relative '../../overlord.rb'

Capybara.app = Overlord

Given(/^I visit the bomb page$/) do
  visit '/'
end

Then(/^the bomb should be (.*)$/) do |status|
  page.find('p.status').text.split(': ')[1].should eq(status)
end



## Not Booted

And(/^I set the activation code to (.*)$/) do |num|
  fill_in 'acode', :with => num
end

And(/^I set the deactivation code to (.*)$/) do |num|
  fill_in 'dcode', :with => num
end

And(/^I set the codes to (.*) and (.*)$/) do |num1, num2|
  fill_in 'acode', :with => num1
  fill_in 'dcode', :with => num2
end

And(/^I (.*) the bomb$/) do |arg|
  click_button arg.capitalize
end

# Not_Active

When(/^I enter the activation code correctly$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

