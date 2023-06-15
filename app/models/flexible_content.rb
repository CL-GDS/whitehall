class FlexibleContent < ApplicationRecord

  def self.format_name
    "flexi-content"
  end

  def rendering_app
    Whitehall::RenderingApp::GOVERNMENT_FRONTEND
  end

  def rummager_index
    :flexible_contents
  end

  def display_type_key
    "flexible_content"
  end

  def search_format_types
    super + [FlexibleContent.search_format_type]
  end

  def self.search_format_type
    "flexi-content"
  end

  def base_path
    "/flexi-content/#{slug}"
  end

  def related_child_parts
    related_to_editions.where(type: "FlexibleContent").pluck(:id)
  end

  # NOTE: List below is things that could be needed in future

  # Added as they need a Gov relation but keeping it slim at starting
  # def government
  #   @government ||= Government.on_date(date_for_government) unless date_for_government.nil?
  # end

end
