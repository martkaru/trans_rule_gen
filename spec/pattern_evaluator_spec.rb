require 'spec_helper'

def build_model
  elements = []
  elements << InputField.new(:name => 'field_1')
  elements << InputField.new(:name => 'field_2', :secure => true)
  elements
end

def build_patterns
  patterns = []
  patterns << Pattern.new(:for => InputField)
  patterns << Pattern.new(:for => InputField)
  patterns << Pattern.new(:for => InputField)
end

describe PatternEvaluator do
  subject { PatternEvaluator.new }
  it "should generate no matches if no input is given" do
    subject.run([], []).matches.should be_empty
  end

  it "should generate no matches, if no patterns are given" do
    subject.run(build_model, []).matches.should be_empty
  end

  it "should generate no matches, if no model elements are given" do
    subject.run([], build_patterns).matches.should be_empty
  end

  it "should generate matches" do
    subject.run(build_model, build_patterns).matches.should_not be_empty
  end

  it "should generate matches" do
    subject.run(build_model, build_patterns).matches.should_not be_empty
  end
end
