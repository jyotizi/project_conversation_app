class Project < ApplicationRecord
  STATUSES = ['open', 'in_progress', 'closed'].freeze

  has_many :project_activities, dependent: :destroy

  validates :title, :description, :status, presence: true
end
