class AddNoteToRating < ActiveRecord::Migration[7.0]
  def up
    safety_assured {
      add_column :ratings, :note, :decimal
    }
  end
  def down
    safety_assured {
      remove_column :ratings, :note
    }
  end
end
