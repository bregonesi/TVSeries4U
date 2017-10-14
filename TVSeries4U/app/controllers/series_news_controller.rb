class SeriesNewsController < ApplicationController
  before_action :find_serie
  before_action :can_see, only: [:create, :edit, :update, :destroy]
  before_action :find_new, only: [:edit, :update, :destroy]

  def index
    redirect_to serie_path(@serie)
  end

  def show
    redirect_to serie_path(@serie)
  end

  def new
    @nnew = @serie.news.build
  end

  def create
    @nnew = @serie.news.build(nnew_params)
    @nnew.user_id = current_user.id

    if @nnew.save
      flash[:success] = "New Added"
      redirect_to serie_path(@serie)
    else
      @serie.news.delete(@nnew)
      render "series/show"
    end
  end

  def edit
    render "series/show"
  end

  def update
    if @nnew.update(nnew_params)
      flash[:success] = "New Updated"
      redirect_to serie_path(@serie)
    else
      render "series/show"
    end
  end

  def destroy
    @nnew.destroy
    flash[:danger] = "New Deleted"
    redirect_to serie_path(@serie)
  end

  private
    def find_serie
      @serie = Serie.find(params[:serie_id])
    end

    def age_able
      unless logged_in and current_user.age >= @serie.age or @serie.age < 18
        flash[:danger] = "Sorry, you can't access here."
        redirect_to(root_url)
      end
    end

    def can_see
      age_able
      unless (logged_in and current_user.admin?) or @serie.available == 2 or @serie.user == current_user or
        (@serie.available == 1 and current_user.has_family? and current_user.family.is_member?(@serie.user))
        flash[:danger] = "Sorry, you can't access here."
        redirect_to(root_url)
      end
    end

    def nnew_params
      params.require(:series_new).permit(:title, :body)
    end

    def find_new
      @nnew = @serie.news.find(params[:id])
    end
end
