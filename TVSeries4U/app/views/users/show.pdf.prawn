prawn_document(:filename=>'Report.pdf') do |pdf|
  render "pdf_reports", :pdf => pdf
end
