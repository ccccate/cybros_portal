class NameCardApply < ApplicationRecord
  belongs_to :user

  auto_strip_attributes :title, :english_name

  validates :department_name, :title, :english_name, :en_department_name,
    :en_title, :mobile, :print_out_box_number, presence: true
  validate :title_exclude_from_black_title, if: Proc.new { Current.user.present? }

  private

  def title_exclude_from_black_title
    if title.in?(NameCardBlackTitle.where(original_title: Current.user.position_title).pluck(:required_title))
      errors.add(:title, :title_is_blocked)
    end
  end
end
