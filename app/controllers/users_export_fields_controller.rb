class UsersExportFieldsController < ApplicationController
  before_filter :check_plugin_enabled

  def edit
    users_export_field
  end

  def update
    users_export_field

    @users_export_field.fields = params['users_export_field']

    if @users_export_field.save
      flash[:notice] = l(:users_export_fields_saved)
      redirect_to users_path
    else
      render action: :edit
    end
  end

  private

  def users_export_field
    return @users_export_field if defined?(@users_export_field)

    user = User.current

    if user.users_export_field.present?
      @users_export_field = user.users_export_field
    else
      @users_export_field = user.build_users_export_field
      @users_export_field.fields = Setting.plugin_users_export['default_fields']
    end
  end

  def check_plugin_enabled
    if Setting.plugin_users_export.nil? or !Setting.plugin_users_export[:users_export_enabled]
      render_404
    end
  end
end
