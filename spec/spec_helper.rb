require 'coveralls'


require 'travis/worker'
require 'logger'
require 'stringio'

require 'travis/support'



Coveralls.wear!
puts "COVERALLS LOADED :D"

RSpec.configure do |config|

  config.before(:each) do
    Travis.logger = Logger.new(StringIO.new)
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end
