class AddPinInMailboxerConversation < ActiveRecord::Migration
  def change
    add_column :mailboxer_conversations, :pin, :boolean, default: :false
  end
end
