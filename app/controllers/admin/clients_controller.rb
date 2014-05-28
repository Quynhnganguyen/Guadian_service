class Admin::ClientsController < ApplicationController
  # GET /admin/clients
  # GET /admin/clients.json
  def index
    @clients = Client.all
  end

  def destroy

    @client = Client.find(params[:id]) 
    @client.destroy

    respond_to do |format|
      format.html { redirect_to admin_clients_url }
      format.json { head :no_content }
    end

  end

  def new
  end

 
end
