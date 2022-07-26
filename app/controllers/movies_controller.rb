class MoviesController < ApplicationController
  load_and_authorize_resource
  before_action :set_movie, only: %i[ show edit update destroy ]
  MOVIES_PER_PAGE = 4

  # GET /movies or /movies.json
  def index
    @page = params.fetch(:page, 0).to_i
    @movies = Movie.offset(@page * MOVIES_PER_PAGE).limit(MOVIES_PER_PAGE)
  end

  # GET /movies/1 or /movies/1.json
  def show
    @review = @movie.reviews.build
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")

    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  # GET /movies/new
  def new
    @movie = current_user.movies.build
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = current_user.movies.build(movie_params)
    @movie.user_id = current_user.id
    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.friendly.destroy

    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.friendly.find(params[:id])
      # If an old id or a numeric id was used to find the record, then
      # the request slug will not match the current slug, and we should do
      # a 301 redirect to the new path
      if params[:id] != @movie.slug
        return redirect_to @movie, :status => :moved_permanently
      end
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :description, :category, :rating, :image)
    end
end
