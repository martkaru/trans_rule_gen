require 'spec_helper'

describe PatternEvaluator do
  subject { PatternEvaluator.new(PatternRules) }
  let(:model) { Factory.build_model }
  let(:patterns) { Factory.build_patterns }
  let(:constraints) { Factory.build_constraints }

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
