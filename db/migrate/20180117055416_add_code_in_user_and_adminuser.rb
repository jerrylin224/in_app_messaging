class AddCodeInUserAndAdminuser < ActiveRecord::Migration
  def change
    add_column :users, :code, :string
    add_column :admin_users, :code, :string
  end
end
