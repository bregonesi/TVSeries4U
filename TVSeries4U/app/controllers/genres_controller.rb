class GenresController < ApplicationController
  before_action :find_genre, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:create, :edit, :update, :destroy, :new]

  def new
    @genre = Genre.new
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to @genre
    else
      render 'edit'
    end
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      flash[:success] = "Genre Created"
      redirect_to @genre
    else
      render 'new'
    end
  end

  def index
	  @genres = Genre.all.order("genres.name ASC").paginate(page: params[:page])
  end

  def show
    @genre = Genre.find(params[:id])
    @series = @genre.series
  end

  def destroy
    @genre.destroy
    flash[:danger] = "Genre Deleted"
    redirect_to genres_path
  end

  private
  	def find_genre
      @genre = Genre.find(params[:id])
    end

    def genre_params
      params.require(:genre).permit(:name)
    end
    
    def admin_user
      flash[:danger] = "Restringed action, only admins" unless current_user.admin?
      redirect_to(root_url) unless current_user.admin?
    end
end
