require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper]))

describe 'admin/categories/edit.html.haml' do
  before :each do
    assigns[:category] = @category = Category.generate!
  end
  
  def do_render
    render 'admin/categories/edit.html.haml'
  end
  
  it 'should have an edit-category form' do
    do_render
    response.should have_tag('form[id=?]', "edit_category_#{@category.id}")
  end
  
  describe 'edit-category form' do
    it 'should use the category update action' do
      do_render
      response.should have_tag('form[id=?][action=?][method=?]', "edit_category_#{@category.id}", admin_category_path(@category), 'post') do
        with_tag('input[name=?][value=?]', '_method', 'put')
      end
    end
    
    it 'should have a name input' do
      do_render
      response.should have_tag('form[id=?]', "edit_category_#{@category.id}") do
        with_tag('input[type=?][name=?]', 'text', 'category[name]')
      end
    end
    
    it 'should populate the name input' do
      do_render
      response.should have_tag('form[id=?]', "edit_category_#{@category.id}") do
        with_tag('input[name=?][value=?]', 'category[name]', @category.name)
      end
    end

    it 'should have a submit button' do
      do_render
      response.should have_tag('form[id=?]', "edit_category_#{@category.id}") do
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
