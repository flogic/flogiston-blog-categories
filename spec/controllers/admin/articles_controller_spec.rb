require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Admin::ArticlesController do
  describe 'create' do
    before :each do
      @categories = Array.new(3) { Category.generate! }
      @article = Article.spawn
    end
    
    def do_post
      post :create, :article => { :category_ids => @categories.values_at(0,-1).collect(&:id) }
    end
    
    it 'should add the provided categories to the created article' do
      Article.delete_all
      do_post
      Article.first.categories.sort_by(&:id).should == @categories.values_at(0,-1).sort_by(&:id)
    end
  end
  
  describe 'update' do
    before :each do
      @categories = Array.new(5) { Category.generate! }
      @article = Article.generate!(:category_ids => @categories.values_at(0,-1).collect(&:id) )
      @article_id = @article.id.to_s
    end
    
    def do_put
      put :update, :id => @article_id, :article => { :category_ids => @categories.values_at(1, -2).collect(&:id) }
    end
    
    it 'should change the article categories to the provided categories' do
      do_put
      @article.reload
      @article.categories.sort_by(&:id).should == @categories.values_at(1,-2).sort_by(&:id)
    end
    
    it 'should clear the article categories if none are provided' do
      put :update, :id => @article_id, :article => {}
      @article.reload
      @article.categories.should == []
    end
  end
end
