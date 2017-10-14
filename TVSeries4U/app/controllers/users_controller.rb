class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @news = ActiveRecord::Base.connection.execute("
      SELECT *, 'serie' AS tipo FROM series_news WHERE series_news.serie_id IN (SELECT perfilseries.serie_id FROM perfilseries WHERE perfilseries.user_id = #{@user.id}) AND series_news.serie_id IN (#{Serie.all_series_user(current_user).map(&:id).join(',')})
      UNION SELECT *, 'serie' AS tipo FROM series_news WHERE series_news.user_id IN (SELECT relationships.followed_id FROM relationships WHERE relationships.follower_id = #{@user.id}) AND series_news.serie_id IN (#{Serie.all_series_user(current_user).map(&:id).join(',')})
      UNION SELECT *, 'actor' AS tipo FROM actors_news WHERE actors_news.actor_id IN (SELECT actors_relationships.actor_id FROM actors_relationships WHERE actors_relationships.user_id = #{@user.id})
      UNION SELECT *, 'actor' AS tipo FROM actors_news WHERE actors_news.user_id IN (SELECT relationships.followed_id FROM relationships WHERE relationships.follower_id = #{@user.id})
      UNION SELECT *, 'director' AS tipo FROM directors_news WHERE directors_news.director_id IN (SELECT directors_relationships.director_id FROM directors_relationships WHERE directors_relationships.user_id = #{@user.id})
      UNION SELECT *, 'director' AS tipo FROM directors_news WHERE directors_news.user_id IN (SELECT relationships.followed_id FROM relationships WHERE relationships.follower_id = #{@user.id})
      ORDER BY updated_at DESC;")
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      #flash[:succes] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation, :birth)
    end
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
