# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  deleted_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_paranoid
  has_many :products
  has_one :withdrawal
  validates :email, uniqueness_without_deleted: true

  # オーバライドしてemailのユニーク制約だけを削除
  def self.included(base)
    base.extend ClassMethods
    assert_validations_api!(base)

    base.class_eval do
      validates_presence_of   :email, if: :email_required?
      # validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
      validates_format_of     :email, with: email_regexp, allow_blank: true, if: :email_changed?

      validates_presence_of     :password, if: :password_required?
      validates_confirmation_of :password, if: :password_required?
      validates_length_of       :password, within: password_length, allow_blank: true
    end
  end
end
