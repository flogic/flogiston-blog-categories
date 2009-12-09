require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper]))

describe 'admin/categories/new.html.haml' do
  before :each do
    assigns[:category] = @category = Category.new
  end
  
  def do_render
    render 'admin/categories/new.html.haml'
  end
  
  it 'should have a new-category form' do
    do_render
    response.should have_tag('form[id=?]', 'new_category')
  end
  
  describe 'new-category form' do
    it 'should use the category create action' do
      do_render
      response.should have_tag('form[id=?][action=?][method=?]', 'new_category', admin_categories_path, 'post')
    end
    
    it 'should have a name input' do
      do_render
      response.should have_tag('form[id=?]', 'new_category') do
        with_tag('input[type=?][name=?]', 'text', 'category[name]')
      end
    end
    
    it 'should have a submit button' do
      do_render
      response.should have_tag('form[id=?]', 'new_category') do
        with_tag('input[type=?]', 'submit')
      end
    end
  end
  
  describe 'when errors are available' do
    it 'should display errors in an error region' do
      @category.errors.add_to_base("error on this page")
      do_render
      response.should have_tag('div[class=?]', 'errors', :text => /error on this page/)
    end
  end
  
  describe 'when no errors are available' do
    it 'should not display errors' do
      do_render
      response.should_not have_tag('div[class=?]', 'errors')
    end
  end
end
