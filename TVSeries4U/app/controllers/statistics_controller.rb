class StatisticsController < ApplicationController
  def index
    @series = current_user.seen_series
  end
end
