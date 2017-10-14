pdf.text "Report for #{@user.name}", align: :center, size: 24

pdf.text "\n"

pdf.text "Seen chapters per serie", align: :center, size: 16
table_data = [["<b>Serie</b>", "<b>Season</b>", "<b>Chapter</b>"]]
table_data = table_data + chapters_per_serie(@user)
pdf.table(table_data, :width => 450, position: :center, :cell_style => { inline_format: true, align: :center })

pdf.text "\n"

graph_chapters_per_serie @user
pdf.image "public/images/pdfs/#{@user.id}_1.png", :width => 450, position: :center

pdf.text "\n"

graph_time_on_chapters @user
pdf.image "public/images/pdfs/#{@user.id}_2.png", :width => 450, position: :center