module Carto::Configuration
  def db_config
    @@db_config ||= YAML.load(File.read(db_config_file))
  end

  def app_config
    @@app_config = YAML.load_file(app_config_file)
  end

  private

  def config_files_root
    if ENV['RAILS_CONFIG_BASE_PATH']
      Pathname.new(ENV['RAILS_CONFIG_BASE_PATH'])
    else
      Rails.root
    end
  end

  def db_config_file
    if ENV['RAILS_DATABASE_FILE']
      File.join(config_files_root, 'config/' + ENV['RAILS_DATABASE_FILE'])
    else
      File.join(config_files_root, 'config/database.yml')
    end
  end

  def app_config_file
    "#{config_files_root}/config/app_config.yml"
  end
end

# TODO: singleton
class Carto::Conf
  include Carto::Configuration
end