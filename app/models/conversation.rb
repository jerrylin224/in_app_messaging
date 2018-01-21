class Conversation < Mailboxer::Conversation
  scope :read, lambda {|participant|
    participant(participant).merge(Mailboxer::Receipt.is_read)
  }  
end
