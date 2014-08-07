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

  def render_comment(comment)
    html = <<-HTML.html_safe
      <a href="#{comment_url(comment)}">
        #{ h(comment.author.username) } at #{ h(comment.created_at) }
      </a>
      <br>
      #{ h(comment.content) }
      <br>
    HTML

    comment.child_comments.each do |child|
      html += "<ul><li>".html_safe
      html += render_comment(child)
      html += "</li></ul>".html_safe
    end

    html
  end
end
