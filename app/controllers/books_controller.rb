class BooksController < ApplicationController
 
  def new
    @book = Book.new
  end

  def index
    @book = Book.new
    @book.user = current_user
    @books = Book.all
  end
  
  def create
    @book = Book.new(book_params)
    @book.user = current_user
    @book.user_id = current_user.id
  if @book.save
    flash[:notice] = "successfully"
    redirect_to book_path(@book.id)
  else
    @books = Book.all
    render :index
  end
  end

  def show
    @book = Book.find(params[:id])  
  end
  def destroy
    book = Book.find(params[:id])  
    book.destroy  
    redirect_to '/books'  
  end
  def edit
    @book = Book.find(params[:id])
    is_matching_login_user(@book.user)
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "error"
      render :edit
    end
  end
  
  private
  
  def is_matching_login_user(owner)
   unless owner == current_user
    redirect_to books_path
   end
  end

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end