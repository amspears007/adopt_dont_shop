require 'rails_helper'

RSpec.describe 'Application Show', type: :feature do
  let!(:applicant1) { Application.create!(name: "Jamison Ordway", street_address: '123 Cat St', city: 'Denver', state: 'CO', zip_code: 80238, description:"I love cats so I want to adopt them", status: 'In Progress') }
  let!(:shelter_3) {Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}
  let!(:pet1) {Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: shelter_3.id)}
  let!(:pet2) {Pet.create!(adoptable: false, age: 2, breed: 'american shorthair', name: 'Furry', shelter_id: shelter_3.id)}

  
  let!(:pet1_application) {PetApplication.create!(application_id: applicant1.id, pet_id: pet1.id)}
  let!(:pet2_application) {PetApplication.create!(application_id: applicant1.id, pet_id: pet2.id)}
  
  it 'I see applicants name, full address, descripition, name of all pets applying for and status'  do
    visit "/applications/#{applicant1.id}" 

    expect(page).to have_content('Jamison Ordway') 
    expect(page).to have_content('123 Cat St') 
    expect(page).to have_content("I love cats so I want to adopt them") 
    expect(page).to have_content('In Progress') 
    expect(page).to have_link(pet1.name)
    expect(page).to have_link(pet2.name)
  end

  describe 'User Story 4' do
    it 'has a link to add a pet to this application' do
      visit "/applications/#{applicant1.id}" 

      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_button("Submit")
    end

    it 'will display the pet name' do
      shelter_3.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'New Cat')
      visit "/applications/#{applicant1.id}" 
      
      fill_in("search", with: "New Cat")
      click_on("Submit")

      expect(current_path).to eq("/applications/#{applicant1.id}")
      expect(page).to have_content("New")
    end
  end

  describe 'User story 5' do
    it 'has a button next to the pets name to Adopt this Pet' do
      shelter_3.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'New Cat')
      visit "/applications/#{applicant1.id}" 
      # expected_id = Application.last.id

      fill_in("search", with: "New Cat")
      click_on("Submit")

      expect(page).to have_link("Adopt this Pet")

      click_link("Adopt this Pet")

      expect(current_path).to eq("/applications/#{applicant1.id}")
      expect(page).to have_content("New Cat")
    end
  end
end