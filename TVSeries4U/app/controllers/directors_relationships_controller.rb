class DirectorsRelationshipsController < ApplicationController
  def create
    @director = Director.find(params[:director_id])
    current_user.follow_director(@director)
    redirect_to director_path(@director)
  end

  def destroy
    @director = Director.find(params[:director_id])
    current_user.unfollow_director(@director)
    redirect_to director_path(@director)
  end
end
