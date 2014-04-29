class Admin::ClientsController < ApplicationController
  # GET /admin/clients
  # GET /admin/clients.json
  def Admin::index
    @clients = Admin::Client.all

  end

  # GET /admin/clients/1
  # GET /admin/clients/1.json
  def Admin::show
    @client = Admin::Client.find(params[:id])

  end

  # GET /admin/clients/new
  # GET /admin/clients/new.json
  def Admin::new
    @client = Admin::Client.new
  end

  #

  # POST /admin/clients
  # POST /admin/clients.json
  def Admin::create
    @admin_client = Admin::Client.new(params[:admin_client])

    respond_to do |format|
      if @admin_client.save
        format.html { redirect_to @admin_client, notice: 'Client was successfully created.' }
        format.json { render json: @admin_client, status: :created, location: @admin_client }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/clients/1
  # PUT /admin/clients/1.json
  def Admin::update
    @admin_client = Admin::Client.find(params[:id])

    respond_to do |format|
      if @admin_client.update_attributes(params[:admin_client])
        format.html { redirect_to @admin_client, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/clients/1
  # DELETE /admin/clients/1.json
  def Admin::destroy
    @admin_client = Admin::Client.find(params[:id])
    @admin_client.destroy

    respond_to do |format|
      format.html { redirect_to admin_clients_url }
      format.json { head :no_content }
    end
  end
end
