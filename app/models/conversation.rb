class Conversation < Mailboxer::Conversation
  # Make the own scope to make read box effect
  scope :read, lambda {|participant|
    participant(participant).merge(Mailboxer::Receipt.is_read.not_trash.not_deleted)
  }  

  # override the default seeting to make unread conversation be able to move to trash
  # and move unread conversation to trash if same message is trashed in inbox
  scope :unread, lambda {|participant|
    participant(participant).merge(Mailboxer::Receipt.is_unread.not_trash.not_deleted)
  }  

  def sender_name
    last_sender.name
  end
end
