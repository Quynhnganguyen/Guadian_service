class Api::UsersController < ApplicationController
	def sign_in
    @user = User.where(email: params[:email]).first
    if @user.blank?
      render json: { status: 'Invalid user', message: "Invalid user"}
    elsif @user.valid_password?(params[:password])
      render json: { status: "success", message: "Login success", username: @user.name, 
                     user_id: @user.id, authentication_token: @user.authentication_token }
    else
      @user = nil
      render json: { status: 'Invalid password', message: "Invalid password"}
    end
  end

  def sign_out
    current_user.reset_authentication_token!
    render text: 'Logout success'
  end

  def change_pass
    @user = User.where(email: params[:email]).first
    if @user
      if @user.valid_password?(params[:cur_pas])
        @user.password = params[:new_pas]
        @user.save
        render json:{ status: "ok", message: "Changing password success"}
      else
        render json: { status: "fail", message: "Password error"}
      end
    else
      render json: {status: "fail", message: "User not existe"}
    end
  end
end
