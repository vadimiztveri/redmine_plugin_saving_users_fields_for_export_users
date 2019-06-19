Redmine::Plugin.register :users_export do
  name 'Users Export plugin'
  author 'Vadim Galkin'
  description "Saving user's fields for export Users List to CSV and XMLX"
  version '0.0.1'

  settings partial: 'settings/users_export', default: {
              'users_export_enabled' => false,
              'default_fields' => {
                'login' => true,
                'firstname' => true,
                'lastname' => true,
                'admin' => true,
                'status' => false,
                'mail_notification' => true,
                'last_login_on' => true,
                'created_on' => true
              }
            }
end

Rails.application.config.to_prepare do
  unless User.included_modules.include?(Patches::UserPatch)
    User.send(:include, Patches::UserPatch)
  end
end
