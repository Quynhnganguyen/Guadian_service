class Api::EntriesController < ApplicationController
  before_filter :authenticate_user!, only: [:check_in]
require 'base64'

  def check_in
       e = Entry.where(tag: params[:entry][:tag], check_out_at: nil).last
       if (e)
        render json: {:message => "Tag being used"}
        else
          entry = Entry.new(params[:entry])
          entry.check_in_at = Time.now
          entry.image = Base64.decode64(params[:entry][:image])
          entry.user = current_user
          entry.save
          render json: {   :message => "Check in success", 
                         :tag => entry.tag }
        end
    
  end

  def list_on
    # binding.pry
    @entries = Entry.where(check_out_at: nil).order(:check_in_at, :DESC).all
    results = @entries.map {|entry| {
             
                  :idtag => entry._id,
                  :tag => entry.tag, 
                  :image => entry.image.url, 
                  :imageuid => entry.image_uid,
                  :time_checkin => entry.check_in_at.strftime("%I:%M %p"),
                  :date_checkin => entry.check_in_at.strftime("%d/%m/%Y"),  
                  :guard => entry.user.name }}
    render json: results
  end

  def list_off
    # binding.pry
    @entries = Entry.excludes(check_out_at: nil).order(:check_out_at, :DESC).all
    results = @entries.map {|entry| {
                  
                  :idtag => entry._id,
                  :tag => entry.tag, 
                  :imageuid => entry.image_uid,
                  :image => entry.image.url, 
                  :time_checkin => entry.check_in_at.strftime("%I:%M %p"),
                  :date_checkin => entry.check_in_at.strftime("%d/%m/%Y"), 
                  :time_checkout => entry.check_out_at.strftime("%I:%M %p"),
                  :date_checkout => entry.check_out_at.strftime("%d/%m/%Y"),
                  :guard => entry.user.name }}
    render json: results
  end


  def check
    entry = Entry.where(tag: params[:tag], check_out_at: nil).last
    
    if (entry)
     render json: {:message => "success", 
                    :idtag => entry._id,
                    :tag => entry.tag, 
                    :image => entry.image.url, 
                    :time_checkin => entry.check_in_at.strftime("%I:%M %p"),
                    :date_checkin => entry.check_in_at.strftime("%d/%m/%Y"),
                    :guard => entry.user.name}
    else
      render json: {message: "Check - Tag NFC invalid"}
    end
  end



  def show
    entry = Entry.where(_id: params[:idtag]).last
    if (entry)
      if (entry.check_out_at)
        render json: {   :message => "success", 
                      :tag => entry.tag, 
                      :imageuid => entry.image_uid,
                      :image => entry.image.url, 
                      :time_checkin => entry.check_in_at.strftime("%I:%M %p"),
                      :date_checkin => entry.check_in_at.strftime("%d/%m/%Y"), 
                      :time_checkout => entry.check_out_at.strftime("%I:%M %p"),
                      :date_checkout => entry.check_out_at.strftime("%d/%m/%Y"),
                      :guard => entry.user.name}
        else
          render json: {   :message => "success", 
                      :tag => entry.tag, 
                      :imageuid => entry.image_uid,
                      :image => entry.image.url, 
                      :time_checkin => entry.check_in_at.strftime("%I:%M %p"),
                      :date_checkin => entry.check_in_at.strftime("%d/%m/%Y"), 
                      :guard => entry.user.name}
        end
    else
      render json: {:message => "No database for this entry"}
    end
  end


  def check_out
    entry = Entry.where(tag: params[:tag], check_out_at: nil).last
    if (entry)
      entry.check_out_at = Time.now
      entry.save
      render json: {  :message => "check out success", 
                      :tag => entry.tag, 
                      :imageuid => entry.image_uid,
                      :image => entry.image.url, 
                      :time_checkin => entry.check_in_at.strftime("%I:%M %p"),
                      :date_checkin => entry.check_in_at.strftime("%d/%m/%Y"), 
                      :time_checkout => entry.check_out_at.strftime("%I:%M %p"),
                      :date_checkout => entry.check_out_at.strftime("%d/%m/%Y"),
                      :guard => entry.user.name}
    else
      render json: {  :message => "Checkout - Tag NFC invalid" }
    end
  end
  
end
