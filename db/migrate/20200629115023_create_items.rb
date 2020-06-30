class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.integer :item_img, null: false, foreign_key:true
      t.references :category, null: false, foreign_key:true
      # t.references :brand, foreign_key:true
      # t.references :item_condition, null: false, foreign_key:true
      # t.references :postage_payer, null: false, foreign_key:true
      # t.references :preparation_day, null: false, foreign_key:true
      # t.references :postage_type, null: false, foreign_key:true
      t.integer :prefecture_code, null: false
      t.integer :trading_status, null: false, limit: 1
      t.references :buyer, foreign_key: { to_table: :users }
      t.references :seller, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
