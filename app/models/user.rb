class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  before_update :check_admin_none, if: proc { |user| !user.is_admin && User.where(is_admin: true).count == 1 }
  before_destroy :check_admin_none, if: proc { |user| user.is_admin && User.where(is_admin: true).count == 1 }
  before_save { email.downcase! }

  has_secure_password

  private

  def check_admin_none
    errors.add(:admin_none, '管理者ユーザーが0人になるため操作を実行できません')
    throw(:abort)
  end
end
