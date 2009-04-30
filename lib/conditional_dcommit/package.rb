module ConditionalDcommit
  class Package
    def self.data_path
      File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'data'))
    end

    def self.data_file(filename)
      File.join(data_path, filename)
    end
  end
end
