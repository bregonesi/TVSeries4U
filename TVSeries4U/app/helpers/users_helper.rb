module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
   gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
   size = options[:size]
   gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
   image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def edad(dob)
   now = Time.now.utc.to_date
   now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def chapters_per_serie(user)
    info = []
    user.seen_chapters.each { |chap| info << [chap.season.serie.title, chap.season.name, chap.name] }
    info
  end

  def graph_chapters_per_serie(user)
    g = Gruff::StackedBar.new(450)
    g.title = "Chapters per serie"
    g.segment_spacing = 0
    series = user.seen_series.joins(:seasons).joins(:chapters).group("series.id").count("chapters.id")

    labels = {}
    series.each_with_index { |val, index| labels[index] = Serie.find(val[0]).title }
    g.labels = labels

    data = []
    series.each { |val| data << val[1] }

    g.data "#{user.name}", data
    g.write("public/images/pdfs/#{user.id}_1.png")
  end

  def graph_time_on_chapters(user)
    g = Gruff::StackedArea.new(450)
    g.title = "Time spent watching series"
    series = user.seen_chapters.order(:length).group(:length).count

    labels = {}
    series.each_with_index { |val, index| labels[index] = val[0] }
    g.labels = labels
    
    data = []
    series.each do |val|
      if data.count != 0
        data << data.last + (val[0] * val[1]) 
      else
        data << val[0] * val[1]
      end
    end

    g.data "#{user.name}", data
    g.write("public/images/pdfs/#{user.id}_2.png")
  end
end
