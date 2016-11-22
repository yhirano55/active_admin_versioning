require "rails"

module ActiveAdminVersioning
  class Engine < ::Rails::Engine
    config.after_initialize do
      require "active_admin_versioning/extension/application"
      require "active_admin_versioning/extension/dsl"
      require "active_admin_versioning/extension/resource_controller"
      require "active_admin_versioning/extension/paper_trail"

      ::ActiveAdmin::Application.send :prepend, ActiveAdminVersioning::Extension::Application
      ::ActiveAdmin::DSL.send :include, ActiveAdminVersioning::Extension::DSL
      ::PaperTrail::Version.send :include, ActiveAdminVersioning::Extension::PaperTrail
    end
  end
end
