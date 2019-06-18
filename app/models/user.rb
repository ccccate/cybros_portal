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
  has_many :pending_questions, class_name: "Company::PendingQuestion", dependent: :restrict_with_error

  def admin?
    email.in? Settings.admin.emails
  end

  def knowledge_maintainer?
    email == 'chenzifan@thape.com.cn' || %(忻琳 聂玲玲 冯可 季建杰 柳怡帆).include?(chinese_name)
  end
end
