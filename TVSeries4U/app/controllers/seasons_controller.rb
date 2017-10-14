class SeasonsController < ApplicationController
  before_action :find_serie, only: [:new, :show, :edit, :create, :update, :destroy]
  before_action :sesion_on_serie
  before_action :find_season, only: [:show, :edit, :update, :destroy]
  before_action :can_see, only: [:show]
  before_action :can_edit, only: [:edit, :update, :destroy]

  def new
    @season = @serie.seasons.build
  end

  def show
  end
  def edit
  end

  def create
	  @season = @serie.seasons.build(season_params)

  	if @season.save
    	flash[:success] = "Season Added"
      redirect_to serie_season_path(@serie, @season)
  	else
      render 'new'
  	end
  end

  def update
    if @season.update_attributes(season_params)
      flash[:success] = "Season updated"
      redirect_to serie_season_path(@serie, @season)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
  	def find_serie
      @serie = Serie.find(params[:serie_id])
    end

  	def sesion_on_serie
      unless !@serie.seasons.include?(params[:id])
        flash[:danger] = "Wrong season id."
        redirect_to serie_path(@serie)
  	  end
    end

    def find_season
      @season = @serie.seasons.find(params[:id])
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

    def season_params
      params.require(:season).permit(:name, :number, :description, :release)
    end
end

