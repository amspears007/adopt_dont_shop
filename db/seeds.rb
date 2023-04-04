# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all
PetApplication.destroy_all

@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
@pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
@pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@pet_3 = @shelter_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
@pet_4 = @shelter_2.pets.create(name: 'Winston', breed: 'collie', age: 3, adoptable: true)
@pet_5 = @shelter_3.pets.create(name: 'Mach', breed: 'schnauzer', age: 13, adoptable: true)
@pet_6 = @shelter_2.pets.create(name: 'Max', breed: 'huge weiner dog', age: 9, adoptable: true)

@applicant1 = Application.create!(name: "Jamison Ordway", street_address: '123 Cat St', city: 'Aurora', state: 'CO', zip_code: 80238, description:"I love cats so I want to adopt them")
@applicant2 = Application.create!(name: "Brian Guthrie", street_address: '123 Dog St', city: 'Springs', state: 'CO', zip_code: 80123, description:"I love dogs so I want to adopt them")
@applicant3 = Application.create!(name: "Amy Spears", street_address: '123 Animal House St', city: 'Denver', state: 'CO', zip_code: 80238, description:"No more animals, too stressed from Turing!")

@pet1_application = PetApplication.create!(application_id: @applicant1.id, pet_id: @pet_1.id)
@pet2_application = PetApplication.create!(application_id: @applicant1.id, pet_id: @pet_3.id)
@pet3_application = PetApplication.create!(application_id: @applicant2.id, pet_id: @pet_4.id)
@pet4_application = PetApplication.create!(application_id: @applicant2.id, pet_id: @pet_5.id)
@pet5_application = PetApplication.create!(application_id: @applicant3.id, pet_id: @pet_6.id)