module ActiveAdminVersioning
  module ActiveAdmin
    module DSL
      def versioning
        return unless enabled_paper_trail?

        active_admin_namespace = config.namespace.name

        controller { include ActiveAdminVersioning::ActiveAdmin::ResourceController }

        member_action(:versions) do
          @versions   = resource.versions.reorder(id: :desc, created_at: :desc).page(params[:page])
          @page_title = ::PaperTrail::Version.model_name.human
          render "versions"
        end

        with_options only: :show do
          action_item :version do
            link_to [:versions, active_admin_namespace, resource_instance_name] do
              ::PaperTrail::Version.model_name.human
            end
          end

          sidebar ::PaperTrail::Version.model_name.human do
            if versions.present?
              attributes_table_for versions[0] do
                row ::PaperTrail::Version.model_name.human do |_|
                  version_number
                end
                row :event, &:event_i18n
                row :whodunnit do |record|
                  record.send(ActiveAdminVersioning.configuration.whodunnit_attribute_name).presence ||
                      span(t("views.version.unknown_user"), class: "empty")
                end
                row :created_at
              end
              paginate versions, theme: :version
            else
              I18n.t("views.version.empty", model_name: ::PaperTrail::Version.model_name.human)
            end
          end
        end
      end

      private

      def enabled_paper_trail?
        if config.resource_class.respond_to?(:paper_trail)
          enabled = ::PaperTrail.request.try(:enabled_for_model?, config.resource_class)
          return enabled  unless enabled.nil?
          config.resource_class.paper_trail.try(:enabled?)
        else
          config.resource_class.try(:paper_trail_enabled_for_model?)
        end
      end
    end
  end
end
