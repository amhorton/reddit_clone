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
    <<-HTML.html_safe
      <a href="#{comment_url(comment)}">
        #{ h(comment.author.username) } at #{ h(comment.created_at) }
      </a>
      <br>
      #{ h(comment.content) }
    HTML
  end
end
