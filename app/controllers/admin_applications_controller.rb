class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets.includes(:pet_applications)
    @pending_pets = @application.pets.includes(:pet_applications)
    @pending_pets = @application.pets.includes(:pet_applications)

  end

  def update
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @pet_application = PetApplication.find_by(pet_id: @pet.id, application_id: @application.id)
    @pet_application.update!(status: params[:adoption_status])
    redirect_to "/admin/applications/#{@application.id}"
  end
end