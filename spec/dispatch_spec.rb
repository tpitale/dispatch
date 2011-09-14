require 'spec_helper'

describe "Dispatch" do
  context "on GET to /" do
    before :each do
      Project.stubs(:all).returns([])
      get '/'
    end

    it "lists all projects" do
      Project.should have_received(:all)
    end
  end
end
