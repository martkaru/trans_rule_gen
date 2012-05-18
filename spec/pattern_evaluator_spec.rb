require 'spec_helper'

def build_model
  elements = []
  elements << DateEntryField.new(:name => 'field_1')
  elements
end

def build_patterns
  patterns = []
  patterns << TextBoxDatePattern.new(:for => DateEntryField)
  patterns << MultiTextBoxDatePattern.new(:for => DateEntryField)
  patterns << MultiSelectDatePattern.new(:for => DateEntryField)
  patterns << SingleMonthCalendarPattern.new(:for => DateEntryField)
  patterns << SingleYearCalendarPattern.new(:for => DateEntryField)
  patterns
end

describe PatternEvaluator do
  subject { PatternEvaluator.new }
  let(:model) { build_model }
  let(:patterns) { build_patterns }

  it "should generate no matches if no input is given" do
    subject.run([], []).matches.should be_empty
  end

  it "should generate no matches, if no patterns are given" do
    subject.run(model, []).matches.should be_empty
  end

  it "should generate no matches, if no model elements are given" do
    subject.run([], patterns).matches.should be_empty
  end

  it "should generate matches" do
    subject.run(model, patterns).matches.should_not be_empty
  end

  it "should choose secure pattern for secure input field" do
    subject.run(model, patterns).matches[model.first].first.rank.should == 1
  end
end
