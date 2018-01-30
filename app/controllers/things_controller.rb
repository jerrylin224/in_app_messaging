class ThingsController < ApplicationController
  def index
    @subjects = current_user.messages.pluck(:subject)
    @conversations = Conversation.all.inbox(current_user)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Your_filename",
        template: "things/index.pdf.erb",
        locals: {subjects: @subjects}
        # layout: 'application.html'
      end
    end
  end

  def show
    @conversations = Conversation.all.inbox(current_user)
    # respond_to do |format|
    #   format.html
    #   format.pdf #do
    #     # render pdf: "index"   # Excluding ".pdf" extension.
    #   # end
    # end
  end

  def edit
    @conversations = Conversation.all.inbox(current_user)
  end
end