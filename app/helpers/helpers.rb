module Helpers

  def current_parent
    @current_parent ||= Parent.find_by(:id => session[:parent_id]) if session[:parent_id]
  end

  def logged_in?
    !!current_parent
  end

  def current_child(slug)
    Child.find_by_slug(params[:slug])
  end

  def current_milestone(id)
    Milestone.find(id)
  end

end