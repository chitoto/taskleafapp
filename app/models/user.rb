class User < ApplicationRecord
  before_update :updated_no_one_has_an_admin
  before_destroy :destroy_no_one_has_an_admin
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy

  private
  def destroy_no_one_has_an_admin
    if User.where(admin: true).count == 1 && self.admin?
      errors.add(:admin, 'adminがいなくなります！')
      throw :abort
      return false
    end
  end

  def updated_no_one_has_an_admin
    if User.where(admin:[true]).count == 1 && self.admin == false
      errors.add(:admin, 'adminがいなくなります！')
      throw :abort
    end
  end
end
