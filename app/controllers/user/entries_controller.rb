class User::EntriesController < ApplicationController
  before_filter :authenticate_user!, only: [:check_in]
  def index
    @entries = Entry.all
  end

  def show
    @entry = Entry.find(params[:id]) 
    respond_to do |format|
      format.html #show_entry.html.erb } 
      format.json { render json: @entry }
    end

  end


end
