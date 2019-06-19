class GetUsersExportFields
  def self.redmine_fields_default
    presents_fields = Setting.plugin_users_export['default_fields']
    redmine_fields(presents_fields)
  end

  def self.user_custom_fields_default
    custom_fields = UserCustomField.all
    user_custom_fields(custom_fields)
  end

  def self.for_user
    if User.current&.users_export_field.present?
      fields = User.current.users_export_field.fields.map{ |key, value| key.to_sym }
      get_data(fields)
    else
      fields = Setting.plugin_users_export['default_fields']
      get_data(fields)
    end
  end

  private

  def self.get_data(fields)
    redmine_fields = []
    custom_fields = []

    fields.each{ |field|
      if field.to_s[0, 13] == 'custom_field_'
        id = field.to_s[13, 20].to_i
        custom_fields << { id: id, alias: field }
      else
        type = all_redmine_fields[field]
        redmine_fields << { title: I18n.t("settings.redmine_fields.#{field}"), property: field, type: type }
      end
    }

    { redmine_fields: redmine_fields, custom_fields: custom_fields }
  end

  def self.redmine_fields(fields)
    columns = all_redmine_fields.map{ |key, type| key }
    columns_with_values = {}

    columns.each do |column|
      columns_with_values[column] = if fields[column].present?
                                      fields[column]
                                    else
                                      false
                                    end
    end

    columns_with_values
  end

  def self.all_redmine_fields
    {
      login: :strin,
      firstname: :string,
      lastname: :string,
      admin: :boolean,
      status: :status,
      mail_notification: :notification,
      last_login_on: :date,
      created_on: :date,
      updated_on: :date,
      mail: :string,
      groups: :groups
    }
  end

  def self.user_custom_fields(custom_fields)
    columns_with_values = []

    custom_fields.each do |custom_field|
      custom_field_id = "custom_field_#{custom_field.id}"
      custom_field_data = {
        custom_field_id: custom_field_id,
        value: false,
        name: custom_field.name
      }

      if Setting.plugin_users_export['default_fields'][custom_field_id].present?
        custom_field_data[:value] = Setting.plugin_users_export['default_fields'][custom_field_id]
      end

      columns_with_values << custom_field_data
    end

    columns_with_values
  end
end
