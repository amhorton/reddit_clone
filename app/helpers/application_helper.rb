module ApplicationHelper
  def auth_token
    <<-HTML.html_safe
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
    HTML
  end
  #
  # <a href="<%= comment_url(comment) %>">
  #   <%= comment.author.username %> at <%= comment.created_at %>
  # </a>
  # <br>
  # <%= comment.content %>

  def render_all_comments(comment_hash)
    parents = comment_hash[nil]

    html = ""
    parents.each do |parent|
      html += "<li>"
      html += render_children(parent, comment_hash)
      html += "</li>"
    end

    html.html_safe
  end

  def render_children(parent, comment_hash)
    html = <<-HTML.html_safe
      <a href="#{comment_url(parent)}">
        #{ h(parent.author.username) } at #{ h(parent.created_at) }
      </a>
      <br>
      #{ h(parent.content) }
      <br>
    HTML

    children = comment_hash[parent.id]

    children.each do |child|
      html += "<ul><li>".html_safe
      html += render_children(child, comment_hash)
      html += "</li></ul>".html_safe
    end

    html
  end




end
