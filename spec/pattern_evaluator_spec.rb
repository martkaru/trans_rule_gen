require 'spec_helper'

def build_model
  elements = []
  elements << UiModel::DateEntryField.new(:name => 'from')
  #elements << UiModel::DateEntryField.new(:name => 'to')
  elements
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
  let(:constraints) { Constraints::Constraint.new(
                      :view_port_size => 50,
                      :user_skill_level => 50
                    )}

  def run
    subject.run(model, patterns, constraints)
  end

  def best_match_for(e)
    run.best_match_for(e)
  end

  context "without constraints" do
    it "should generate no matches if no input is given" do
      subject.run([], [], []).matches.should be_empty
    end

    it "should generate no matches, if no patterns are given" do
      subject.run(model, [], []).matches.should be_empty
    end

    it "should generate no matches, if no model elements are given" do
      subject.run([], patterns, []).matches.should be_empty
    end

    it "should find match for each model element" do
      subject.run(model, patterns, []).matches.size.should == model.size
    end
  end

  context "with large viewport size" do
    before(:each) do
      constraints.view_port_size = 90
    end

    context "with expert user skill level" do
      before(:each) do
        constraints.user_skill_level = 90
      end
      specify { best_match_for(model.first).pattern.should be_kind_of(MultiTextBoxDatePattern) }
    end

    context "with average user skill level" do
      before(:each) do
        constraints.user_skill_level = 50
      end
      specify { best_match_for(model.first).pattern.should be_kind_of(SingleMonthCalendarPattern) }
    end

    context "with novice user skill level" do
      before(:each) do
        constraints.user_skill_level = 10
      end
      specify { best_match_for(model.first).pattern.should be_kind_of(SingleYearCalendarPattern) }
    end
  end

  context "with medium viewport size" do
    before(:each) do
      constraints.view_port_size = 50
    end

    context "with expert user skill level" do
      before(:each) do
        constraints.user_skill_level = 90
      end
      specify { best_match_for(model.first).pattern.should be_kind_of(MultiTextBoxDatePattern) }
    end

    context "with average user skill level" do
      before(:each) do
        constraints.user_skill_level = 50
      end
      specify { best_match_for(model.first).pattern.should be_kind_of(SingleMonthCalendarPattern) }
    end

    context "with novice user skill level" do
      before(:each) do
        constraints.user_skill_level = 10
      end
      specify { best_match_for(model.first).pattern.should be_kind_of(SingleMonthCalendarPattern) }
    end
  end

  context "with small viewport size" do
    before(:each) do
      constraints.view_port_size = 20
    end

    context "with expert user skill level" do
      before(:each) do
        constraints.user_skill_level = 90
      end
      specify { best_match_for(model.first).pattern.should be_kind_of(TextBoxDatePattern) }
    end

    context "with average user skill level" do
      before(:each) do
        constraints.user_skill_level = 50
      end
      specify { best_match_for(model.first).pattern.should be_kind_of(MultiSelectDatePattern) }
    end

    context "with novice user skill level" do
      before(:each) do
        constraints.user_skill_level = 10
      end
      specify { best_match_for(model.first).pattern.should be_kind_of(MultiSelectDatePattern) }
    end
  end

end
