
class DIImageSetsFFViewHooks < FatFreeCRM::Callback::Base

  # Some HAML fragments
  
  # New fields for contact object
  HAML_OPPORTUNITY_SHOW_EXT = <<EOS
%br
= content_tag(:div, link_to_inline(:create_image_set, new_image_set_path, :related => dom_id(@opportunity), :text=> t(:create_image_set, :scope => [:di, :image_sets])), :class => "subtitle_tools")
= content_tag(:div, t(:image_sets, :scope => [:di, :image_sets]), :class => :subtitle, :id => :create_image_set_title)
= content_tag(:div, "", :class => :remote, :id => :create_image_set, :style => "display:none;")
.list#image_sets
  = render :partial => "image_sets/image_set", :collection => @opportunity.image_sets.all
EOS


  # Install view hooks for models
  [ :opportunity ].each do |model|

    define_method :"show_#{model}_bottom" do |view, context|
      Haml::Engine.new(HAML_OPPORTUNITY_SHOW_EXT).render(view)
    end

  end
  
end
