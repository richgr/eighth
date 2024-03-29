module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    logo_img = "logo.png"
    if @logo_img.nil?
      image_tag(logo_img, :alt => "Sample App", :class => "round")
    else  
      image_tag(@logo_img, :alt => "Sample App", :class => "round")
    end
  end
  
end
