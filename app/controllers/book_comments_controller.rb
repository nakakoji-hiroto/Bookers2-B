class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = book.id
    if @book_comment.save
      redirect_to book_path(book)
      #redirect_back fallback_location: root_path
    else
      @book = Book.find(params[:book_id])
      @new_book = Book.new
      @user = @book.user
      @book_comments = BookComment.where(book_id: @book.id)
      render "books/show"
    end
  end

  def destroy
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
    redirect_back fallback_location: root_path
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
