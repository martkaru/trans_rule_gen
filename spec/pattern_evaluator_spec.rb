require 'spec_helper'

def build_model
  elements = []
  elements << UiModel::DateEntryField.new(:name => 'from')
  elements << UiModel::DateEntryField.new(:name => 'to')
  elements
end

def build_constraints
  constraints = []
  constraints
end

def build_patterns
  patterns = []
  patterns << TextBoxDatePattern.new(:for => UiModel::DateEntryField)
  patterns << MultiTextBoxDatePattern.new(:for => UiModel::DateEntryField)
  patterns << MultiSelectDatePattern.new(:for => UiModel::DateEntryField)
  patterns << SingleMonthCalendarPattern.new(:for => UiModel::DateEntryField)
  patterns << SingleYearCalendarPattern.new(:for => UiModel::DateEntryField)
  patterns
end

describe PatternEvaluator do
  subject { PatternEvaluator.new(PatternRules) }
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

  it "should find match for each model element" do
    subject.run(model, patterns).matches.size.should == model.size
  end

end
