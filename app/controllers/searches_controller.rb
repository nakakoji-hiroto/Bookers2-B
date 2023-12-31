class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @search = params[:search]
    @word = params[:word]
    @follow = Relationship.all
    if @range == "User"
      @users = User.looks(@search, @word)
    else
      @books = Book.looks(@search, @word)
    end
  end
end
