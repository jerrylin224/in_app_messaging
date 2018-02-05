class Notification < Mailboxer::Notification
  # scope :user_unread, lambda { |recipient|
  #   joins(:receipts).where(:mailboxer_receipts => { :receiver_id  => recipient.id, :receiver_type => recipient.class.base_class.to_s, :is_read => false })
  # }
  def self.user_unread(recipient)
    Mailboxer::Notification.joins(:receipts).where(:mailboxer_receipts => { :receiver_id  => recipient.id, :receiver_type => recipient.class.base_class.to_s, :is_read => false })
  end

  # count the newly created conversation since last time user visit unread box
  def self.seen_count(recipient)
    Mailboxer::Notification.joins(:receipts).where(:show_notification => "true",:mailboxer_receipts => { :receiver_id  => recipient.id, :receiver_type => recipient.class.base_class.to_s, :is_read => false }).count
  end
end