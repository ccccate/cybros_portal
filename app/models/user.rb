# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, :invitable,
         :recoverable, :rememberable, :confirmable, :trackable, :validatable

  scope :active, -> { where(locked_at: nil) }

  has_many :department_users, dependent: :destroy
  has_many :departments, through: :department_users
  has_many :name_card_applies, dependent: :restrict_with_error

  def admin?
    email.in? Settings.admin.emails
  end
end
