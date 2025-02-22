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
    
    @all_ratings = Movie.getRatings()
    
    @ratings = params[:ratings] || session['ratings']
    @field = params[:field] || session['field']
    
    if(@ratings!=session['ratings'] or @field!=session['field'])
      flash.keep
      redirect_to movies_path :field=>@field, :ratings=>@ratings
    end
    @ratings_keys = @ratings.keys if @ratings
    @movies = Movie.with_ratings(@ratings_keys).order(@field)

    
    session['ratings'] = @ratings
    session['field'] = @field
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
