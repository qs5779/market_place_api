class Api::V1::TokensController < ApplicationController
  def create
    @user = User.find_by_email(user_params[:email])
    # puts "user: " + @user.inspect
    if @user&.authenticate(user_params[:password])
      # puts "authenticated #{@user.id}"
      render json: { token: JsonWebToken.encode(user_id: @user.id), email: @user.email }
    else
      head :unauthorized
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
