class Project
  attr_accessor :name, :path

  PROJECT_PATH = Config.root + '/projects'

  def self.all
    Dir["#{Config.root}/projects/*"].map do |path|
      Project.new(:name => path.split('/').last)
    end
  end

  def initialize(attributes = {})
    attributes.each do |k,v|
      self.send("#{k}=".to_sym, v)
    end
  end

  def path
    [PROJECT_PATH, name].join('/')
  end

  def stages
    Dir["#{path}/deploy/*", ".rb"].map {|deploy_path| deploy_path.split('/').last}
  end

  def deploy_path(stage = nil)
    [path, 'deploy', stage].compact.join('/') + ".rb"
  end

  def deploy_to(stage)
    system("cap deploy -f #{deploy_path} -f #{deploy_path(stage)}") if stages.include?(stage)
  end

  def ==(other)
    self.name == other.name
  end
end
