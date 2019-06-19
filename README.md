## Saving user's fields for export users

Plugin for Redmine

#### Run migration
rake redmine:plugins:migrate NAME=plugin-saving-users-fields-for-export-users RAILS_ENV=production

#### Model
Model UsersExportField has association with User has_one.

#### Settings
In plugin's settings instaled default field for export.

#### GetUsersExportFields
Singlton class GetUsersExportFields return fields in JSON format.

#### TypeConverter
Singlton class TypeConverter return value in the required format.
Has formats:
* date
* boolean
* status
* notification
* type
* group
* other

#### Using
Plagin don't create export. It returnet fields for user in JSON format. Example:
~~~~
{redmine_fields:
  [
    {
      title: "Логин",
      property: :login,
      type: :string
    },
    {
      title: "Имя",
      property: :firstname,
      type: :string,
    },
    {
      title: "Фамилия",
      property: :lastname,
      type: :string,
    {
      title: "Администратор?",
      property: :admin,
      type: :boolean,
    {
      title: "Статус",
      property: :status,
      type: :status,
    {
      title: "Последний вход в систему",
      property: :last_login_on,
      type: :date,
    {
      title: "Последнее обновление",
      property: :updated_on,
      type: :date
    }
  ],
 :custom_fields=>[
    {
      id: 34,
      alias: :custom_field_34
    }
 ]
}

~~~~

Plugin return fields from model User:
* login,
* firstname,
* lastname,
* admin,
* status,
* mail_notification,
* last_login_on,
* created_on,
* updated_on,
* mail,
* groups

And all custom fields for User.

#### Controller and View
By address:
~~~~
/edit_users_export_fields
~~~~
user can change his field settings for export.
