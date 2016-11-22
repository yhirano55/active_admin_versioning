require "yaml"

module ActiveAdminVersioning
  module Extension
    module PaperTrail
      def item_class
        item_type.safe_constantize
      end

      def item_class_i18n
        item_class.try(:model_name).try(:human) || item_type
      end

      def item_column_names
        item_class.column_names
      end

      def item_attributes
        YAML.load(object).slice(*item_column_names)
      rescue
        nil
      end

      def item_instance
        @item_instance ||= item_buildable? ? item_class.new(item_attributes) : nil
      end

      def event_i18n
        I18n.t("views.version.event.#{event}", default: event)
      end

      private

      def item_buildable?
        item_class && item_attributes
      end
    end
  end
end
