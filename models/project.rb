class Project
  attr_accessor :name

  PROJECT_PATH = Configuration.root + '/projects'

  def self.all
    Dir["#{Configuration.root}/projects/*"].map do |path|
      Project.new(:name => path.split('/').last)
    end
  end

  def self.find(name)
    all.detect {|p| p.name == name}
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
    Dir["#{path}/deploy/*", ".rb"].map {|deploy_path| deploy_path.split('/').last.gsub('.rb', '')}
  end

  def deploy_path(stage = nil)
    [path, 'deploy', stage].compact.join('/') + ".rb"
  end

  def log_filename(stage)
    "#{path}/logs/#{Time.now.to_i}-#{stage}.log"
  end

  def deploy_to(stage)
    if stages.include?(stage)
      deploy_logs = `cap -S stage=#{stage} -f Capfile -f #{deploy_path} -f #{deploy_path(stage)} -n deploy 2>&1`
      File.open(log_filename(stage), 'w') {|f| f.write(deploy_logs)}
      deploy_logs
    end
  end

  def ==(other)
    self.name == other.name
  end
end
