class ActorsController < ApplicationController
  before_action :find_actor, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:create, :edit, :update, :destroy, :new]

  def new
    @actor = Actor.new
  end

  def edit
  end

  def update
    if @actor.update(actor_params)
      redirect_to @actor
    else
      render 'edit'
    end
  end

  def create
    @actor = Actor.new(actor_params)

    if @actor.save
      flash[:success] = "Actor Created"
      redirect_to @actor
    else
      render 'new'
    end
  end

  def index
    @actors = Actor.all.order("actors.name ASC").paginate(page: params[:page])
  end

  def show
    @actor = Actor.find(params[:id])
    @series = @actor.series
  end

  def destroy
    @actor.destroy
    flash[:danger] = "Actor Deleted"
    redirect_to actors_path
  end

  private
    def find_actor
      @actor = Actor.find(params[:id])
    end

    def actor_params
      params.require(:actor).permit(:name, :last_name)
    end

    def admin_user
      flash[:danger] = "Restringed action, only admins" unless current_user.admin?
      redirect_to(root_url) unless current_user.admin?
    end

end
