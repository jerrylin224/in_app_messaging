class AddShowNotificationInMailboxerNotification < ActiveRecord::Migration
  def change
    add_column :mailboxer_notifications, :show_notification, :boolean, default: :true
  end
end
