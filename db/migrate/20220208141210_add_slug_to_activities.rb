class AddSlugToActivities < ActiveRecord::Migration[7.0]
  def up
    safety_assured {
      add_column :activities, :slug, :string, :null => false
      add_index :activities, :slug, :unique => true
    }
  end

  def down
    safety_assured {
      remove_column :activities, :slug
    }
  end
end
