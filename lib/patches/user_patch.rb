module Patches
  module UserPatch
    def self.included(base)
      base.class_eval do
        has_one :users_export_field, inverse_of: :user, dependent: :destroy
      end
    end
  end
end
