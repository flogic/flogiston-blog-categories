class Admin::ArticlesController < AdminController
  before_filter :allow_clearing_categories, :only => :update
  
  private
  
  def allow_clearing_categories
    if params[:article]
      params[:article][:category_ids] ||= []
    end
  end
end
