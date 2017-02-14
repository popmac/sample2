module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} | Sample2"
    else
      'Sample2'
    end
  end
end
