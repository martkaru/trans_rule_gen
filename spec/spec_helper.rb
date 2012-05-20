require "rubygems"
require "bundler/setup"
Bundler.require(:default)
require 'rspec'

require './models/ui_model.rb'
require './models/web_ui_model.rb'
require './patterns/patterns.rb'
require './lib/pattern_evaluator.rb'

RSpec.configure do |c|
  c.mock_with :rspec
end
