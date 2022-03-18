class RemoveDetailsTitleFromOpinion < ActiveRecord::Migration[7.0]
  def up
    safety_assured {
      remove_column :opinions, :details_title
    }
  end
  def down
    safety_assured {
      add_column :opinions, :details_title
    }
  end
end
