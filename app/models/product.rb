class Product < ApplicationRecord
  belongs_to :category

  before_create :set_default_attrs #商品建立之前，先生成一个随机序列号


  private
  def set_default_attrs
    self.uuid = RandomCode.generate_product_uuid
    #使用已定义好的外部库函数生成，在外部库lib/tasks/random_code.rb中
  end
end
