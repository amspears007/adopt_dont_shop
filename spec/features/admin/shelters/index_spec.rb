require 'rails_helper'

RSpec.describe 'Admin Shelters Index Page', type: :feature do
  let!(:applicant1) { Application.create!(name: "Jamison Ordway", street_address: '123 Cat St', city: 'Denver', state: 'CO', zip_code: 80238, description:"I love cats so I want to adopt them", status: 'In Progress') }
  let!(:shelter_1) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let!(:shelter_2) { Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5) }
  let!(:shelter_3) {Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}
  let!(:pet1) {Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: shelter_3.id)}
  let!(:pet2) {Pet.create!(adoptable: false, age: 2, breed: 'american shorthair', name: 'Furry', shelter_id: shelter_3.id)}

  describe 'User Story 10' do
    it 'displays all shelters in the system in reverse alphabetical order by name' do
      visit "/admin/shelters"

      expect("RGV animal shelter").to appear_before("Fancy pets of Colorado")
      expect("Fancy pets of Colorado").to appear_before("Aurora shelter")
    end
  end
#   Admin Shelters Index
# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see all Shelters in the system listed in reverse alphabetical order by name
end