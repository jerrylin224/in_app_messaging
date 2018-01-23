class Conversation < Mailboxer::Conversation
  scope :read, lambda {|participant|
    participant(participant).merge(Mailboxer::Receipt.is_read)
  }  

  def sender_name
    last_sender.name
  end
end
