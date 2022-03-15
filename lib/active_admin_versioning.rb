require "active_admin"
require "paper_trail/version_concern"
require "active_admin_versioning/engine"
require "active_admin_versioning/configuration"
require "active_admin_versioning/active_admin/application"
require "active_admin_versioning/active_admin/dsl"
require "active_admin_versioning/active_admin/resource_controller"
require "active_admin_versioning/active_admin/views/pages/show"
require "active_admin_versioning/paper_trail/version_concern"

::ActiveAdmin::Views::Pages::Show.send :prepend, ActiveAdminVersioning::ActiveAdmin::Views::Pages::Show
::ActiveAdmin::Application.send :prepend, ActiveAdminVersioning::ActiveAdmin::Application
::ActiveAdmin::DSL.send :include, ActiveAdminVersioning::ActiveAdmin::DSL
::PaperTrail::VersionConcern.send :include, ActiveAdminVersioning::PaperTrail::VersionConcern
