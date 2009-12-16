require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe AdminHelper do
  describe 'admin sections' do
    it 'should include categories' do
      helper.admin_sections.should include('categories')
    end
  end
end
