module Helpers

  def current_parent(session)
    if session[:id] != nil
      Parent.find(session[:id])
    end
  end

  def logged_in?(session)
    if session[:id] != nil
      parent_id = current_parent(session).id
      session[:id] == parent_id ? true : false
    end
  end

  def current_child(id)
    Child.find(id)
  end

  def current_milestone(id)
    Milestone.find(id)
  end

end