class CreateImageSets < ActiveRecord::Migration

  def self.up

    create_table :image_sets do |t|
      t.string   :asset_type,        :null => true,  :default => nil,           :limit => 255
      t.integer  :asset_id,          :null => true,  :default => nil
      t.string   :name,              :null => false, :default => nil,           :limit => 100
      t.string   :description,       :null => true,  :default => '',            :limit => 255
      t.integer  :created_by,        :null => false, :default => nil
      t.string   :flickr_tags,       :null => false, :default => nil,           :limit => 100
      t.integer  :image_set_type_id, :null => false, :default => nil
      t.integer  :flickr_account_id, :null => false, :defailt => nil
      t.datetime :deleted_at
      t.timestamps
    end

    add_index  :image_sets, [:asset_type, :asset_id], :unique => false, :name => 'ix_image_sets_asset_type_asset_id'    

  end


  def self.down
    remove_index  :image_sets, :ix_image_sets_asset_type_asset_id
    drop_table    :image_sets
  end

end
