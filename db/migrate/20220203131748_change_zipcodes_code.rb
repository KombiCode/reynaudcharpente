class ChangeZipcodesCode < ActiveRecord::Migration[7.0]
  def up
    safety_assured {
      change_table :zipcodes do |t|
        t.change :code, :string
      end
    }
  end

  def down
    safety_assured {
      change_table :zipcodes do |t|
        t.change :code, :integer
      end
    }
  end
end
