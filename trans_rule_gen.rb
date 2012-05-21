require "rubygems"
require "bundler/setup"
Bundler.require(:default)

require './models/ui_model.rb'
require './models/web_ui_model.rb'
require './models/constraints.rb'
require './patterns/patterns.rb'
require './patterns/pattern_rules.rb'
require './lib/pattern_evaluator.rb'
require './lib/transformer.rb'
