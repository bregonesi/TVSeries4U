class SeriesController < ApplicationController
  before_action :find_serie, only: [:show, :edit, :update, :destroy]
  before_action :can_see, only: [:show]
  before_action :can_edit, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  #before_action :admin_user, only: [:create, :edit, :update, :destroy, :index]

  def new
    @serie = current_user.series.build
    @serie.genres.build
    @serie.countries.build
    @serie.languages.build
    @serie.subtitles.build
    @serie.actors.build
    @serie.directors.build
  end

  def show
  end

  def index
    #@series = Serie.where("age <= ?", current_user.age)
    @seen = current_user.seen_series.all_series_user(current_user)
    
    @entire_seen = []
    @half_seen = []
    @seen.each do |serie|
      viewed = serie.saw_by?(current_user)
      if viewed == 2
        @entire_seen << serie.id
      elsif viewed == 1
        @half_seen << serie.id
      end
    end

    @my_series = current_user.series
    @family_series = current_user.has_family? ? current_user.family.series : []

    if !params[:show_id] && !@my_series.empty?
      params[:show_id] = "2"
    end
    if !params[:show_id] && !@entire_seen.empty?
      params[:show_id] = "3"
    end
    if !params[:show_id] && !@half_seen.empty?
      params[:show_id] = "4"
    end
    if !params[:show_id] && !@family_series.empty?
      params[:show_id] = "5"
    end

    if params[:show_id] == "2"
      @series = current_user.series
    elsif params[:show_id] == "3"
      @series = Serie.where(:id => @entire_seen)
    elsif params[:show_id] == "4"
      @series = Serie.where(:id => @half_seen)
    elsif params[:show_id] == "5"
      @series = current_user.family.series if current_user.has_family?
    else
      @series = Serie.all_series_user(current_user)
    end
     
  end

  def create
    @serie = current_user.series.build(series_params)
    #@serie = Serie.new(series_params)

    if params[:suggested][:sugg_img] == "1"
      picture_from_url params[:suggested][:url]
    end
    
    if @serie.save
      if params[:genres]
        params[:genres][:id].each do |genre_id|
          if !genre_id.empty?
            @serie.genres << Genre.find(genre_id)
          end
        end
      end

      if params[:countries]
        params[:countries][:id].each do |country_id|
          if !country_id.empty?
            @serie.countries << Country.find(country_id)
          end
        end
      end

      if params[:languages]
        params[:languages][:id].each do |language_id|
          if !language_id.empty?
            @serie.languages << Language.find(language_id)
          end
        end
      end

      if params[:subtitles]
        params[:subtitles][:id].each do |subtitle_id|
          if !subtitle_id.empty?
            @serie.subtitles << Language.find(subtitle_id)
          end
        end
      end

      if params[:actors]
        params[:actors][:id].each do |actor_id|
          if !actor_id.empty?
            @serie.actors << Actor.find(actor_id)
          end
        end
      end

      if params[:directors]
        params[:directors][:id].each do |director_id|
          if !director_id.empty?
            @serie.directors << Director.find(director_id)
          end
        end
      end

      redirect_to serie_path(@serie)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:suggested][:sugg_img] == "1"
      picture_from_url params[:suggested][:url]
    end

    if @serie.update(series_params)

      @serie.genres = []
      if params[:genres]
        params[:genres][:id].each do |genre_id|
          if !genre_id.empty?
            @serie.genres << Genre.find(genre_id)
          end
        end
      end

      @serie.countries = []
      if params[:countries]
        params[:countries][:id].each do |country_id|
          if !country_id.empty?
            @serie.countries << Country.find(country_id)
          end
        end
      end

      @serie.languages = []
      if params[:languages]
        params[:languages][:id].each do |language_id|
          if !language_id.empty?
            @serie.languages << Language.find(language_id)
          end
        end
      end

      @serie.subtitles = []
      if params[:subtitles]
        params[:subtitles][:id].each do |subtitle_id|
          if !subtitle_id.empty?
            @serie.subtitles << Language.find(subtitle_id)
          end
        end
      end

      @serie.actors = []
      if params[:actors]
        params[:actors][:id].each do |actor_id|
          if !actor_id.empty?
            @serie.actors << Actor.find(actor_id)
          end
        end
      end

      @serie.directors = []
      if params[:directors]
        params[:directors][:id].each do |director_id|
          if !director_id.empty?
            @serie.directors << Director.find(director_id)
          end
        end
      end

      redirect_to serie_path(@serie)
    else
      render 'edit'
    end
  end
  
  def destroy
    @serie.destroy
    flash[:danger] = "Serie Deleted"
    redirect_to series_path
  end

  private
    def series_params
      params.require(:serie).permit(:title, :description, :rating, :serie_image, :age, :available,
      :genres_attributes => [:id => []],
      :countries_attributes => [:id => []],
      :languages_attributes => [:id => []],
      :subtitles_attributes => [:id => []],
      :actors_attributes => [:id => []],
      :directors_attributes => [:id => []],
      :suggested_attributes => [:sugg_img, :url])
    end

    def find_serie
      @serie = Serie.find(params[:id])
    end

    def logged_in_user
      unless logged_in
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def admin_user
      flash[:danger] = "Restringed action, only admins" unless current_user.admin?
      redirect_to(root_url) unless current_user.admin?
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

    def picture_from_url(url)
      @serie.serie_image = URI.parse(url)
    end

end
