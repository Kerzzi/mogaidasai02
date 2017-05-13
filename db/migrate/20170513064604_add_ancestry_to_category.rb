class AddAncestryToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :ancestry, :string

    #利用字段来索引当前分类的上下级树形关系
    add_index :categories, [:ancestry]
  end
end
