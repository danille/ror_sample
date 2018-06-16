class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # HAndling successful saving
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:name).permit(:name, :email, :password, :password_confirmation)
    end
  end

end
