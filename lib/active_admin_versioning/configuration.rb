module ActiveAdminVersioning
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end


  class Configuration
    attr_accessor :whodunnit_attribute_name, :display_version_diff, :display_version_link

    def initialize
      @whodunnit_attribute_name = :whodunnit
      @display_version_diff = false
      @display_version_link = true
    end
  end
end
