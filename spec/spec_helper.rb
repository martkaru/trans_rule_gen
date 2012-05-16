require "rubygems"
require "bundler/setup"
Bundler.require(:default)
require 'rspec'

require './models/models.rb'
require './patterns/patterns.rb'
require './lib/pattern_evaluator.rb'

RSpec.configure do |c|
  c.mock_with :rspec
end
