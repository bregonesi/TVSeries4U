# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


[User, Serie, Genre, Country, Language, Actor, Director,
	SeriesGenre, SeriesCountry, SeriesLanguage, SeriesSubtitle, SeriesActor, SeriesDirector,
	Season, Chapter, Sreview, SeasonsReview, ChaptersReview, SeriesNew, ActorsNew, DirectorsNew,
	ViewedChapter].each(&:delete_all)

## Users
users = [
			{name: "Manuel Silva", email: "misilva2@uc.cl", password: "123456", created_at: Faker::Time.between(2.months.ago, Date.today), admin: 1, birth: "25-01-1994"},
			{name: "Rodrigo Orpis", email: "raorpis@uc.cl", password: "123456", created_at: Faker::Time.between(2.months.ago, Date.today), admin: 1, birth: "27-12-1993"},
			{name: "Benjamin Regonesi", email: "baregonesi@uc.cl", password: "123456", created_at: Faker::Time.between(2.months.ago, Date.today), admin: 1, birth: "06-12-1994"},
			{name: "Jaime Naivon", email: "jnaivon@uc.cl", password: "123456", created_at: Faker::Time.between(2.months.ago, Date.today), birth: Faker::Date.birthday(20, 23)},
			{name: "Isidora Palma", email: "impalma@uc.cl", password: "123456", created_at: Faker::Time.between(2.months.ago, Date.today), birth: "28-08-1995"},
			{name: "Ricardo Lira", email: "rlira2@uc.cl", password: "123456", created_at: Faker::Time.between(2.months.ago, Date.today), birth: Faker::Date.birthday(20, 23)},
			{name: "Isaac Carrera", email: "ifcarrera@uc.cl", password: "123456", created_at: Faker::Time.between(2.months.ago, Date.today), birth: Faker::Date.birthday(20, 23)},
			{name: "Maria Fernanda Sepulveda", email: "mfsepulveda@uc.cl", password: "123456", created_at: Faker::Time.between(2.months.ago, Date.today), birth: Faker::Date.birthday(20, 23)},
			{name: "Jaime Yañez", email: "jsyanez@uc.cl", password: "123456", created_at: Faker::Time.between(2.months.ago, Date.today), birth: Faker::Date.birthday(20, 23)}
		]

users.each do |user|
	user[:updated_at] = Faker::Time.between(user[:created_at], Date.today)
end

100.times do |x|
  name 			= Faker::Name.name
  email 		= Faker::Internet.email
  password 		= "123456"
  created_at 	= Faker::Time.between(2.months.ago, Date.today)
  updated_at 	= Faker::Time.between(created_at, Date.today)
  birth 		= Faker::Date.birthday(3, 65)
  users.push(name: name, email: email, password: password, created_at: created_at, updated_at: updated_at, birth: birth)
end

User.create(users)


## Generos
Genre.populate 15 do |genre|
  genre.name 	= Faker::Book.unique.genre
end

## Countrys
Country.populate 50 do |country|
  country.name 	= Faker::Address.unique.country
end

