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
        if @versions.any? && @versions[0].next.present?
          res = apply_decorations(@versions[0].next.reify)
          set_resource_ivar(res)
        end

        show!
      end

      protected

      def user_for_paper_trail
        if current_user_method && respond_to?(current_user_method)
          public_send(current_user_method).try!(:id)
        else
          t("views.version.unknown_user")
        end
      end

      private

      def current_user_method
        @_current_user_method ||= active_admin_namespace.current_user_method
      end
    end
  end
end
