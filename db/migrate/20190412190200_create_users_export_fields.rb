class CreateUsersExportFields < ActiveRecord::Migration
  def self.up
    create_table :users_export_fields do |t|
      t.column :user_id, :integer
      # t.column :fields, :json
      t.column :fields, :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end unless table_exists? :users_export_fields
  end

  def self.down
    drop_table :users_export_fields if table_exists? :users_export_fields
  end
end
