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
@applicant1 = Application.create!(name: "Jamison Ordway", street_address: '123 Cat St', city: 'Denver', state: 'CO', zip_code: 80238, description:"I love cats so I want to adopt them", status: 'In Progress')
@pet1_application = PetApplication.create!(application_id: @applicant1.id, pet_id: @pet_1.id)
@pet2_application = PetApplication.create!(application_id: @applicant1.id, pet_id: @pet_2.id)