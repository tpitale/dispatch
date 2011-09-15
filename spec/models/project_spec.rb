require 'spec_helper'

describe Project do
  context "The Project class" do
    it 'returns a list of all projects' do
      Dir.stubs(:[]).returns(["#{Configuration.root}/projects/opower"])
      Project.all.should == [Project.new(:name => "opower")]
      Dir.should have_received(:[]).with("#{Configuration.root}/projects/*")
    end
  end

  context "An instance of the Project class" do
    before :each do
      @project = Project.new(:name => 'opower')
      @project.stubs(:path).returns('/projects/opower')
    end

    it "knows if it is equal to another project" do
      @project == @project.dup
    end

    it "knows which stages it can deploy to" do
      Dir.stubs(:[]).returns(["/projects/opower/deploy/staging", "/projects/opower/deploy/production"])
      @project.stages.should == ["staging", "production"]
      Dir.should have_received(:[]).with("/projects/opower/deploy/*", ".rb")
    end

    it "has a deploy path" do
      @project.deploy_path.should == '/projects/opower/deploy.rb'
    end

    it "has a deploy path for a stage" do
      @project.deploy_path('staging').should == '/projects/opower/deploy/staging.rb'
    end

    it "deploys to a given stage" do
      File.stubs(:open).yields(stub(:write))
      @project.stubs(:stages).returns(["staging"])
      @project.stubs(:`).returns("a log of data")
      @project.deploy_to("staging")
      @project.should have_received(:`).with("cap -S stage=staging -f Capfile -f /projects/opower/deploy.rb -f /projects/opower/deploy/staging.rb -n deploy 2>&1")
    end

    it "doesn't deploy to an unknown stage" do
      @project.stubs(:stages).returns(["staging"])
      @project.stubs(:`)
      @project.deploy_to("production")
      @project.should have_received(:`).never
    end

    it "writes the deploy log returned to a logfile" do
      file = stub(:write)
      File.stubs(:open).yields(file)
      @project.stubs(:stages).returns(["staging"])
      @project.stubs(:`).returns("log log log")
      @project.deploy_to("staging")
      file.should have_received(:write).with("log log log")
    end
  end
end
