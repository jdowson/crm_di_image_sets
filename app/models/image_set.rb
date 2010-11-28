
# Table name: image_sets
#
#      t.string   :asset_type,        :null => true,  :default => nil,           :limit => 255
#      t.integer  :asset_id,          :null => true,  :default => nil
#      t.string   :name,              :null => false, :default => nil,           :limit => 100
#      t.string   :description,       :null => true,  :default => '',            :limit => 255
#      t.integer  :created_by,        :null => false, :default => nil
#      t.string   :flickr_tags,       :null => false, :default => nil,           :limit => 100
#      t.integer  :image_set_type_id, :null => false, :default => nil
#      t.integer  :flickr_account_id, :null => false, :defailt => nil
#      t.datetime :deleted_at
#      t.timestamps

class ImageSet < ActiveRecord::Base

  # Attributes accessible from outside the model
  attr_accessible       :asset_type, :asset_id, :name, :description, :created_by, :flickr_tags, :flickr_account_id, :image_set_type_id

  # Model Callbacks

  # Relationships
  belongs_to            :creator,    :class_name  => "User", :foreign_key => :created_by
  belongs_to            :asset,      :polymorphic => true
  has_many              :activities, :as => :subject, :order => 'created_at DESC'

  # Default behaviour
  default_scope         :order      => 'created_at DESC'
  
  # Standard behaviours
  simple_column_search  :name, :match => :middle, :escape => lambda { |query| query.gsub(/[^\w\s\-\.']/, "").strip }
  acts_as_commentable
  acts_as_paranoid

  # Validations
  validates_presence_of :name, :created_by, :flickr_tags, :flickr_account_id, :image_set_type_id

  validates_length_of   :name,        :maximum => 100
  validates_length_of   :description, :maximum => 255, :allow_blank => true
  validates_length_of   :flickr_tags, :maximum => 100

  # Private methods
  private

end
