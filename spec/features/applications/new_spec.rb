require 'rails_helper'

RSpec.describe "/applications/new" do
  let!(:applicant1) { Application.create!(name: "Jamison Ordway", street_address: '123 Cat St', city: 'Denver', state: 'CO', zip_code: 80238, description:"I love cats so I want to adopt them", status: 'In Progress') }
  it 'has a form to create a new application' do
    visit "/applications/#{applicant1.id}/new"
save_and_open_page
    expect(page).to have_field("Name")
    expect(page).to have_field("Street address")
    expect(page).to have_field("City")
    expect(page).to have_field("State")
    expect(page).to have_field("Zip code")
    expect(page).to have_field("Description")
    expect(page).to have_button("Submit")
  end
end

# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"