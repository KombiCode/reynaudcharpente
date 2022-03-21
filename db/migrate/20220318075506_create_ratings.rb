class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.references :category, null: false, foreign_key: true
      t.references :opinion, null: false, foreign_key: true

      t.timestamps
    end
  end
end