## Languages
Language.create([{name: "English"}, {name: "Afar"}, {name: "Abkhazian"}, {name: "Afrikaans"}, {name: "Amharic"}, {name: "Arabic"}, {name: "Assamese"}, {name: "Aymara"}, {name: "Azerbaijani"}, {name: "Bashkir"}, {name: "Byelorussian"}, {name: "Bulgarian"}, {name: "Bihari"}, {name: "Bislama"}, {name: "Bengali/Bangla"}, {name: "Tibetan"}, {name: "Breton"}, {name: "Catalan"}, {name: "Corsican"}, {name: "Czech"}, {name: "Welsh"}, {name: "Danish"}, {name: "German"}, {name: "Bhutani"}, {name: "Greek"}, {name: "Esperanto"}, {name: "Spanish"}, {name: "Estonian"}, {name: "Basque"}, {name: "Persian"}, {name: "Finnish"}, {name: "Fiji"}, {name: "Faeroese"}, {name: "French"}, {name: "Frisian"}, {name: "Irish"}, {name: "Scots/Gaelic"}, {name: "Galician"}, {name: "Guarani"}, {name: "Gujarati"}, {name: "Hausa"}, {name: "Hindi"}, {name: "Croatian"}, {name: "Hungarian"}, {name: "Armenian"}, {name: "Interlingua"}, {name: "Interlingue"}, {name: "Inupiak"}, {name: "Indonesian"}, {name: "Icelandic"}, {name: "Italian"}, {name: "Hebrew"}, {name: "Japanese"}, {name: "Yiddish"}, {name: "Javanese"}, {name: "Georgian"}, {name: "Kazakh"}, {name: "Greenlandic"}, {name: "Cambodian"}, {name: "Kannada"}, {name: "Korean"}, {name: "Kashmiri"}, {name: "Kurdish"}, {name: "Kirghiz"}, {name: "Latin"}, {name: "Lingala"}, {name: "Laothian"}, {name: "Lithuanian"}, {name: "Latvian/Lettish"}, {name: "Malagasy"}, {name: "Maori"}, {name: "Macedonian"}, {name: "Malayalam"}, {name: "Mongolian"}, {name: "Moldavian"}, {name: "Marathi"}, {name: "Malay"}, {name: "Maltese"}, {name: "Burmese"}, {name: "Nauru"}, {name: "Nepali"}, {name: "Dutch"}, {name: "Norwegian"}, {name: "Occitan"}, {name: "(Afan)/Oromoor/Oriya"}, {name: "Punjabi"}, {name: "Polish"}, {name: "Pashto/Pushto"}, {name: "Portuguese"}, {name: "Quechua"}, {name: "Rhaeto-Romance"}, {name: "Kirundi"}, {name: "Romanian"}, {name: "Russian"}, {name: "Kinyarwanda"}, {name: "Sanskrit"}, {name: "Sindhi"}, {name: "Sangro"}, {name: "Serbo-Croatian"}, {name: "Singhalese"}, {name: "Slovak"}, {name: "Slovenian"}, {name: "Samoan"}, {name: "Shona"}, {name: "Somali"}, {name: "Albanian"}, {name: "Serbian"}, {name: "Siswati"}, {name: "Sesotho"}, {name: "Sundanese"}, {name: "Swedish"}, {name: "Swahili"}, {name: "Tamil"}, {name: "Tegulu"}, {name: "Tajik"}, {name: "Thai"}, {name: "Tigrinya"}, {name: "Turkmen"}, {name: "Tagalog"}, {name: "Setswana"}, {name: "Tonga"}, {name: "Turkish"}, {name: "Tsonga"}, {name: "Tatar"}, {name: "Twi"}, {name: "Ukrainian"}, {name: "Urdu"}, {name: "Uzbek"}, {name: "Vietnamese"}, {name: "Volapuk"}, {name: "Wolof"}, {name: "Xhosa"}, {name: "Yoruba"}, {name: "Chinese"}, {name: "Zulu"}])

## Actors
Actor.populate 50 do |actor|
  actor.name 		= Faker::Name.first_name
  actor.last_name 	= Faker::Name.last_name
end

## Directors
Director.populate 50 do |director|
  director.name 		= Faker::Name.first_name
  director.last_name 	= Faker::Name.last_name
end


