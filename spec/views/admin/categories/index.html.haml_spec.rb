require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper]))

describe 'admin/categories/index.html.haml' do
  before :each do
    @category = Category.generate!
    assigns[:categories] = [@category]
  end
  
  def do_render
    render 'admin/categories/index.html.haml'
  end
  
  it 'should have a categories list' do
    do_render
    response.should have_tag('table[id=?]', 'categories')
  end
  
  describe 'categories list' do
    it 'should have a row for the category' do
      do_render
      response.should have_tag('table[id=?]', 'categories') do
        with_tag('tbody') do
          with_tag('tr')
        end
      end
    end
    
    it 'should include the category name' do
      do_render
      response.should have_tag('table[id=?]', 'categories') do
        with_tag('tbody') do
          with_tag('tr', :text => Regexp.new(Regexp.escape(@category.name)))
        end
      end
    end
    
    it 'should link to edit the category' do
      do_render
      response.should have_tag('table[id=?]', 'categories') do
        with_tag('tbody') do
          with_tag('tr') do
            with_tag('a[href=?]', edit_admin_category_path(@category))
          end
        end
      end
    end
    
    it 'should link to destroy the category' do
      do_render
      response.should have_tag('table[id=?]', 'categories') do
        with_tag('tbody') do
          with_tag('tr') do
            with_tag('a[href=?][onclick*=?]', admin_category_path(@category), 'delete')
          end
        end
      end
    end
    
    it 'should have a list item for every category' do
      other_category = Category.generate!
      assigns[:categories] = [@category, other_category]
      
      do_render
      response.should have_tag('table[id=?]', 'categories') do
        with_tag('tbody') do
          [@category, other_category].each do |category|
            with_tag('tr', :text => Regexp.new(Regexp.escape(category.name)))
          end
        end
      end
    end
    
    it 'should have no list items if there are no categories' do
      assigns[:categories] = []
      do_render
      response.should have_tag('table[id=?]', 'categories') do
        with_tag('tbody') do
          without_tag('tr')
        end
      end
    end
  end

  it 'should link to create a new category' do
    do_render
    response.should have_tag('a[href=?]', new_admin_category_path)
  end
end
