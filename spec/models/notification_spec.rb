require 'spec_helper'

describe Notification do
  describe ".user_unread" do
    it "returns current user's unread notification" do
      sender = FactoryBot.build(:random_user)
      receiver = FactoryBot.build(:random_user)
      sender.send_message(receiver, "Body", "Subject")
      notification = Mailboxer::Notification.recipient(receiver).last
      expect(notification).to eq(Notification.user_unread(receiver).last)
    end
  end

  describe ".seen_count" do
    it "returns the number of user's unread notification" do
      sender = FactoryBot.create(:random_user)
      receiver = FactoryBot.create(:random_user)
      sender.send_message(receiver, "Body", "Subject")
      notification = Mailboxer::Notification.recipient(receiver)
      expect(notification.count).to eq(Notification.unseen_count(receiver))
    end
  end
end