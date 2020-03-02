class CreateSportCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :sport_categories do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
