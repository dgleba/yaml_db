module YamlDb
  module RakeTasks
    def self.data_dump_task
      SerializationHelper::Base.new(helper).dump(db_dump_data_file(helper.extension))
    end

    ENV["dir"]='yamldb'

    def self.data_dump_dir_task
      
      #   if env dir is not set, use yamldb_date/ folder... David Gleba 2016-07-27_Wed_09.10-AM
      system 'mkdir', '-p', 'db/yamldb_date'
      # set env dir...
      # ENV["dir"]='yamldb'
      dir = ENV['dir'] || "yamldb_date/#{Time.now.strftime('%F_%H.%M.%S')}"

      #dir = ENV['dir'] || "#{yaml_db\Time.now.strftime('%F_%H.%M.%S')}"
      SerializationHelper::Base.new(helper).dump_to_dir(dump_dir("/#{dir}"))
    end

    def self.data_load_task
      SerializationHelper::Base.new(helper).load(db_dump_data_file(helper.extension))
    end

    def self.data_load_dir_task
      dir = ENV['dir'] || 'base'
      SerializationHelper::Base.new(helper).load_from_dir(dump_dir("/#{dir}"))
    end

    private

    def self.db_dump_data_file(extension = 'yml')
      "#{dump_dir}/data.#{extension}"
    end

    def self.dump_dir(dir = '')
      "#{Rails.root}/db#{dir}"
    end

    def self.helper
      format_class = ENV['class'] || 'YamlDb::Helper'
      format_class.constantize
    end
  end
end
