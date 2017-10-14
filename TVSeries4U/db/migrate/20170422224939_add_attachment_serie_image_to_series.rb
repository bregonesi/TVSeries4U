class AddAttachmentSerieImageToSeries < ActiveRecord::Migration
  def self.up
    change_table :series do |t|
      t.attachment :serie_image
    end
  end

  def self.down
    remove_attachment :series, :serie_image
  end
end
