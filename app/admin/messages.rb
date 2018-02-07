ActiveAdmin.register_page "Messages" do
  controller do
    layout 'active_admin' 

    def new
      @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
      render "admin/messages/new"#, layout: "active_admin"
    end

    def create
      case params[:receipients]
      when "all"
        recipients = User.all
      # recipients = User.where(id: params['recipients'])
      else
        recipients = User.where(id: params['recipients'])
      end
      conversation = current_admin_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
      flash[:success] = "Message has been sent!"
      redirect_to conversation_path(conversation)
    end
  end

  # page_action :new, method: :get  do
  #   @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
  #   render partial: "admin/messages/new"
  # end

  content do
    panel "My Panel Test" do
      render partial: "admin/conversations/index"
    end
  end  


  sidebar "Test Sidebar" do
    "Hi World"
  end
end
