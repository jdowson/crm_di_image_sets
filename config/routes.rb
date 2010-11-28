
ActionController::Routing::Routes.draw do |map|

  map.resources :image_sets,
    :collection => {
      :auto_complete   => :post
    },
    :member => {
      :preview         => :get,
      :preview_frame   => :get,
      :preview_gallery => :get,
      :gallery_xml     => :get
    }

end