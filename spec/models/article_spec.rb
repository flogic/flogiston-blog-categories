require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Article do
  before :each do
    @article = Article.new
  end
  
  describe 'associations' do
    it 'should have many categorizations' do
      @article.should respond_to(:categorizations)
    end
    
    it 'should have many categories (through categorizations)' do
      @article.should respond_to(:categories)
    end
  end
end
