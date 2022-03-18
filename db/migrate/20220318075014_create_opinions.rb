class CreateOpinions < ActiveRecord::Migration[7.0]
  def change
    create_table :opinions do |t|
      t.string :title
      t.string :description
      t.string :details_title
      t.string :details
      t.string :control
      t.date :realized_at
      t.date :filed_at
      t.date :published_at
      t.string :reference

      t.timestamps
    end
  end
end
