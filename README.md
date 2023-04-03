Visitors to the site will be able to create applications to adopt pets. An application has many pets. Pets can have many applications.

Table Diagram: [https://dbdiagram.io/d/642095e55758ac5f17243e50]

[ ] done

12. Approving a Pet for Adoption

As a visitor
When I visit an admin application show page ('/admin/applications/:id')
For every pet that the application is for, I see a button to approve the application for that specific pet
When I click that button
Then I'm taken back to the admin application show page
And next to the pet that I approved, I do not see a button to approve this pet
And instead I see an indicator next to the pet that they have been approved

[ ] done

13. Rejecting a Pet for Adoption

As a visitor
When I visit an admin application show page ('/admin/applications/:id')
For every pet that the application is for, I see a button to reject the application for that specific pet
When I click that button
Then I'm taken back to the admin application show page
And next to the pet that I rejected, I do not see a button to approve or reject this pet
And instead I see an indicator next to the pet that they have been rejected
# Adopt, don't Shop

This is a paired project used in Turing School's Backend Program Module 2.

## Learning Goals

In this project, students will build upon the code in this repo to create a Pet Adoption Platform. Users will be able to apply to adopt pets, and Admins will be able to approve or reject applications and see statistics for the Shelters, Pets, and Applications in the system.

* Build out CRUD functionality for a many to many relationship
* Use ActiveRecord to write queries that join multiple tables of data together
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Validate models and handle sad paths for invalid data input
* Use flash messages to give feedback to the user
* Use partials in views
* Use `within` blocks in tests
* Track user stories using GitHub Projects
* Deploy your application to the internet

## Requirements
* Project must use Rails 5.2.x, Ruby 2.7.4, and PostgreSQL
* Use of `resources` on this project is not permitted
* Use of scaffolding on this project is not permitted
* Students wanting to use any extra gems on this project must first get permission from your instructors
  * Pre-approved gems are `capybara, pry, faker, factorybot, orderly, simplecov, shoulda-matchers, launchy`

## Project Phases

1. [Set Up](./doc/set_up.md)
1. [User Stories](./doc/user_stories.md)
1. [Evaluation](./doc/evaluation.md)

## Check In

This project will have one Check In. During your Check In, you should be prepared to review your database schema for the many to many relationship, your deployment to Heroku, and your GitHub Projects board.

