module ActiveAdminVersioning
  module ActiveAdmin
    module Application
      def register(*arg, &block)
        super(*arg) do
          versioning
          instance_eval(&block)
        end
      end
    end
  end
end
