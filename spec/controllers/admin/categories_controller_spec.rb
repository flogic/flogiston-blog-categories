require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Admin::CategoriesController do
  describe 'index' do
    before :each do
      @categories = Array.new(3) { |i|  Category.generate! }
    end
    
    def do_get
      get :index
    end
    
    it 'should be successful' do
      do_get
      response.should be_success
    end
    
    it 'should make the categories available to the view' do
      do_get
      assigns[:categories].should == @categories
    end
    
    it 'should make an empty array available to the view if there are no categories' do
      Category.delete_all
      do_get
      assigns[:categories].should == []
    end
    
    it 'should render the index template' do
      do_get
      response.should render_template('admin/categories/index')
    end
    
    it 'should use the admin layout' do
      do_get
      response.layout.should == 'layouts/admin'
    end
  end
  
  describe 'new' do
    def do_get
      get :new
    end
    
    it 'should be successful' do
      do_get
      response.should be_success
    end
    
    it 'should make a new category available to the view' do
      do_get
      assigns[:category].should be_instance_of(Category)
      assigns[:category].should be_new_record
    end
    
    it 'should render the new template' do
      do_get
      response.should render_template('admin/categories/new')
    end
    
    it 'should use the admin layout' do
      do_get
      response.layout.should == 'layouts/admin'
    end
  end
  
  describe 'create' do
    before :each do
      @category = Category.spawn
    end
    
    def do_post
      post :create, :category => { :name => 'Awesomesauce' }
    end
    
    it 'should create a new category' do
      lambda { do_post }.should change(Category, :count).by(1)
    end
    
    it 'should use the provided attributes when creating the category' do
      Category.delete_all
      do_post
      Category.first.name.should == 'Awesomesauce'
    end
    
    it 'should redirect to the admin list view' do
      Category.delete_all
      do_post
      response.should redirect_to(admin_categories_path)
    end
    
    describe 'when saving is unsuccessful' do
      before :each do
        @category.name = 'Test Name #198273'
        Category.any_instance.stubs(:save).returns(false)
      end
      
      def do_post
        post :create, :category => @category.attributes
      end
      
      it 'should be successful' do
        do_post
        response.should be_success
      end
      
      it 'should make a new category available to the view' do
        do_post
        assigns[:category].should be_new_record
      end
      
      it 'should initialize the category with the given attributes' do
        do_post
        assigns[:category].name.should == @category.name
      end
      
      it 'should render the new template' do
        do_post
        response.should render_template('admin/categories/new')
      end
      
      it 'should use the admin layout' do
        do_post
        response.layout.should == 'layouts/admin'
      end
    end
  end
  
  describe 'edit' do
    before :each do
      @category = Category.generate!
      @category_id = @category.id.to_s
    end
    
    def do_get
      get :edit, :id => @category_id
    end
    
    it 'should find the requested category' do
      Category.expects(:find).with(@category_id).returns(@category)
      do_get
    end
    
    it 'should make the found category available to the view' do
      do_get
      assigns[:category].should == @category
    end
    
    it 'should render the edit template' do
      do_get
      response.should render_template('admin/categories/edit')
    end
    
    it 'should use the admin layout' do
      do_get
      response.layout.should == 'layouts/admin'
    end
  end
  
  describe 'update' do
    before :each do
      @category = Category.generate!(:name => 'Awesomesauce')
      @category_id = @category.id.to_s
    end
    
    def do_put
      put :update, :id => @category_id, :category => { :name => 'Coolness' }
    end
    
    it 'should find the requested category' do
      Category.expects(:find).with(@category_id).returns(@category)
      do_put
    end
    
    it 'should use the provided attributes when updating the category' do
      do_put
      @category.reload
      @category.name.should == 'Coolness'
    end
    
    it 'should redirect to the admin list view' do
      do_put
      response.should redirect_to(admin_categories_path)
    end
    
    describe 'when saving is unsuccessful' do
      before :each do
        @category.stubs(:save).returns(false)
        Category.stubs(:find).with(@category_id).returns(@category)
        @new_name = 'Freakazoid'
      end
      
      def do_put
        put :update, :id => @category_id, :category => @category.attributes.merge('name' => @new_name)
      end
      
      it 'should be successful' do
        do_put
        response.should be_success
      end
      
      it 'should make the requested category available to the view' do
        do_put
        assigns[:category].id.should == @category.id
      end
      
      it 'should set the category attributes' do
        do_put
        assigns[:category].name.should == @new_name
      end
      
      it 'should render the edit template' do
        do_put
        response.should render_template('admin/categories/edit')
      end
      
      it 'should use the admin layout' do
        do_put
        response.layout.should == 'layouts/admin'
      end
    end
  end
  
  describe 'destroy' do
    before :each do
      @category = Category.generate!
      @category_id = @category.id.to_s
    end

    def do_delete
      delete :destroy, :id => @category_id
    end

    it 'should destroy the specified category' do
      do_delete
      Category.find_by_id(@category_id).should be_nil
    end

    it 'should redirect to the admin categories list' do
      do_delete
      response.should redirect_to(admin_categories_path)
    end
  end
end
