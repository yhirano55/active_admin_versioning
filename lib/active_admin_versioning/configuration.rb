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
    attr_accessor :whodunnit_attribute_name

    def initialize
      @whodunnit_attribute_name = :whodunnit
    end
  end
end
