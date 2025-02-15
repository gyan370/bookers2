class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :edit, :update]
   before_action :is_matching_login_user, only: [:edit, :update]
   def index
    @book = Book.new
    @user = User.all  
   end
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user.id)  
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def is_matching_login_user
   user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to current_user
  end
  end
end
