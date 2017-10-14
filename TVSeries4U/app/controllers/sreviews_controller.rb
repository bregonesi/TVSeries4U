class SreviewsController < ApplicationController
  before_action :find_serie
  before_action :can_see, only: [:create, :edit, :update, :destroy]
  before_action :find_review, only: [:edit, :update, :destroy]

  def index
    redirect_to serie_path(@serie)
  end

  def show
    redirect_to serie_path(@serie)
  end

  def new
    @review = @serie.reviews.build
  end

  def create
    @review = @serie.reviews.build(review_params)
    @review.user_id = current_user.id

    if @review.save
      @serie.update_rating
      flash[:success] = "Review Added"
      redirect_to serie_path(@serie)
    else
      @serie.reviews.delete(@review)
      render "series/show"
    end
  end

  def edit
    render "series/show"
  end

  def update
    if @review.update(review_params)
      @serie.update_rating
      flash[:success] = "Review Updated"
      redirect_to serie_path(@serie)
    else
      render "series/show"
    end
  end

  def destroy
    @review.destroy
    @serie.update_rating
    flash[:danger] = "Review Deleted"
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

    def review_params
      params.require(:sreview).permit(:rating, :comment)
    end

    def find_review
      @review = @serie.reviews.find(params[:id])
    end
end
