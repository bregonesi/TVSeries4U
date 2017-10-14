class ActorsRelationshipsController < ApplicationController
  def create
    @actor = Actor.find(params[:actor_id])
    current_user.follow_actor(@actor)
    redirect_to actor_path(@actor)
  end

  def destroy
    @actor = Actor.find(params[:actor_id])
    current_user.unfollow_actor(@actor)
    redirect_to actor_path(@actor)
  end
end
