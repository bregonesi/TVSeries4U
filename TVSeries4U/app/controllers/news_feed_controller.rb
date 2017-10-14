class NewsFeedController < ApplicationController
	def index
		@news = ActiveRecord::Base.connection.execute("
			SELECT *, 'serie' AS tipo FROM series_news WHERE serie_id IN (#{Serie.all_series_user(current_user).map(&:id).join(',')})
			UNION SELECT *, 'actor' AS tipo FROM actors_news
			UNION SELECT *, 'director' AS tipo FROM directors_news
			ORDER BY updated_at DESC;")
	end
end
