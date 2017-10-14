class FamilyInvitesController < ApplicationController
  before_action :find_family, only: [:create, :destroy]

  def create
  	@user = User.find(params[:id])
  	@invite = @family.family_invites.build(user: @user, parent: params[:parent])

    if @invite.save
      flash[:success] = "Invitation sent"
      redirect_to @family
    else
      flash[:danger] = "Error on invitation"
      redirect_to users_path(params[:id])
    end
  end

  def destroy
  	@invite = @family.family_invites.find(params[:id]).destroy
    flash[:danger] = "Invitation deleted"
    redirect_to @invite.user
  end

  private
    def find_family
      @family = Family.find(params[:family_id])
      admin
    end

    def admin
      unless (current_user.has_family? and current_user.is_parent? and current_user.family == @family) or current_user.admin?
	    flash[:danger] = "Restringed action, only admins"
	    redirect_to(root_url)
      end
    end

end
