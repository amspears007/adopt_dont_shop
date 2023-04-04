require 'rails_helper'

RSpec.describe 'Admin Applications Show Page', type: :feature do
  let!(:applicant1) { Application.create!(name: "Jamison Ordway", street_address: '123 Cat St', city: 'Denver', state: 'CO', zip_code: 80238, description:"I love cats so I want to adopt them", status: 'Pending') }
  let!(:applicant2) { Application.create!(name: "Brian Guthrie", street_address: '123 Dog St', city: 'Springs', state: 'CO', zip_code: 80123, description:"I love dogs so I want to adopt them", status: 'Pending') }
  let!(:applicant3) { Application.create!(name: "Amy Spears", street_address: '123 Animal House St', city: 'Denver', state: 'CO', zip_code: 80238, description:"No more animals, too stressed from Turing!", status: 'In Progress') }

  let!(:applicant1) { Application.create!(name: "Jamison Ordway", street_address: '123 Cat St', city: 'Denver', state: 'CO', zip_code: 80238, description:"I love cats so I want to adopt them") }
let!(:applicant2) { Application.create!(name: "Brian Guthrie", street_address: '123 Dog St', city: 'Springs', state: 'CO', zip_code: 80123, description:"I love dogs so I want to adopt them") }
let!(:applicant3) { Application.create!(name: "Amy Spears", street_address: '123 Animal House St', city: 'Denver', state: 'CO', zip_code: 80238, description:"No more animals, too stressed from Turing!") }

let!(:shelter_1) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
let!(:shelter_2) { Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5) }
let!(:shelter_3) {Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}

let!(:pet1) {Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: shelter_3.id)}
let!(:pet2) {Pet.create!(adoptable: false, age: 2, breed: 'american shorthair', name: 'Furry', shelter_id: shelter_3.id)}
let!(:pet3) { shelter_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true) }
let!(:pet4) { shelter_2.pets.create(name: 'Winston', breed: 'collie', age: 3, adoptable: true) }
let!(:pet5) { shelter_3.pets.create(name: 'Mach', breed: 'schnauzer', age: 13, adoptable: true) }
let!(:pet6) { shelter_2.pets.create(name: 'Max', breed: 'huge weiner dog', age: 9, adoptable: true) }

let!(:pet1_application) { PetApplication.create!(application_id: applicant1.id, pet_id: pet1.id)}
let!(:pet2_application) { PetApplication.create!(application_id: applicant1.id, pet_id: pet2.id)}
let!(:pet3_application) { PetApplication.create!(application_id: applicant2.id, pet_id: pet4.id) }
let!(:pet4_application) { PetApplication.create!(application_id: applicant2.id, pet_id: pet2.id) }
let!(:pet5_application) { PetApplication.create!(application_id: applicant3.id, pet_id: pet6.id) }


  describe "User Story 12 When I visit an admin application show page ('/admin/applications/:id')" do
    it 'I see an approve button for every pet that the application is for that specific pet' do
      visit"/admin/applications/#{applicant1.id}"

      expect(page).to have_button("Approve George Hairlesson's Application")
      expect(page).to have_content('George Hairlesson')
    end

    it "When I click that button then im taken back to the admin application show page and next to the pet that I approved the button is gone and I see a message that the pet has been approved" do
    visit"/admin/applications/#{applicant1.id}"  

    click_link("Approve George Hairlesson's Application")

    expect(current_path).to eq("/admin/applications/#{applicant1.id}")
    expect(page).to_not have_button("Approve George Hairlesson's Application")
    expect(page).to have_content("#{pet1.name} Approved")
    end
  end

  describe "User Story 13 When I visit an admin application show page ('/admin/applications/:id')" do
    it 'I see a reject button for every pet that the application is for that specific pet' do
      visit"/admin/applications/#{applicant1.id}"

      expect(page).to have_button("Reject George Hairlesson's Application")
      expect(page).to have_content('George Hairlesson')
    end

    it "When I click that button then im taken back to the admin application show page and next to the pet that I rejected the button is gone and I see a message that the pet has been rejected" do
    visit"/admin/applications/#{applicant1.id}"  

    click_link("Reject George Hairlesson's Application")

    expect(current_path).to eq("/admin/applications/#{applicant1.id}")
    expect(page).to_not have_button("Approve George Hairlesson's Application")
    expect(page).to have_content("#{pet1.name} Rejected")
    end
  end

  describe 'User Story 14 14. Approved/Rejected Pets on one Application do not affect other Applications' do
    it 'displays a button to approve or reject the application for the second applicant' do
      visit "/admin/applications/#{applicant1.id}"  
  
      click_link("Approve #{pet2.name}'s Application")
  
      visit "/admin/applications/#{applicant2.id}" 
  
      expect(page).to have_link("Approve #{pet2.name}'s Application")
      expect(page).to have_link("Reject #{pet2.name}'s Application")
    end
  end
end