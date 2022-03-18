class AddReferenceIndexToOpinion < ActiveRecord::Migration[7.0]
  def up
    safety_assured {
      add_index :opinions, :reference
    }
  end
  def down
    safety_assured {
      remove_index :opinions, :reference
    }
  end
end
