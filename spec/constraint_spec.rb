require 'spec_helper'

describe Constraints::Constraint do
  it "should initialize instance var" do
    Constraints::Constraint.new(:view_port_size => 4).view_port_size.should == 4
  end
end
