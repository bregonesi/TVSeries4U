class DirectorsController < ApplicationController
  before_action :find_director, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:create, :edit, :update, :destroy, :new]

  def new
    @director = Director.new
  end

  def edit
  end

  def update
    if @director.update(director_params)
      redirect_to @director
    else
      render 'edit'
    end
  end

  def create
    @director = Director.new(director_params)

    if @director.save
      flash[:success] = "Director Created"
      redirect_to @director
    else
      render 'new'
    end
  end

  def index
	@directors = Director.all.order("directors.name ASC").paginate(page: params[:page])
  end

  def show
    @director = Director.find(params[:id])
    @series = @director.series
  end

  def destroy
    @director.destroy
    flash[:danger] = "Director Deleted"
    redirect_to directors_path
  end

  private
    def find_director
      @director = Director.find(params[:id])
    end

    def director_params
      params.require(:director).permit(:name, :last_name)
    end
    
    def admin_user
      flash[:danger] = "Restringed action, only admins" unless current_user.admin?
      redirect_to(root_url) unless current_user.admin?
    end
end