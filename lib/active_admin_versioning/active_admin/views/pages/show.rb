# frozen_string_literal: true

module ActiveAdminVersioning
  module ActiveAdmin
    module Views
      module Pages
        module Show
          def main_content
            super

            return unless resource.respond_to?(:versions) && ActiveAdminVersioning.configuration.display_version_diff

            instance_exec resource, &version_diff_content
          end

          def version_diff_content # rubocop:disable Metrics/AbcSize
            proc do
              panel "Versions diff" do
                tabs do
                  resource.versions.count.times do |index|
                    tab "version #{index + 1}" do
                      version_diffs = resource.versions[index].changeset.map do |k, v|
                        { method: k, from: v[0], to: v[1] }
                      end

                      table_for version_diffs do
                        column :method do |res|
                          res[:method]
                        end
                        column :from do |res|
                          res[:from]
                        end
                        column :to do |res|
                          res[:to]
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end