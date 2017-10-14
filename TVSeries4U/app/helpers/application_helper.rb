module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Series4U"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  
  def date_diff(date1, date2, units=:months)
    seconds_between = (date2.to_i - date1.to_i).abs
    days_between = seconds_between / 60 / 60 / 24

    case units
    when :days
      days_between.floor
    when :months 
      (days_between / 30).floor
    when :years
      (days_between / 365).floor
    else
      seconds_between.floor
    end
  end

  def average_review(object)
    @rating = object.reviews.average("rating")
    if !@rating
      0
    else
      @rating
    end
  end
end
