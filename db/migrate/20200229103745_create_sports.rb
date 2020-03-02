class CreateSports < ActiveRecord::Migration[6.0]
  def change
    create_table :sports do |t|
      t.string :name
      t.integer :frequence
      t.date :date_begin
      t.references :user, null: false, foreign_key: true
      t.references :sport_categorie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
