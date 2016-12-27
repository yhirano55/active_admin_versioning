shared_examples :example_show_resource_attribute do

  let(:expected_title) { raise 'Define expected title' }

  it 'resource attribute table contains proper values' do
    within '#main_content .attributes_table' do
      expect(page).to have_css('.row-title td:last-child', text: expected_title)
    end
  end

end
