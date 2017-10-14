class ActorsNewsController < ApplicationController
  before_action :find_actor
  before_action :find_new, only: [:edit, :update, :destroy]

  def index
    redirect_to actor_path(@actor)
  end

  def show
    redirect_to actor_path(@actor)
  end

  def new
    @nnew = @actor.news.build
  end

  def create
    @nnew = @actor.news.build(nnew_params)
    @nnew.user_id = current_user.id

    if @nnew.save
      flash[:success] = "New Added"
      redirect_to actor_path(@actor)
    else
      @actor.news.delete(@nnew)
      render "actors/show"
    end
  end

  def edit
    render "actors/show"
  end

  def update
    if @nnew.update(nnew_params)
      flash[:success] = "New Updated"
      redirect_to actor_path(@actor)
    else
      render "actors/show"
    end
  end

  def destroy
    @nnew.destroy
    flash[:danger] = "New Deleted"
    redirect_to actor_path(@actor)
  end

  private
    def find_actor
      @actor = Actor.find(params[:actor_id])
    end

    def nnew_params
      params.require(:actors_new).permit(:title, :body)
    end

    def find_new
      @nnew = @actor.news.find(params[:id])
    end
end
