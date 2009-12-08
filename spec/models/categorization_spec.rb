require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Categorization do
  before :each do
    @categorization = Categorization.new
  end
  
  describe 'attributes' do
    it 'should have an article ID' do
      @categorization.should respond_to(:article_id)
    end
    
    it 'should have a category ID' do
      @categorization.should respond_to(:category_id)
    end
  end
  
  describe 'associations' do
    it 'should belong to article' do
      @categorization.should respond_to(:article)
    end
    
    it 'should belong to category' do
      @categorization.should respond_to(:category)
    end
  end
end
