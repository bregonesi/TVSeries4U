class PerfilseriesController < ApplicationController
  def create
    @serie = Serie.find(params[:serie_id])
    current_user.add_follow_serie(@serie)
    redirect_to serie_path(@serie)
  end

  def destroy
    @serie = Serie.find(params[:serie_id])
    current_user.del_follow_serie(@serie)
    redirect_to serie_path(@serie)
  end
end
