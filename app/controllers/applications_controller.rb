class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)

    if @application.save
      redirect_to "/applications/#{Application.last.id}"
    else
      render :new
    end
  end

  def update
    @application = Application.find(params[:id])
    added_pet= Pet.find_by(name: params[:search])
    pet_app = PetApplication.create(application_id: @application.id, pet_id: added_pet.id)
    redirect_to "/applications/#{@application.id}"
  end

private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end