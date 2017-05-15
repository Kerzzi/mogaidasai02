class User < ApplicationRecord
  authenticates_with_sorcery!  # 该方法已经注入了usermodel所需的好多方法

  # 由于我们不使用明文保存密码，所以必须在此声明这2个属性，然后才能访问到
  # 可以查看user的shcema是没有这2个属性的
  attr_accessor :password, :password_confirmation

  # validates_presence_of和validates作用一样的，前者是比较传统的写法
  # 第一句等同于 validates :email, presence: true, message: "邮箱不能为空"
  validates_presence_of :email, message: "邮箱不能为空"
  validates_format_of :email, message: "邮箱格式不合法",
    with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
    if: proc { |user| !user.email.blank? } #设置邮箱为空时不触发以上校验方法。
  validates :email, uniqueness: true #定义邮箱的唯一性

  validates_presence_of :password, message: "密码不能为空",
    if: :need_validate_password #if判断为true时，才能触发以上方法。
  validates_presence_of :password_confirmation, message: "密码确认不能为空",
    if: :need_validate_password
  validates_confirmation_of :password, message: "密码不一致",
    if: :need_validate_password
  validates_length_of :password, message: "密码最短为6位", minimum: 6,
    if: :need_validate_password

  has_many :addresses, -> { where(address_type: Address::AddressType::User).order("id desc") }
  belongs_to :default_address, class_name: :Address

  def username
    self.email.split('@').first  # 将email之前的内容取出，作为用户名
  end

  private
  # 这个方法是为了优化，比如首次注册和修改密码时，不触发“密码不能为空”等判断和提示信息。
  def need_validate_password
    self.new_record? ||
      (!self.password.nil? || !self.password_confirmation.nil?)
  end
end
