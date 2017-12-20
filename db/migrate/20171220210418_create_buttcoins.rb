class CreateButtcoins < ActiveRecord::Migration[5.1]
  def change
    create_table :buttcoins do |t|
      t.references :user, foreign_key: true
      t.integer :amount
      t.string :note

      t.timestamps
    end
  end
end
