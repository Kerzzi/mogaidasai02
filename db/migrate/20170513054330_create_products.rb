class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :category_id
      t.string :title
      t.string :status, default: 'off'
      #指示商品状态，如上架、下架，设置为string模式方便后续增加状态数量，而且更为直观

      t.integer :amount, default: 0
      t.string :uuid   #商品的序列号，方便后期增加功能
      t.decimal :msrp, precision: 10, scale: 2  #msrp商品原价的缩写，用于打折等
      t.decimal :price, precision: 10, scale: 2 #商品真实价格
      t.text :description  #商品描述
      t.timestamps
    end

    #养成习惯建立一张表时，最好将索引建立好，主要用于搜索
    add_index :products, [:status, :category_id]
    add_index :products, [:category_id]
    add_index :products, [:uuid], unique: true  #在数据库层面限制序列号的唯一性
    add_index :products, [:title]
  end
end
