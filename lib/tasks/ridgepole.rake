namespace :ridgepole do
  task apply: :environment do
    ridgepole('--apply')
    Rake::Task['db:schema:dump'].invoke
  end
  
  private
  
  def config_file
    Rails.root.join("config/database.yml")
  end

  def schema_file
    Rails.root.join("db/Schemafile")
  end

  def ridgepole(*options)
    command = ['bundle exec ridgepole', "--file #{schema_file}", "--config #{config_file}"]
    system [command + options].join(' ')
  end
end