## Series
series = [
			{id: 1, title: "Breaking Bad", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "breaking_bad.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 71873, age: 18, user_id: rand(1..3), available: 2},
			{id: 2, title: "Sillicon Valley", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "sillicon_valley.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 61066, age: 8, user_id: rand(1..3), available: 2},
			{id: 3, title: "Game of Thrones", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "game_of_thrones.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 54265, age: 14, user_id: rand(1..3), available: 2},
			{id: 4, title: "House of Cards", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "houseofcards.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 263911, age:12, user_id: rand(1..3), available: 2},
			{id: 5, title: "Vikigns", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "vikings.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 295550, age: 16, user_id: rand(1..3), available: 2},
			{id: 6, title: "Thriteen Reasons Why", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "13_reasons_why.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 121199, age: 12, user_id: rand(1..3), available: 2},
			{id: 7, title: "Narcos", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "narcos.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 72788, age: 18, user_id: rand(1..3), available: 2},
			{id: 8, title: "The Simpsons", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "simpsons.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 157105, age: 10, user_id: rand(1..3), available: 2},
			{id: 9, title: "Orange Is The New Black", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "orange.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 308472, age: 18, user_id: rand(1..3), available: 2},
			{id: 10, title: "Friends", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "friends.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 49366, age: 18, user_id: rand(1..3), available: 2},
		 	{id: 11, title: "Big Bang Theory", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "bbt.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 749736, age: 18, user_id: rand(1..3), available: 2},
		 	{id: 12, title: "Better Call Saul", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "sull.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 243447, age: 18, user_id: rand(1..3), available: 2},
			{id: 13, title: "The Office", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "cover.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 35269, age: 18, user_id: rand(1..3), available: 2},
			{id: 14, title: "Lost", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "lost.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 2232226, age: 18, user_id: rand(1..3), available: 2},
			{id: 15, title: "The Walking Dead", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "walking.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 563505, age: 18, user_id: rand(1..3), available: 2},
			{id: 16, title: "Sherlock", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "sherlock.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 379844, age: 18, user_id: rand(1..3), available: 2},
			{id: 17, title: "Stranger Things", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "stranger.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 811616, age: 18, user_id: rand(1..3), available: 2},
			{id: 18, title: "Black Mirror", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "black-mirror22.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 257687, age: 18, user_id: rand(1..3), available: 2},
			{id: 19, title: "How I Met Your Mother", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "How_I_Met_Your_Mother_Season_1_DVD_Cover.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 19941, age: 18, user_id: rand(1..3), available: 2},
			{id: 20, title: "Daredevil", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "dare.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 3929575, age: 18, user_id: rand(1..3), available: 2},
			{id: 21, title: "Arrow", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "arr.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 229105, age: 18, user_id: rand(1..3), available: 2},
			{id: 22, title: "Dexter", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "Dexter-Season-6.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 362123, age: 18, user_id: rand(1..3), available: 2},
			{id: 23, title: "Family Guy", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "Family-Guy-Season-6.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 112652, age: 10, user_id: rand(1..3), available: 2},
			{id: 24, title: "Sense8", description: Faker::Lorem.paragraph, created_at: Faker::Time.between(2.months.ago, Date.today), serie_image_file_name: "sense.jpg", serie_image_content_type: "image/jpeg", serie_image_file_size: 560168, age: 18, user_id: rand(1..3), available: 2}
		 ]

series.each do |serie|
	serie[:updated_at] = serie[:created_at]
	serie[:serie_image_updated_at] = serie[:created_at]
end
Serie.create(series)

## Series genres
Serie.all.each do |serie|
	generos = (1..Genre.count).to_a.shuffle
	rand(1..4).times do |x|
		serie.genres << Genre.find(generos.pop)
	end
end

## Series countries
Serie.all.each do |serie|
	paises = (1..Country.count).to_a.shuffle
	rand(1..2).times do |x|
		serie.countries << Country.find(paises.pop)
	end
end

## Series languages
Serie.all.each do |serie|
	lenguajes = (1..Language.count).to_a.shuffle
	rand(1..5).times do |x|
		serie.languages << Language.find(lenguajes.pop)
	end
end

## Series subtitles
Serie.all.each do |serie|
	lenguajes = (1..Language.count).to_a.shuffle
	rand(0..10).times do |x|
		serie.subtitles << Language.find(lenguajes.pop)
	end
end

## Series actors
Serie.all.each do |serie|
	actores = (1..Actor.count).to_a.shuffle
	rand(0..20).times do |x|
		serie.actors << Actor.find(actores.pop)
	end
end


## Series directors
Serie.all.each do |serie|
	directores = (1..Director.count).to_a.shuffle
	rand(0..15).times do |x|
		serie.directors << Director.find(directores.pop)
	end
end

## Following between users
User.all.each do |user|
	users = (1..User.count).to_a.shuffle
	rand(0..(User.count/5).to_i).times do |x|
		user.follow(User.find(users.pop))
	end
end

## Following series
User.all.each do |user|
	series = (1..Serie.count).to_a.shuffle
	rand(0..(Serie.count/5).to_i).times do |x|
		user.add_follow_serie(Serie.find(series.pop))
	end
end

## Following actors
User.all.each do |user|
	actors = (1..Actor.count).to_a.shuffle
	rand(0..(Actor.count/5).to_i).times do |x|
		user.follow_actor(Actor.find(actors.pop))
	end
end

## Following directors
User.all.each do |user|
	directors = (1..Director.count).to_a.shuffle
	rand(0..(Director.count/5).to_i).times do |x|
		user.follow_director(Director.find(directors.pop))
	end
end

## Following genres
User.all.each do |user|
	genres = (1..Genre.count).to_a.shuffle
	rand(0..(Genre.count/5).to_i).times do |x|
		user.follow_genre(Genre.find(genres.pop))
	end
end


## Serie seasons and chapters
Serie.all.each do |serie|
	rand(1..5).times do |i|
		name = Faker::Book.title
		number = i + 1
		serie_id = serie.id
		description = Faker::Lorem.paragraph
		release = Faker::Time.between(10.years.ago, Date.today)
		created_at = Faker::Time.between(serie.created_at, Date.today)
		updated_at = Faker::Time.between(created_at, Date.today)
		season = Season.create({name: name, number: number, serie_id: serie_id, description: description, release: release, created_at: created_at, updated_at: updated_at})

		rand(1..7).times do |j|
			name = Faker::Book.title
			number = j + 1
			season_id = season.id
			description = Faker::Lorem.paragraph
			length = Faker::Number.between(40, 80)
			release = Faker::Time.between(season.release, Date.today)
			created_at = Faker::Time.between(season.created_at, Date.today)
			updated_at = Faker::Time.between(created_at, Date.today)
			Chapter.create({name: name, number: number, season_id: season_id, description: description, length: length, release: release, created_at: created_at, updated_at: updated_at})
		end
	end
end


## Series reviews
Serie.all.each do |serie|
	rand(1..(5*serie.seasons.count)).times do |x|
		user_id = User.all.to_a.sample.id
		serie_id = serie.id
		rating = Faker::Number.between(1, 5)
		comment = Faker::Lorem.paragraph
		created_at = Faker::Time.between(serie.created_at, Date.today)
		updated_at = Faker::Time.between(created_at, Date.today)
		Sreview.create({user_id: user_id, serie_id: serie_id, rating: rating, comment: comment, created_at: created_at, updated_at: updated_at})
	end
end

## Seasons reviews
Season.all.each do |season|
	rand(1..(5*season.chapters.count)).times do |x|
		user_id = User.all.to_a.sample.id
		season_id = season.id
		rating = Faker::Number.between(1, 5)
		comment = Faker::Lorem.paragraph
		created_at = Faker::Time.between(season.created_at, Date.today)
		updated_at = Faker::Time.between(created_at, Date.today)
		SeasonsReview.create({user_id: user_id, season_id: season_id, rating: rating, comment: comment, created_at: created_at, updated_at: updated_at})
	end
end

## Chapters reviews
Chapter.all.each do |chapter|
	rand(1..(7*chapter.season.chapters.count)).times do |x|
		user_id = User.all.to_a.sample.id
		chapter_id = chapter.id
		rating = Faker::Number.between(1, 5)
		comment = Faker::Lorem.paragraph
		created_at = Faker::Time.between(chapter.created_at, Date.today)
		updated_at = Faker::Time.between(created_at, Date.today)
		ChaptersReview.create({user_id: user_id, chapter_id: chapter_id, rating: rating, comment: comment, created_at: created_at, updated_at: updated_at})
	end
end


## Rating
Chapter.all.each do |chap|
	chap.update_rating
end

Season.all.each do |sea|
	sea.update_rating
end

Serie.all.each do |serie|
	serie.update_rating
end


## Series news
Serie.all.each do |serie|
	rand(1..20).times do |x|
		user_id = User.all.to_a.sample.id
		serie_id = serie.id
		title = Faker::Book.title
		body = Faker::Lorem.paragraph
		created_at = Faker::Time.between(serie.created_at, Date.today)
		updated_at = Faker::Time.between(created_at, Date.today)
		SeriesNew.create({user_id: user_id, serie_id: serie_id, title: title, body: body, created_at: created_at, updated_at: updated_at})
	end
end

## Actors news
Actor.all.each do |actor|
	rand(1..20).times do |x|
		user_id = User.all.to_a.sample.id
		actor_id = actor.id
		title = Faker::Book.title
		body = Faker::Lorem.paragraph
		created_at = Faker::Time.between(2.months.ago, Date.today)
		updated_at = Faker::Time.between(created_at, Date.today)
		ActorsNew.create({user_id: user_id, actor_id: actor_id, title: title, body: body, created_at: created_at, updated_at: updated_at})
	end
end

## Directors news
Director.all.each do |director|
	rand(1..20).times do |x|
		user_id = User.all.to_a.sample.id
		director_id = director.id
		title = Faker::Book.title
		body = Faker::Lorem.paragraph
		created_at = Faker::Time.between(2.months.ago, Date.today)
		updated_at = Faker::Time.between(created_at, Date.today)
		DirectorsNew.create({user_id: user_id, director_id: director_id, title: title, body: body, created_at: created_at, updated_at: updated_at})
	end
end


## Families
Family.create({name: "Rusia vs Chile", created_at: Faker::Time.between(2.months.ago, Date.today)})
FamilyMember.create({user_id: 1, family_id: 1, parent: 1, created_at: Faker::Time.between(2.months.ago, Date.today)})
FamilyMember.create({user_id: 2, family_id: 1, parent: 1, created_at: Faker::Time.between(2.months.ago, Date.today)})
FamilyMember.create({user_id: 3, family_id: 1, parent: 1, created_at: Faker::Time.between(2.months.ago, Date.today)})

Family.create({name: "Chile vs Portugal", created_at: Faker::Time.between(2.months.ago, Date.today)})
FamilyMember.create({user_id: 4, family_id: 2, parent: 1, created_at: Faker::Time.between(2.months.ago, Date.today)})
FamilyMember.create({user_id: 6, family_id: 2, parent: 0, created_at: Faker::Time.between(2.months.ago, Date.today)})
FamilyMember.create({user_id: 7, family_id: 2, parent: 0, created_at: Faker::Time.between(2.months.ago, Date.today)})
FamilyMember.create({user_id: 8, family_id: 2, parent: 0, created_at: Faker::Time.between(2.months.ago, Date.today)})
FamilyMember.create({user_id: 9, family_id: 2, parent: 0, created_at: Faker::Time.between(2.months.ago, Date.today)})

(User.all.count/6).to_i.times do |x|
	name = Faker::Book.title
	created_at = Faker::Time.between(2.months.ago, Date.today)
	updated_at = Faker::Time.between(created_at, Date.today)
	family = Family.create({name: name, created_at: created_at, updated_at: updated_at})

	user_id = User.where("users.id > 9").to_a.sample.id while FamilyMember.exists?(user_id: user_id)
	created_at_member = Faker::Time.between(created_at, Date.today)
	FamilyMember.create({user_id: user_id, family_id: family.id, parent: 1, created_at: created_at_member, updated_at: created_at_member})
end

## Family members
Family.all.each do |family|
	rand(1..5).times do |x|
		user_id = User.where("users.id > 9").to_a.sample.id while FamilyMember.exists?(user_id: user_id)
		family_id = family.id
		parent = rand(0..1)
		created_at = Faker::Time.between(family.created_at, Date.today)
		updated_at = created_at
		FamilyMember.create({user_id: user_id, family_id: family_id, parent: parent, created_at: created_at, updated_at: updated_at})
	end
end

## Family invitations
Family.all.each do |family|
	rand(0..4).times do |x|
		user_id = User.where("users.id > 9").to_a.sample.id while FamilyMember.exists?(user_id: user_id) or FamilyInvite.exists?(family_id: family.id, user_id: user_id)
		family_id = family.id
		parent = rand(0..1)
		created_at = Faker::Time.between(family.created_at, Date.today)
		updated_at = created_at
		FamilyInvite.create({user_id: user_id, family_id: family_id, parent: parent, created_at: created_at, updated_at: updated_at})
	end
end


## Seen chapters
User.all.each do |user|
	series = (1..Serie.count).to_a.shuffle
	rand(1..5).times do |x|
		chapters = Serie.find(series.pop).chapters.to_a.shuffle
		rand(1..[5, chapters.count].min).times do |x|
			chapter = chapters.pop
			user.add_saw_chapter(Chapter.find(chapter.id))
		end
	end
end
