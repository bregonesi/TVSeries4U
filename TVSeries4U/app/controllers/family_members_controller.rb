class FamilyMembersController < ApplicationController
  before_action :find_family, only: [:create, :destroy]
  before_action :invited, only: [:create]

  def create
  	@invite = @family.family_invites.where(user: current_user).first
  	@member = @family.family_members.build(user: @invite.user, parent: @invite.parent)

    if @member.save
      current_user.family_invites.delete_all
      flash[:success] = "Invitation accepted"
      redirect_to @family
    else
      flash[:danger] = "Error on invitation"
      redirect_to families_path
    end
  end

  def destroy
  	@member = @family.family_members.find(params[:id])
  	admin
  	@member.destroy
    flash[:danger] = "Member deleted"

    if @family.users.count > 0
    	redirect_to @family
    else
    	@family.destroy
    	flash[:danger] = "Family deleted"
    	redirect_to families_path
    end
  end

  private
    def find_family
      @family = Family.find(params[:family_id])
    end

    def invited
      unless current_user.is_invited?(@family)
	    flash[:danger] = "Restringed action"
	    redirect_to families_path
      end
    end

    def admin
      unless (current_user.has_family? and current_user.is_parent? and current_user.family == @family) or current_user.admin? or current_user == @member.user
	    flash[:danger] = "Restringed action"
	    redirect_to families_path
      end
    end

end
