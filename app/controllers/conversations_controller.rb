class ConversationsController < ApplicationController
  REPLY_SUBJECT_PREFIX = "Re:"

  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index, :empty_trash]
  before_action :get_box, only: [:index]

  def index
    if @box.eql? "inbox"
      @conversations = @mailbox.inbox
    elsif @box.eql? "sent"
      @conversations = @mailbox.sentbox
    elsif @box.eql? "unread"
      @conversations = @mailbox.inbox({:read => false})
      # .inbox.unread(current_user)
    elsif @box.eql? "read"
      @conversations = current_user.mailbox.inbox.participant(current_user).merge(Mailboxer::Receipt.is_read)
    else
      @conversations = @mailbox.trash
    end

    @conversations = @conversations.page(params[:page]).per(10)
  end

  def show
    @conversation.mark_as_read(current_user)
  end

  def reply
    # current_user.reply_to_conversation(@conversation, params[:body], subject="test")
    # current_user.reply_to_sender(@conversation.receipts.last, params[:body], "Reply")
    # flash[:success] = 'Reply sent'
    # redirect_to conversation_path(@conversation)
    recipients = User.where(id: @conversation.receipts.last.receiver_id)
    current_user.send_message(recipients, params[:message][:body], replied_subject)
    flash[:success] = "Message has been replied!"
    redirect_to conversation_path(@conversation)
    # redirect_to conversation_path(conversation)
  end

  def destroy
    @conversation.move_to_trash(current_user)
    flash[:success] = 'The conversation was moved to trash.'
    redirect_to conversations_path
  end

  def new_move_to_trash
    byebug
    redirect_to conversations_path
    # @conversation.move_to_trash(current_user)
    # flash[:success] = 'The conversation was moved to trash.'
    # redirect_to conversations_path
  end

  def restore
    @conversation.untrash(current_user)
    flash[:success] = 'The conversation was restored.'
    redirect_to conversations_path
  end

  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = 'Your trash was cleaned!'
    redirect_to conversations_path
  end

  def mark_as_read
    @conversation.mark_as_read(current_user)
    flash[:success] = 'The conversation was marked as read.'
    redirect_to conversations_path
  end

  private

    def get_mailbox
      @mailbox ||= current_user.mailbox
    end

    def get_conversation
      @conversation ||= @mailbox.conversations.find(params[:id])
    end

    def get_box
      if params[:box].blank? or !["inbox", "sent", "trash", "read", "unread"].include?(params[:box])
        params[:box] = 'inbox'
      end
      
      @box = params[:box]
    end

    def replied_subject
      new_subject = @conversation.subject
      new_subject.include?(REPLY_SUBJECT_PREFIX) ? new_subject : "#{REPLY_SUBJECT_PREFIX + new_subject}"
    end
end
