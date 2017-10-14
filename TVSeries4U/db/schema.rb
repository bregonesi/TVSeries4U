# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170625082906) do

  create_table "actors", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
  end

  create_table "actors_news", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "actor_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actor_id"], name: "index_actors_news_on_actor_id"
    t.index ["user_id"], name: "index_actors_news_on_user_id"
  end

  create_table "actors_relationships", force: :cascade do |t|
    t.integer  "actor_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actor_id", "user_id"], name: "index_actors_relationships_on_actor_id_and_user_id", unique: true
    t.index ["actor_id"], name: "index_actors_relationships_on_actor_id"
    t.index ["user_id"], name: "index_actors_relationships_on_user_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.integer  "number"
    t.integer  "season_id"
    t.string   "name"
    t.text     "description"
    t.date     "release"
    t.integer  "length"
    t.integer  "rating",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["length"], name: "index_chapters_on_length"
    t.index ["number"], name: "index_chapters_on_number"
    t.index ["rating"], name: "index_chapters_on_rating"
    t.index ["release"], name: "index_chapters_on_release"
    t.index ["season_id", "number"], name: "index_chapters_on_season_id_and_number", unique: true
    t.index ["season_id"], name: "index_chapters_on_season_id"
  end

  create_table "chapters_reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chapter_id"
    t.integer  "rating",     default: 0
    t.text     "comment"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["chapter_id"], name: "index_chapters_reviews_on_chapter_id"
    t.index ["rating"], name: "index_chapters_reviews_on_rating"
    t.index ["user_id", "chapter_id"], name: "index_chapters_reviews_on_user_id_and_chapter_id", unique: true
    t.index ["user_id"], name: "index_chapters_reviews_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "directors", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
  end

  create_table "directors_news", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "director_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["director_id"], name: "index_directors_news_on_director_id"
    t.index ["user_id"], name: "index_directors_news_on_user_id"
  end

  create_table "directors_relationships", force: :cascade do |t|
    t.integer  "director_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["director_id", "user_id"], name: "index_directors_relationships_on_director_id_and_user_id", unique: true
    t.index ["director_id"], name: "index_directors_relationships_on_director_id"
    t.index ["user_id"], name: "index_directors_relationships_on_user_id"
  end

  create_table "families", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "family_invites", force: :cascade do |t|
    t.integer  "family_id"
    t.integer  "user_id"
    t.boolean  "parent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id", "user_id"], name: "index_family_invites_on_family_id_and_user_id", unique: true
    t.index ["family_id"], name: "index_family_invites_on_family_id"
    t.index ["user_id"], name: "index_family_invites_on_user_id"
  end

  create_table "family_members", force: :cascade do |t|
    t.integer  "family_id"
    t.integer  "user_id"
    t.boolean  "parent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_family_members_on_family_id"
    t.index ["parent"], name: "index_family_members_on_parent"
    t.index ["user_id"], name: "index_family_members_on_user_id", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "genres_relationships", force: :cascade do |t|
    t.integer  "genre_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id", "user_id"], name: "index_genres_relationships_on_genre_id_and_user_id", unique: true
    t.index ["genre_id"], name: "index_genres_relationships_on_genre_id"
    t.index ["user_id"], name: "index_genres_relationships_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_languages_on_name", unique: true
  end

  create_table "perfilseries", force: :cascade do |t|
    t.integer  "serie_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serie_id", "user_id"], name: "index_perfilseries_on_serie_id_and_user_id", unique: true
    t.index ["serie_id"], name: "index_perfilseries_on_serie_id"
    t.index ["user_id"], name: "index_perfilseries_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "serie_id"
    t.text     "description"
    t.date     "release"
    t.integer  "rating",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["number"], name: "index_seasons_on_number"
    t.index ["rating"], name: "index_seasons_on_rating"
    t.index ["release"], name: "index_seasons_on_release"
    t.index ["serie_id", "number"], name: "index_seasons_on_serie_id_and_number", unique: true
    t.index ["serie_id"], name: "index_seasons_on_serie_id"
  end

  create_table "seasons_reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "season_id"
    t.integer  "rating",     default: 0
    t.text     "comment"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["rating"], name: "index_seasons_reviews_on_rating"
    t.index ["season_id"], name: "index_seasons_reviews_on_season_id"
    t.index ["user_id", "season_id"], name: "index_seasons_reviews_on_user_id_and_season_id", unique: true
    t.index ["user_id"], name: "index_seasons_reviews_on_user_id"
  end

  create_table "series", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "rating",                   default: "0"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "serie_image_file_name"
    t.string   "serie_image_content_type"
    t.integer  "serie_image_file_size"
    t.datetime "serie_image_updated_at"
    t.integer  "age"
    t.integer  "user_id"
    t.integer  "available"
    t.index ["age"], name: "index_series_on_age"
    t.index ["available"], name: "index_series_on_available"
    t.index ["rating"], name: "index_series_on_rating"
    t.index ["user_id"], name: "index_series_on_user_id"
  end

  create_table "series_actors", force: :cascade do |t|
    t.integer "serie_id"
    t.integer "actor_id"
    t.index ["actor_id"], name: "index_series_actors_on_actor_id"
    t.index ["serie_id", "actor_id"], name: "index_series_actors_on_serie_id_and_actor_id", unique: true
    t.index ["serie_id"], name: "index_series_actors_on_serie_id"
  end

  create_table "series_countries", force: :cascade do |t|
    t.integer "serie_id"
    t.integer "country_id"
    t.index ["country_id"], name: "index_series_countries_on_country_id"
    t.index ["serie_id", "country_id"], name: "index_series_countries_on_serie_id_and_country_id", unique: true
    t.index ["serie_id"], name: "index_series_countries_on_serie_id"
  end

  create_table "series_directors", force: :cascade do |t|
    t.integer "serie_id"
    t.integer "director_id"
    t.index ["director_id"], name: "index_series_directors_on_director_id"
    t.index ["serie_id", "director_id"], name: "index_series_directors_on_serie_id_and_director_id", unique: true
    t.index ["serie_id"], name: "index_series_directors_on_serie_id"
  end

  create_table "series_genres", force: :cascade do |t|
    t.integer "serie_id"
    t.integer "genre_id"
    t.index ["genre_id"], name: "index_series_genres_on_genre_id"
    t.index ["serie_id", "genre_id"], name: "index_series_genres_on_serie_id_and_genre_id", unique: true
    t.index ["serie_id"], name: "index_series_genres_on_serie_id"
  end

  create_table "series_languages", force: :cascade do |t|
    t.integer "serie_id"
    t.integer "language_id"
    t.index ["language_id"], name: "index_series_languages_on_language_id"
    t.index ["serie_id", "language_id"], name: "index_series_languages_on_serie_id_and_language_id", unique: true
    t.index ["serie_id"], name: "index_series_languages_on_serie_id"
  end

  create_table "series_news", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "serie_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serie_id"], name: "index_series_news_on_serie_id"
    t.index ["user_id"], name: "index_series_news_on_user_id"
  end

  create_table "series_subtitles", force: :cascade do |t|
    t.integer "serie_id"
    t.integer "language_id"
    t.index ["language_id"], name: "index_series_subtitles_on_language_id"
    t.index ["serie_id", "language_id"], name: "index_series_subtitles_on_serie_id_and_language_id", unique: true
    t.index ["serie_id"], name: "index_series_subtitles_on_serie_id"
  end

  create_table "sreviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "serie_id"
    t.integer  "rating",     default: 0
    t.text     "comment"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["rating"], name: "index_sreviews_on_rating"
    t.index ["serie_id"], name: "index_sreviews_on_serie_id"
    t.index ["user_id", "serie_id"], name: "index_sreviews_on_user_id_and_serie_id", unique: true
    t.index ["user_id"], name: "index_sreviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.date     "birth"
    t.index ["admin"], name: "index_users_on_admin"
    t.index ["birth"], name: "index_users_on_birth"
    t.index ["email"], name: "index_users_on_email"
  end

  create_table "viewed_chapters", force: :cascade do |t|
    t.integer "chapter_id"
    t.integer "user_id"
    t.index ["chapter_id", "user_id"], name: "index_viewed_chapters_on_chapter_id_and_user_id", unique: true
    t.index ["chapter_id"], name: "index_viewed_chapters_on_chapter_id"
    t.index ["user_id"], name: "index_viewed_chapters_on_user_id"
  end

end
