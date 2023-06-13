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
                          filter_field(res[:method], res[:from])
                        end

                        column :to do |res|
                          filter_field(res[:method], res[:to])
                        end
                      end
                    end
                  end
                end
              end
            end
          end

          def filter_field(method, value)
            decrypt_value = decrypt_field(method, value)
            filter_method = filter_methods[method]
            filter_method.present? ? filter_method.call(decrypt_value) : decrypt_value
          end

          def filter_methods
            ActiveAdminVersioning.configuration.filter_methods.with_indifferent_access
          end

          def decrypt_field(method, value)
            if method.end_with? "_ciphertext"
              decrypte_value(method, value)
            else
              value
            end
          rescue Lockbox::DecryptionError
            value
          end

          def decrypte_value(method, value)
            return resource.class.send(decrypted_method(method), value) if klass.respond_to? decrypted_method(method)

            value
          end

          def base_method(method)
            method.match(/(.*)_ciphertext/)[1]
          end

          def decrypted_method(method)
            "decrypt_#{method}"
          end
        end
      end
    end
  end
end