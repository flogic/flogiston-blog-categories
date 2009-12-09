require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper]))

describe 'admin/articles/edit.html.haml' do
  before :each do
    assigns[:article] = @article = Article.generate!
    @categories = Array.new(3) { Category.generate! }
  end
  
  def do_render
    render 'admin/articles/edit.html.haml'
  end
  
  describe 'edit-article form' do
    it 'should have checkboxes for assigning categories' do
      do_render
      response.should have_tag('form[id=?]', "edit_article_#{@article.id}") do
        @categories.each do |category|
          with_tag('input[type=?][name=?][value=?]', 'checkbox', 'article[category_ids][]', category.id)
        end
      end
    end
    
    it 'should have no category checkboxes if no categories exist' do
      do_render
      response.should have_tag('form[id=?]', "edit_article_#{@article.id}") do
        without_tag('input[type=?][name=?]', 'checkbox', 'article[category_ids[]]')
      end
    end
  end
end
