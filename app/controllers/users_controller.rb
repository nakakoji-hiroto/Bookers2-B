class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @two_days_ago_book = @books.created_2day_ago
    @three_days_ago_book = @books.created_3day_ago
    @four_days_ago_book = @books.created_4day_ago
    @five_days_ago_book = @books.created_5day_ago
    @six_days_ago_book = @books.created_6day_ago
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    if @today_book.count != 0 && @yesterday_book.count != 0
      @the_day_before = (@today_book.count / @yesterday_book.count * 100).round　#.to_f
    else 
      @the_day_before = 0
    end
    
    if @this_week_book.count != 0 && @last_week_book.count != 0
      @the_week_before = (@this_week_book / @last_week_book * 100).round 
    else
      @the_week_before = 0
    end
  end

  def index
    @users = User.all
    @book = Book.new
    @follow = Relationship.all
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
end
