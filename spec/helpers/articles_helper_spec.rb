require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe ArticlesHelper do
  describe 'custom form fields' do
    it 'should include categories' do
      helper.custom_form_fields.should include('categories')
    end
  end
end
