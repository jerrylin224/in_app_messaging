module ConversationsHelper
  UNREAD_BOX_FOLER = "unread"

  def mailbox_section(title, current_box, opts = {})
    opts[:class] = opts.fetch(:class, '')
    opts[:class] += ' active' if title.downcase == current_box
    content_tag :li, link_to(title.capitalize, conversations_path(box: title.downcase)), opts
  end

  def style_unread_conversation(conversation)
    (params[:box] == UNREAD_BOX_FOLER && @conversations.count.nonzero?) ? UNREAD_BOX_FOLER : ''
  end

  def submit_tag_section
    if params[:box] == "trash"
      submit_tag("Empty trash") +
      submit_tag("Restore conversation", name: "restore")
    else
      submit_tag "Move to trash"
    end
  end
end
