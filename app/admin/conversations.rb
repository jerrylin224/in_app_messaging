ActiveAdmin.register_page "Conversations" do

  controller do
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
      elsif @box.eql? "read"
        @conversations = Mailboxer::Conversation.inbox(current_user)# - Mailboxer::Conversation.unread(current_user)
      else
        @conversations = @mailbox.trash
      end

      @conversations = @conversations.page(params[:page])
    end

    def new
      
    end

    private

      def get_mailbox
        @mailbox ||= current_admin_user.mailbox
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

  content do
    panel "My Panel Test" do
      render partial: "admin/conversations/index"
    end
  end  


  sidebar "Test Sidebar" do
    "Hi World"
  end
end
