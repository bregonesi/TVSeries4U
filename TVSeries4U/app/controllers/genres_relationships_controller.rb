class GenresRelationshipsController < ApplicationController
  def create
    @genre = Genre.find(params[:genre_id])
    current_user.follow_genre(@genre)
    redirect_to genre_path(@genre)
  end

  def destroy
    @genre = Genre.find(params[:genre_id])
    current_user.unfollow_genre(@genre)
    redirect_to genre_path(@genre)
  end
end
