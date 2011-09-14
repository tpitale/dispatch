require 'spec_helper'

describe Project do
  context "The Project class" do
    it 'returns a list of all projects' do
      Project.all.should == []
    end
  end
end
