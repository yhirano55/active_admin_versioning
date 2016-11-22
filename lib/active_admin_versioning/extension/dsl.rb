module ActiveAdminVersioning
  module Extension
    module DSL
      def versioning
        return unless config.resource_class.try(:paper_trail_enabled_for_model?)

        controller { include ActiveAdminVersioning::Extension::ResourceController }

        member_action(:versions) do
          @versions   = resource.versions.reorder(id: :desc, created_at: :desc).page(params[:page])
          @page_title = ::PaperTrail::Version.model_name.human
          render "versions"
        end

        action_item(:version, only: :show) do
          link_to send("versions_admin_#{resource_instance_name}_path") do
            ::PaperTrail::Version.model_name.human
          end
        end

        sidebar(::PaperTrail::Version.model_name.human, only: :show) do
          if versions.present?
            attributes_table_for versions[0] do
              row(::PaperTrail::Version.model_name.human) { |_| version_number }
              row(:event, &:event_i18n)
              row(:whodunnit) do |record|
                record.whodunnit.presence || span(t("views.version.unknown_user"), class: "empty")
              end
              row(:created_at)
            end
            paginate(versions, theme: :version)
          else
            I18n.t("views.version.empty", model_name: ::PaperTrail::Version.model_name.human)
          end
        end
      end
    end
  end
end
