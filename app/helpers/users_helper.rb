module UsersHelper

#  def gravatar_for(user, options = { :size => 50 } )
#    gravatar_image_tag(user.email.downcase, :alt => user.name,
#                                            :class => 'gravatar',
#                                            :gravatar => options)
#  end


  def gravatar_for(user, options = { :size => 50, :class => 'gravatar' } )
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => options[:class],
                                            :gravatar => { :size => options[:size] } )
    # Ugly code in the line above.  
    # Somebody please save me!
  end
  
end
