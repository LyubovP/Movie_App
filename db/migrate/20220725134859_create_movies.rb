class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :category, default: 0
      t.string :rating
      t.integer  :user_id


      t.timestamps
    end
  end
end
