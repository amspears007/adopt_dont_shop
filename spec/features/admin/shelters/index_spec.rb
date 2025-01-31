require 'rails_helper'

RSpec.describe 'Admin Shelters Index Page', type: :feature do
  let!(:applicant1) { Application.create!(name: "Jamison Ordway", street_address: '123 Cat St', city: 'Denver', state: 'CO', zip_code: 80238, description:"I love cats so I want to adopt them", status: 'Pending') }
  let!(:shelter_1) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let!(:shelter_2) { Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5) }
  let!(:shelter_3) {Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}
  let!(:pet1) {Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: shelter_3.id)}
  let!(:pet2) {Pet.create!(adoptable: false, age: 2, breed: 'american shorthair', name: 'Furry', shelter_id: shelter_3.id)}
  let!(:pet1_application) { PetApplication.create!(application_id: applicant1.id, pet_id: pet1.id)}
  let!(:pet2_application) { PetApplication.create!(application_id: applicant1.id, pet_id: pet2.id)}


  describe 'User Story 10' do
    it 'displays all shelters in the system in reverse alphabetical order by name' do
      visit "/admin/shelters"

      expect("RGV animal shelter").to appear_before("Fancy pets of Colorado")
      expect("Fancy pets of Colorado").to appear_before("Aurora shelter")
    end
  end

  describe 'User Story 11' do
    it 'has a section for name of shelters with pending applications' do
      visit "/admin/shelters"

      expect(page).to have_content("Shelters with Pending Applications")
      expect(page).to have_content("Fancy pets of Colorado")
    end
  end
end