class ProjectActivity < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :activity_type, presence: true
  validate :validate_activity_fields

  private

  def validate_activity_fields
    case activity_type
    when 'status_change'
      errors.add(:old_status, "can't be blank") if old_status.blank?
      errors.add(:new_status, "can't be blank") if new_status.blank?
    when 'comment'
      errors.add(:comment, "can't be blank") if comment.blank?
    else
      errors.add(:activity_type, "must be either 'comment' or 'status_change'")
    end
  end
end
