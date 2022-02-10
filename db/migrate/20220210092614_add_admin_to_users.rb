class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def up
    safety_assured {
      add_column :users, :admin, :boolean, null: false, default: false
    }
  end

  def down
    safety_assured {
      remove_column :users, :admin
    }
  end
end
