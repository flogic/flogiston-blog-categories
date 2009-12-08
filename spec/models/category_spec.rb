require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Category do
  before :each do
    @category = Category.new
  end
  
  describe 'attributes' do
    it 'should have a name' do
      @category.should respond_to(:name)
    end
  end
  
  describe 'validations' do
    it 'should error on name if none given' do
      @category.name = nil
      @category.valid?
      @category.errors.should be_invalid(:name)
    end
    
    it 'should not error on name if given' do
      @category.name = 'awesomeness'
      @category.valid?
      @category.errors.should_not be_invalid(:name)
    end
    
    it 'should error on name if using an already-present value' do
      @category.name = Category.generate!.name
      @category.valid?
      @category.errors.should be_invalid(:name)
    end
  end
end
