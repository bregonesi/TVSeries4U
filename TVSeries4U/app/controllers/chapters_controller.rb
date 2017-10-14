class ChaptersController < ApplicationController
  before_action :find_season, only: [:new, :show, :edit, :create, :update, :destroy]
  before_action :chapter_on_season, only: [:new, :show, :edit, :create, :update, :destroy]
  before_action :find_chapter, only: [:show, :edit, :update, :destroy]
  before_action :can_see, only: [:show]
  before_action :can_edit, only: [:edit, :update, :destroy]

  def new
    @chapter = @season.chapters.build
  end

  def show
  end
  def edit
  end

  def create
  	@chapter = @season.chapters.build(chapter_params)

  	if @chapter.save
    	  flash[:success] = "Chapter Added"
        redirect_to serie_season_chapter_path(@serie, @season, @chapter)
  	else
        render 'new'
  	end
  end

  def update
    if @chapter.update_attributes(chapter_params)
      flash[:success] = "Chapter updated"
      redirect_to serie_season_chapter_path(@serie, @season, @chapter)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
  	def find_season
  	  @serie = Serie.find(params[:serie_id])
      @season = @serie.seasons.find(params[:season_id])
    end

  	def chapter_on_season
      unless !@season.chapters.include?(params[:id])
        flash[:danger] = "Wrong chapter id."
        redirect_to serie_season_path(@serie, @season)
  	  end
    end

    def find_chapter
      @chapter = @season.chapters.find(params[:id])
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

    def can_edit
      age_able
      unless (logged_in and current_user.admin? and @serie.available == 2) or @serie.user == current_user or
        (@serie.available == 1 and current_user.has_family? and current_user.family.is_member?(@serie.user))
        flash[:danger] = "Sorry, you can't access here."
        redirect_to(root_url)
      end
    end

    def chapter_params
      params.require(:chapter).permit(:name, :number, :length, :release, :description)
    end
end

