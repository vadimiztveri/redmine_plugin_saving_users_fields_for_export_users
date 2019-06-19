class UsersExportField < ActiveRecord::Base
  validates :user_id, presence: true
  validates :fields, presence: true

  serialize :fields, JSON

  belongs_to :user, inverse_of: :users_export_field
end
