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

    if  @application.save
      redirect_to "/applications/#{Application.last.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end

  def update
    @application = Application.find(params[:id])
    added_pet = Pet.find_by(name: params[:search])
    
    if params[:status] == "Pending"
      @application.update(status: params[:status], description: params[:description])
    else
      PetApplication.create(application_id: @application.id, pet_id: added_pet.id)
    end
    redirect_to "/applications/#{@application.id}"
  end

private
  def application_params
    params.require(:application).permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end

end