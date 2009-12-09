require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper]))

describe Admin::CategoriesController do
  describe 'mapping routes' do
    it "should map { :controller => 'admin/categories', :action => 'index' } to /admin/categories" do
      route_for(:controller => 'admin/categories', :action => 'index').should == '/admin/categories'
    end
    
    it "should map { :controller => 'admin/categories', :action => 'new' } to /admin/categories/new" do
      route_for(:controller => 'admin/categories', :action => 'new').should == '/admin/categories/new'
    end
    
    it "should map { :controller => 'admin/categories', :action => 'create' } to /admin/categories" do
      route_for(:controller => 'admin/categories', :action => 'create').should == { :path => '/admin/categories', :method => :post }
    end
    
    it "should map { :controller => 'admin/categories', :action => 'edit', :id => '1' } to /admin/categories/1/edit" do
      route_for(:controller => 'admin/categories', :action => 'edit', :id => '1').should == '/admin/categories/1/edit'
    end
    
    it "should map { :controller => 'admin/categories', :action => 'update', :id => '1' } to /admin/categories/1" do
      route_for(:controller => 'admin/categories', :action => 'update', :id => '1').should == { :path => '/admin/categories/1', :method => :put }
    end
    
    it "should map { :controller => 'admin/categories', :action => 'destroy', :id => '1' } to /admin/categories/1" do
      route_for(:controller => 'admin/categories', :action => 'destroy', :id => '1').should == { :path => '/admin/categories/1', :method => :delete }
    end
  end
  
  describe 'generating params' do
    it "should generate params { :controller => 'admin/categories', action => 'index' } from GET /admin/categories" do
      params_from(:get, '/admin/categories').should == { :controller => 'admin/categories', :action => 'index' }
    end
    
    it "should generate params { :controller => 'admin/categories', action => 'new' } from GET /admin/categories/new" do
      params_from(:get, '/admin/categories/new').should == { :controller => 'admin/categories', :action => 'new' }
    end
    
    it "should generate params { :controller => 'admin/categories', action => 'create' } from POST /admin/categories/new" do
      params_from(:post, '/admin/categories').should == { :controller => 'admin/categories', :action => 'create' }
    end
    
    it "should generate params { :controller => 'admin/categories', action => 'edit', :id => '1' } from GET /admin/categories/1/edit" do
      params_from(:get, '/admin/categories/1/edit').should == { :controller => 'admin/categories', :action => 'edit', :id => '1' }
    end
    
    it "should generate params { :controller => 'admin/categories', action => 'update', :id => '1' } from PUT /admin/categories/1" do
      params_from(:put, '/admin/categories/1').should == { :controller => 'admin/categories', :action => 'update', :id => '1' }
    end
    
    it "should generate params { :controller => 'admin/categories', action => 'destroy', :id => '1' } from DELETE /admin/categories/1" do
      params_from(:delete, '/admin/categories/1').should == { :controller => 'admin/categories', :action => 'destroy', :id => '1' }
    end
  end
end
