class MultiPart < Edition

  has_many :multi_part_parts
  def self.format_name
    "multi-part"
  end

  def rendering_app
    Whitehall::RenderingApp::GOVERNMENT_FRONTEND
  end

  def rummager_index
    :multi_parts
  end

  def display_type_key
    "multi_part"
  end

  def search_format_types
    super + [MultiPart.search_format_type]
  end

  def self.search_format_type
    "multi-part"
  end

  def base_path
    "/multi-part/#{slug}"
  end

  def related_child_parts
    related_to_editions.where(type: "MultiPartParts").pluck(:id)
  end

  # NOTE: List below is things that could be needed in future

  # Added as they need a Gov relation but keeping it slim at starting
  # def government
  #   @government ||= Government.on_date(date_for_government) unless date_for_government.nil?
  # end

end
