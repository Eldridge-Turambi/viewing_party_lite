class MoviesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @movies = facade.search_filter(params[:filter])
    # binding.pry
  end

  def show
    @user = User.find(params[:user_id])
    @movie = facade.movie_details(params[:id])
  end

  def facade
    MovieFacade.new
  end

end
