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

      fill_in("search", with: "New Cat")
      click_on("Submit")

      expect(page).to have_link("Adopt this Pet")

      click_link("Adopt this Pet")

      expect(current_path).to eq("/applications/#{applicant1.id}")
      expect(page).to have_content("New Cat")
    end
  end

  describe 'User Story 6' do
    it ' as a visitor will have a section to submit my application as long as a pet is attached' do
      visit "/applications/#{applicant1.id}"

      expect(page).to have_content("Submit Application")
      expect(page).to have_button("Submit Application")
    end

    it 'when the form is filled and submitted the application status changes to pending' do
      visit "/applications/#{applicant1.id}"

      fill_in("Description", with: "I love cats so I want to adopt them a lot")
      click_on("Submit Application")

      expect(page).to have_content("Pending")
      expect(page).to have_no_content("In Progress")
      expect(page).to have_content("I love cats so I want to adopt them a lot")
      expect(page).to have_no_content("Add a Pet to this Application")
    end
  end

  describe 'User Story 7' do
    it 'does not have a section to submit my application if a pet has not been added' do
      applicant2 = Application.create!(name: "Brian Guthrie", street_address: '123 Dog St', city: 'Springs', state: 'CO', zip_code: 80238, description:"I love dogs so I want to adopt them", status: 'In Progress') 
      visit "/applications/#{applicant2.id}"
      
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to_not have_content('Submit Application')
      expect(page).to_not have_content("Furry")
    end
  end

  describe 'User Story 8' do
    it 'can search for partial matches of pet names' do
      shelter_3.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'New Cat')
      visit "/applications/#{applicant1.id}"

      fill_in("search", with: "Ne")
      click_on("Submit")
save_and_open_page
      expect(page).to have_content("New Cat")
    end
  end

  describe 'User Story 9' do
    it 'can search for pet case insensitive' do
      shelter_3.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'New Cat')
      visit "/applications/#{applicant1.id}"

      fill_in("search", with: "NeW cAt")
      click_on("Submit")

      expect(page).to have_content("New Cat")
    end
  end
end