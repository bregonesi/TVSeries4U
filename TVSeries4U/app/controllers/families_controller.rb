class FamiliesController < ApplicationController
  before_action :find_family, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin, only: [:edit, :update, :destroy]

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
    @family.family_members.build(user: current_user, parent: true)

    if @family.save
      flash[:success] = "Family Created"
      redirect_to @family
    else
      render 'new'
    end
  end

  def index
    @families = Family.all.paginate(page: params[:page])
  end

  def show
  end
  def edit
  end

  def destroy
    @family.destroy
    flash[:success] = "Family Deleted"
    redirect_to families_path
  end

  def update
    if @family.update(family_params)
      redirect_to @family
    else
      render 'edit'
    end
  end

  private
    def family_params
      params.require(:family).permit(:name)
    end

    def find_family
      @family = Family.find(params[:id])
    end

    def logged_in_user
      unless logged_in
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def admin
      unless (current_user.has_family? and current_user.is_parent?) or current_user.admin?
	    flash[:danger] = "Restringed action, only admins"
	    redirect_to(root_url)
      end
    end

end
