# Associate certain core models with image_sets
#----------------------------------------------------------------------------
[ Opportunity ].each do |klass|
  klass.class_eval do
    has_many    :image_sets, :as => :asset, :dependent => :destroy, :order => 'created_at DESC'
  end
end