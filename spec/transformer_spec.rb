require 'spec_helper'

describe Transformer do
  subject { Transformer.new }
  let(:model) { Factory.build_model }
  let(:constraints) { Factory.build_constraints }

  it "should generate a web ui model" do
    subject.transform(model, constraints).should_not be_empty
  end

  it "should generate a web ui model that can be transformed to html" do
    subject.transform(model, constraints).map(&:render).should == [
      "<div class=\"month_calendar\" data-name=\"from\">",
      "<div class=\"month_calendar\" data-name=\"to\">"
    ]
  end
end
