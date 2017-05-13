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
    attr_accessor :whodunnit_attribute_name, :user_for_paper_trail

    def initialize
      @whodunnit_attribute_name = :whodunnit
      @user_for_paper_trail     = :admin_user_for_paper_trail
    end
  end
end
