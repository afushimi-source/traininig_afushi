class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  before_update :if_not_admin_none, if: Proc.new { |user| !user.admin && User.where(admin: true).count == 1 }
  before_destroy :if_not_admin_none, if: Proc.new { |user| user.admin && User.where(admin: true).count == 1 }
  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  private

  def if_not_admin_none
    p '=========='
    p self.admin
    errors.add(:admin_none, '管理者ユーザーが0人になるため操作を実行できません')
    throw(:abort)
  end
end
