class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    require 'pry'; binding.pry
  end

end