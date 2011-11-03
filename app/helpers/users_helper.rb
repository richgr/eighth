module UsersHelper

  def gravatar_for(user, options = { :size => 50 } )
    options[:class] ||= 'gravatar'
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => options[:class],
                                            :gravatar => options)
  end
  
end
