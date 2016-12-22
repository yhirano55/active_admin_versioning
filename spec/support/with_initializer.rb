shared_context :with_initializer do

  let(:whodunnit_attribute_name) do
    :display_whodunnit
  end

  before do
    ActiveAdminVersioning.configure do |config|
      config.whodunnit_attribute_name = whodunnit_attribute_name
    end
  end

  after :each do
    # restore defaults
    ActiveAdminVersioning.configure do |config|
      config.whodunnit_attribute_name = :whodunnit
    end
  end

end
