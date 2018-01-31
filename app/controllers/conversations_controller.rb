class ConversationsController < ApplicationController
  REPLY_SUBJECT_PREFIX = "Re:"

  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index, :empty_trash, :new_move_to_trash]
  before_action :get_box, only: [:index]

  def index
    if @box.eql? "inbox"
      @conversations = @conversations.inbox(current_user)
    elsif @box.eql? "sent"
      @conversations = @conversations.sentbox(current_user)
    elsif @box.eql? "unread"
      @conversations = @conversations.unread(current_user)
    
      Notification.user_unread(current_user).update_all(show_notification: false)
      # .inbox.unread(current_user)
    elsif @box.eql? "read"
      @conversations = @conversations.read(current_user)
    else
      @conversations = @conversations.trash(current_user)
    end
    @conversations = @conversations.page(params[:page]).per(5)
  end

  def show
    @conversation.mark_as_read(current_user) if @conversation.is_unread?(current_user)
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
    @conversations.where(id: params[:conversation_ids]).each do |conversation|
      conversation.move_to_trash(current_user)
    end
    flash[:success] = 'The conøversation was moved to trash.'
    redirect_to :back
  end

  def restore
    @conversation.untrash(current_user)
    flash[:success] = 'The conversation was restored.'
    redirect_to conversations_path
  end

  def empty_trash
    @conversations.trash(current_user).each do |conversation|
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

  def toggle_pinned
    if @conversation.pin == true
      @conversation.update(pin: false)
    else
      @conversation.update(pin: true)
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { head :ok }
    end
  end

  private

    def get_mailbox
      @q = Conversation.ransack(params[:q])
      @conversations = @q.result(distinct: true).includes(:messages)#.(distinct: true)

      # @mailbox ||= current_user.mailbox
    end

    def get_conversation
      @conversation ||= @conversations.find(params[:id])
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
