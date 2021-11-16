module ApplicationHelper

  def gravatar_for(user)

    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=200"
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")

  end

  def current_user
    if session[:user_id]
      @current_user = @current_user || User.find(session[:user_id])
    end
  end

  def logged_in?
    !!current_user
  end


end
