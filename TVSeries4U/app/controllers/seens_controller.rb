class SeensController < ApplicationController
  def create
    @chapter = Chapter.find(params[:chapter_id])
    current_user.add_saw_chapter(@chapter)
    redirect_to serie_season_chapter_path(@chapter.season.serie, @chapter.season, @chapter)
  end

  def destroy
    @chapter = Chapter.find(params[:chapter_id])
    current_user.del_saw_chapter(@chapter)
    redirect_to serie_season_chapter_path(@chapter.season.serie, @chapter.season, @chapter)
  end
end
