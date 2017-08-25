module Helpers

  def current_parent(session)
    if session[:id] != nil && Parent.ids.include?(session[:id])
      Parent.find(session[:id])
    else
      return nil
    end
  end

  def logged_in?(session)
    if session[:id] != nil && current_parent(session) != nil
      parent_id = current_parent(session).id
      session[:id] == parent_id ? true : false
    end
  end

  def current_child(slug)
    Child.find_by_slug(params[:slug])
  end

  def current_milestone(id)
    Milestone.find(id)
  end

end