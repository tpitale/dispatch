module Config
  extend self

  def root
    File.expand_path(File.dirname(__FILE__))
  end

  def environment
    (ENV["RACK_ENV"] || ENV["APP_ENV"] || 'development').to_sym
  end
end