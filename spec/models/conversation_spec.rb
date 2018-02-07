require 'spec_helper'

describe Conversation do
  describe ".read" do
    it "returns all conversation in read box" do
      sender = FactoryBot.build(:user)
      receiver = FactoryBot.build(:user)
      conversation = sender.send_message(receiver, "Body", "Subject").conversation
      conversation.mark_as_read(receiver)
      message_in_readbox = Conversation.read(receiver).last
      expect(Conversation.find(conversation.id)).to eq(message_in_readbox)
    end
  end

  describe ".unread" do
    it "returns unread message" do
      sender = FactoryBot.build(:user)
      receiver = FactoryBot.build(:user)
      conversation = sender.send_message(receiver, "Body", "Subject").conversation
      message_in_unreadbox = Conversation.unread(receiver).last
      expect(Conversation.find(conversation.id)).to eq(message_in_unreadbox)
    end
  end
end