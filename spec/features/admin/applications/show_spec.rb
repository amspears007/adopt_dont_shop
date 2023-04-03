require 'rails_helper'

RSpec.describe 'Admin Applications Show Page', type: :feature do
  let!(:applicant1) { Application.create!(name: "Jamison Ordway", street_address: '123 Cat St', city: 'Denver', state: 'CO', zip_code: 80238, description:"I love cats so I want to adopt them", status: 'Pending') }
  let!(:shelter_1) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let!(:shelter_2) { Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5) }
  let!(:shelter_3) {Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}
  let!(:pet1) {Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: shelter_3.id)}
  let!(:pet2) {Pet.create!(adoptable: false, age: 2, breed: 'american shorthair', name: 'Furry', shelter_id: shelter_3.id)}
  let!(:pet1_application) { PetApplication.create!(application_id: applicant1.id, pet_id: pet1.id)}
  let!(:pet2_application) { PetApplication.create!(application_id: applicant1.id, pet_id: pet2.id)}


  describe "User Story 12 When I visit an admin application show page ('/admin/applications/:id')" do
    it 'I see a button or every pet that the application is for that specific pet' do
      visit"/admin/applications/#{applicant1.id}"
      save_and_open_page

      expect(page).to have_button("Approve George Hairlesson's Application")
      expect(page).to have_content('George Hairlesson')
    end

    it "When I click that button
    Then I'm taken back to the admin application show page
    And next to the pet that I approved the button is gone and I see a message
    that the pet has been approved" do
    visit"/admin/applications/#{applicant1.id}"
    save_and_open_page

    click_link("Approve George Hairlesson's Application")

    expect(current_path).to eq("/admin/applications/#{applicant1.id}")
    expect(page).to_not have_button("Approve George Hairlesson's Application")
    expect(page).to have_content("#{pet1.name} Approved")
    end
  end
end