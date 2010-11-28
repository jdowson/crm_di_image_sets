
# Extend application wide helper methods
module CRMDIImageSets

  module FFViewHelpers
 
    #----------------------------------------------------------------------------
    def link_to_image_set_edit(image_set)
      link_to_remote(t(:edit),
        :url    => edit_image_set_path(image_set),
        :method => :get,
        :with   => "{ previous: crm.find_form('edit_image_set') }"
      )
    end
  
    #----------------------------------------------------------------------------
    def link_to_image_set_preview(image_set)
      link_to_remote(t(:preview, :scope => [:di, :image_sets]),
        :url    => preview_image_set_path(image_set),
        :method => :get,
        :with   => "{  }"
      )
    end

    #----------------------------------------------------------------------------
    def link_to_image_set_delete(image_set)
      link_to_remote(t(:delete) + "!",
        :url    => image_set_path(image_set),
        :method => :delete,
        :with   => "{  }",
        :before => visual_effect(:highlight, dom_id(image_set), :startcolor => "#ffe4e1")
      )
    end

    #----------------------------------------------------------------------------
    def link_to_image_set_preview_icon(image_set)
      img = image_tag("/plugin_assets/crm_di_image_sets/images/camera_48.png", :height => "32px", :width => "32px", :alt => "#{t(:icon_alt_preview, :scope => [:di, :image_sets])}", :style => "float:left; padding-right:0.75em; padding-left:0.25em;")
      link_to_remote(img,
        :url    => preview_image_set_path(image_set),
        :method => :get,
        :with   => "{  }"
      )
    end

    #----------------------------------------------------------------------------
    def link_to_image_set_edit_icon(image_set)
      img = image_tag("/plugin_assets/crm_di_image_sets/images/camera_add_48.png", :height => "32px", :width => "32px", :alt => "#{t(:icon_alt_edit, :scope => [:di, :image_sets])}", :style => "float:left; padding-right:0.75em; padding-left:0.25em;")
      link_to(img,
        "http://www.flickr.com/photos/56458652@N08/",
        :target => "_blank",
        :with   => "{  }"
      )
    end

  end

end

ActionView::Base.send(:include, CRMDIImageSets::FFViewHelpers)