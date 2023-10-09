class BooksController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update]
 before_action :matching_login_user
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    flash[:notice] = "Create successfully"
    if @book.save
    redirect_to book_path(@book.id)
  else
    @books = Book.all
     @user = current_user
    render :index
  end
  end

  def index
   @books = Book.all
   @book = Book.new
   @user = current_user
  end

  def show
   
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Edit successfully"
    redirect_to book_path(@book)
  else
    render :edit
  end
end
  
  def destroy
    book = Book.find(params[:id])
    flash[:notice] = "Destroy successfully"
    book.destroy
    redirect_to books_path
  end
  
  private
  def book_params
    params.require(:book).permit(:title,:body)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
  
   
  def matching_login_user
      unless user_signed_in?
      redirect_to new_user_session_path
  end
  
 end
 end
