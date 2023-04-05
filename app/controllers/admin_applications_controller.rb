class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pending_pets = @application.pets.includes(:pet_applications).where(pet_applications: {status: "Pending"})
    @approved_pets = @application.pets.includes(:pet_applications).where(pet_applications: {status: "Approved"})
    @rejected_pets = @application.pets.includes(:pet_applications).where(pet_applications: {status: "Rejected"})
  end

  def update
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @pet_application = PetApplication.find_by(pet_id: @pet.id, application_id: @application.id)
    @pet_application.update!(status: params[:adoption_status])
    redirect_to "/admin/applications/#{@application.id}"
  end
end