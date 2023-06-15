class Part < FlexibleContent

  def self.format_name
    "part"
  end

  def rendering_app
    Whitehall::RenderingApp::GOVERNMENT_FRONTEND
  end

  def rummager_index
    :parts
  end

  def display_type_key
    "part"
  end


  def self.search_format_type
    "part"
  end

  def base_path
    "/part/#{slug}"
  end

  # NOTE: List below is things that could be needed in future

  # Added as they need a Gov relation but keeping it slim at starting
  # def government
  #   @government ||= Government.on_date(date_for_government) unless date_for_government.nil?
  # end

end
