module ActiveAdminVersioning
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_files
      template "active_admin_versioning.rb", File.join("config", "initializers", "active_admin_versioning.rb")
    end

  end
end
