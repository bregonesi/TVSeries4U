class StaticPagesController < ApplicationController
  def home
    @series = Serie.all_series_user(current_user)

    if params[:search]  ## buscador simple
    	query = params[:serie_name] == "1" ? "series.title LIKE :search" : ""

    	query += " OR " if params[:serie_name] == "1" && (params[:genres] == "1" || params[:actors] == "1" ||
    		params[:directors] == "1" || params[:countries] == "1" || params[:languages] == "1" || params[:subtitles] == "1")

    	genres_id = params[:genres] == "1"  ? "SELECT genres.id FROM genres WHERE genres.name LIKE :search" : ""
    	query += params[:genres] == "1"  ? "series.id IN (SELECT series_genres.serie_id FROM series_genres WHERE series_genres.genre_id IN (#{genres_id}))" : ""

    	query += " OR " if params[:genres] == "1" && (params[:actors] == "1" || params[:directors] == "1" ||
    		params[:countries] == "1" || params[:languages] == "1" || params[:subtitles] == "1")

    	actors_id = params[:actors] == "1" ? "SELECT actors.id FROM actors WHERE actors.name LIKE :search OR actors.last_name LIKE :search OR actors.name || ' ' || actors.last_name LIKE :search" : ""
    	query += params[:actors] == "1" ? "series.id IN (SELECT serie_id FROM series_actors WHERE actor_id IN (#{actors_id}))" : ""

    	query += " OR " if params[:actors] == "1" && (params[:directors] == "1" || params[:countries] == "1" ||
    		params[:languages] == "1" || params[:subtitles] == "1")

    	directors_id = params[:directors] == "1" ? "SELECT directors.id FROM directors WHERE directors.name LIKE :search OR directors.last_name LIKE :search OR directors.name || ' ' || directors.last_name LIKE :search" : ""
    	query += params[:directors] == "1" ? "series.id IN (SELECT series_directors.serie_id FROM series_directors WHERE series_directors.director_id IN (#{directors_id}))" : ""

    	query += " OR " if params[:directors] == "1" && (params[:countries] == "1" || params[:languages] == "1" ||
    		params[:subtitles] == "1")

    	countries_id = params[:countries] == "1" ? "SELECT countries.id FROM countries WHERE countries.name LIKE :search" : ""
    	query += params[:countries] == "1" ? "series.id IN (SELECT series_countries.serie_id FROM series_countries WHERE series_countries.country_id IN (#{countries_id}))" : ""

    	query += " OR " if params[:countries] == "1" && (params[:languages] == "1" || params[:subtitles] == "1")

    	languages_id = params[:languages] == "1" || params[:subtitles] == "1" ? "SELECT languages.id FROM languages WHERE languages.name LIKE :search" : ""
    	query += params[:languages] == "1" ? "series.id IN (SELECT series_languages.serie_id FROM series_languages WHERE series_languages.language_id IN (#{languages_id}))" : ""

    	query += " OR " if params[:languages] == "1" && params[:subtitles] == "1"

    	query += params[:subtitles] == "1" ? "series.id IN (SELECT series_subtitles.serie_id FROM series_subtitles WHERE series_subtitles.language_id IN (#{languages_id}))" : ""

    	@series = @series.where("#{query}",
    		search: "%#{params[:search]}%")

    elsif params[:serie_search] || params[:genre_search] || params[:actor_search] || params[:director_search] ||
    	params[:country_search] || params[:language_search] || params[:subtitle_search] || params[:age_min_search] ||
        params[:age_max_search] || params[:stars_min] || params[:stars_max] ## buscador avanzado

        @series = @series.where("series.title LIKE ?", "%#{params[:serie_search]}%") if !params[:serie_search].empty?

    	@series = @series.where("series.id IN (SELECT series_genres.serie_id FROM series_genres WHERE series_genres.genre_id IN (SELECT genres.id FROM genres WHERE genres.name LIKE ?))", "%#{params[:genre_search]}%") if !params[:genre_search].empty?

    	@series = @series.where("series.id IN (SELECT series_actors.serie_id FROM series_actors WHERE series_actors.actor_id IN (SELECT actors.id FROM actors WHERE actors.name LIKE ? OR actors.last_name LIKE ? OR actors.name || ' ' || actors.last_name LIKE ?))", "%#{params[:actor_search]}%", "%#{params[:actor_search]}%", "%#{params[:actor_search]}%") if !params[:actor_search].empty?

    	@series = @series.where("series.id IN (SELECT series_directors.serie_id FROM series_directors WHERE series_directors.director_id IN (SELECT directors.id FROM directors WHERE directors.name LIKE ? OR directors.last_name LIKE ? OR directors.name || ' ' || directors.last_name LIKE ?))", "%#{params[:director_search]}%", "%#{params[:director_search]}%", "%#{params[:director_search]}%") if !params[:director_search].empty?

    	@series = @series.where("series.id IN (SELECT series_countries.serie_id FROM series_countries WHERE series_countries.country_id IN (SELECT countries.id FROM countries WHERE countries.name LIKE ?))", "%#{params[:country_search]}%") if !params[:country_search].empty?

    	@series = @series.where("series.id IN (SELECT series_languages.serie_id FROM series_languages WHERE series_languages.language_id IN (SELECT languages.id FROM languages WHERE languages.name LIKE ?))", "%#{params[:language_search]}%") if !params[:language_search].empty?

    	@series = @series.where("series.id IN (SELECT series_subtitles.serie_id FROM series_subtitles WHERE series_subtitles.language_id IN (SELECT languages.id FROM languages WHERE languages.name LIKE ?))", "%#{params[:subtitle_search]}%") if !params[:subtitle_search].empty?

        @series = @series.where("series.age >= ?", params[:age_min_search]) if !params[:age_min_search].empty?

        @series = @series.where("series.age <= ?", params[:age_max_search]) if !params[:age_max_search].empty?

        @series = @series.where("series.rating >= ?", params[:stars_min]) if !params[:stars_min].empty?

        @series = @series.where("series.rating <= ?", params[:stars_max]) if !params[:stars_max].empty?
    end
  end
end
