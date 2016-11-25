module ActiveAdminVersioning
  module ActiveAdmin
    module ResourceController
      def self.included(base)
        base.before_action(:set_paper_trail_whodunnit)
      end

      def show
        page = params[:page].to_i
        @versions = resource.versions.reorder(id: :desc, created_at: :desc).page(params[:page]).per(1)
        @version_number = page > 0 ? @versions.total_count - (page - 1) : @versions.total_count
        set_resource_ivar(@versions[0].reify) if @versions.present?
        show!
      end

      protected

      def user_for_paper_trail
        respond_to?(:current_admin_user) ? current_admin_user.id : t("views.version.unknown_user")
      end
    end
  end
end
