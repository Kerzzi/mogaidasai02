class ShoppingCart < ApplicationRecord

  validates :user_uuid, presence: true
  validates :product_id, presence: true
  validates :amount, presence: true

  belongs_to :product

  scope :by_user_uuid, -> (user_uuid) { where(user_uuid: user_uuid) }

  def self.create_or_update! options = {}
    #定义判断的条件，设置哪几个字段作为主键，这里为用户和商品
    cond = {
      user_uuid: options[:user_uuid],
      product_id: options[:product_id]
    }
    
    #进行判断这些主键是否存在
    # 如果记录中已经有了user_uuid或product_id，则更新数量，否则为创建数量。
    record = where(cond).first
    if record
      record.update_attributes!(options.merge(amount: record.amount + options[:amount]))
    else
      record = create!(options)
    end

    record
  end

end
