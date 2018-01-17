ActiveAdmin.register_page "Messages" do

  # collection_action :new, method: :get do
  #   @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
  # end

  controller do
     def new
      @chosen_recipient = AdminUser.find_by(id: params[:to].to_i) if params[:to]
    end

    def create
      recipients = User.where(id: params['recipients'])
      conversation = current_admin_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
      flash[:success] = "Message has been sent!"
      redirect_to conversation_path(conversation)
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
