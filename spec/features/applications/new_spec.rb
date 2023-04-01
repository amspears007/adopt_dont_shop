require 'rails_helper'

RSpec.describe "/applications/new" do
  let!(:applicant1) { Application.create!(name: "Jamison Ordway", street_address: '123 Cat St', city: 'Denver', state: 'CO', zip_code: 80238, description:"I love cats so I want to adopt them", status: 'In Progress') }
  it 'has a form to create a new application' do
    visit "/applications/new"

    expect(page).to have_field("Name")
    expect(page).to have_field("Street address")
    expect(page).to have_field("City")
    expect(page).to have_field("State")
    expect(page).to have_field("Zip code")
    expect(page).to have_field("Description")
    expect(page).to have_button("Submit")
  end
  
  it 'can create a new application and returns to the show page' do
    visit "/applications/new"
    
    fill_in("Name", with: "#{applicant1.name}")
    fill_in("Street address", with: "#{applicant1.street_address}")
    fill_in("City", with: "#{applicant1.city}")
    fill_in("State", with: "#{applicant1.state}")
    fill_in("Zip code", with: "#{applicant1.zip_code}")
    fill_in("Description", with: "#{applicant1.description}")
    click_button("Submit")
    expected_id = Application.last.id
    expect(current_path).to eq("/applications/#{expected_id}")
    
    expect(page).to have_content("#{applicant1.name}")
    expect(page).to have_content("#{applicant1.street_address}")
    expect(page).to have_content("#{applicant1.city}")
    expect(page).to have_content("#{applicant1.state}")
    expect(page).to have_content("#{applicant1.zip_code}")
    expect(page).to have_content("#{applicant1.description}")
    expect(page).to have_content("#{applicant1.status}")
  end
  
  it 'it will redirect user if an application field is blank and displays error' do
    visit "/applications/new"

    click_button("Submit")

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Please fix these errors:")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Street address can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Zip code can't be blank")
    expect(page).to have_content("Zip code is not a number")
  end
end