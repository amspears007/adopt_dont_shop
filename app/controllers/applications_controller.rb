class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @new_application = Application.create!(application_params)
    if @new_application.valid?
     @new_application.save
    redirect_to "/applications/#{@new_application.id}"
    else
      render :new
    end
  end

private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end