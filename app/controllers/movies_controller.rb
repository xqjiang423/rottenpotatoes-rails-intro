class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @allratings=Movie.all_ratings
    if params[:ratings].present?
      @allratings = params[:ratings].keys
      session[:ratings] = params[:ratings]
    end
    if session[:ratings].present?
      @selected = session[:ratings].keys
    end

    if params[:sort].present?
      @sort = params[:sort]
      session[:sort] = params[:sort]
    else
      if session[:sort].present?
        @sort = session[:sort]
      end
    end
    
    if @sort=='title'
      @title_hilite = 'hilite'
      @release_date_hilite = ''
    elsif @sort=='release_date'
      @title_hilite = ''
      @release_date_hilite = 'hilite'
    else
      @title_hilite = ''
      @release_date_hilite = ''
    end
    @movies = Movie.where(rating: @allratings).order(@sort)
    
    
    @movies = Movie.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
