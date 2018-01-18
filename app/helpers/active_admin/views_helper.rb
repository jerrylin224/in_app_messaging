module ActiveAdmin::ViewsHelper #camelized file name
  def admin_mailbox_section(title, current_box, opts = {})
    opts[:class] = opts.fetch(:class, '')
    opts[:class] += ' active' if title.downcase == current_box
    content_tag :li, link_to(title.capitalize, admin_conversations_path(box: title.downcase)), opts
  end
end 
