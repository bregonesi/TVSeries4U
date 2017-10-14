class DirectorsNewsController < ApplicationController
  before_action :find_director
  before_action :find_new, only: [:edit, :update, :destroy]

  def index
    redirect_to director_path(@director)
  end

  def show
    redirect_to director_path(@director)
  end

  def new
    @nnew = @director.news.build
  end

  def create
    @nnew = @director.news.build(nnew_params)
    @nnew.user_id = current_user.id

    if @nnew.save
      flash[:success] = "New Added"
      redirect_to director_path(@director)
    else
      @director.news.delete(@nnew)
      render "directors/show"
    end
  end

  def edit
    render "directors/show"
  end

  def update
    if @nnew.update(nnew_params)
      flash[:success] = "New Updated"
      redirect_to director_path(@director)
    else
      render "directors/show"
    end
  end

  def destroy
    @nnew.destroy
    flash[:danger] = "New Deleted"
    redirect_to director_path(@director)
  end

  private
    def find_director
      @director = Director.find(params[:director_id])
    end

    def nnew_params
      params.require(:directors_new).permit(:title, :body)
    end

    def find_new
      @nnew = @director.news.find(params[:id])
    end
end
