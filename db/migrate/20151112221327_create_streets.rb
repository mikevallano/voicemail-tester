class CreateStreets < ActiveRecord::Migration
  def change
    create_table :streets do |t|
      t.string :name
      t.string :image

      t.timestamps null: false
    end
  end
end
