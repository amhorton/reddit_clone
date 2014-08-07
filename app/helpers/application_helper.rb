module ApplicationHelper
  def auth_token
    <<-HTML.html_safe
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
    HTML
  end

  def vote_buttons(obj)
    downvote_url = obj.is_a?(Post) ? post_downvote_url(obj) : comment_downvote_url(obj)
    upvote_url = obj.is_a?(Post) ? post_upvote_url(obj) : comment_upvote_url(obj)

    <<-HTML.html_safe
      #{obj.score}
      <form action="#{upvote_url}" method="POST">
        #{auth_token}
        <button>Upvote</button>
      </form>
      <form action="#{downvote_url}" method="POST">
        #{auth_token}
        <button>Downvote</button>
      </form>
    HTML
  end


  def render_all_comments(comment_hash)
    parents = comment_hash[nil].page(1).per(10)

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
      <a href="#{comment_url(parent)}" id="c#{parent.id}">
        #{ h(parent.author.username) } at #{ h(parent.created_at) }
      </a>
      <br>
      #{ h(parent.content) }
      <br>
      #{vote_buttons(parent)}
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
