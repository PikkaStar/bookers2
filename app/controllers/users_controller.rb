class UsersController < ApplicationController

  before_action :matching_login_user
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
     @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Edit successfully"
    redirect_to user_path(@user)
  else
    render :edit
  end
end

  private
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

   def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def matching_login_user
    unless user_signed_in?
      redirect_to new_user_session_path
  end

end
end