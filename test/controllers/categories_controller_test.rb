require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

	def setup
		@category = Category.create(name: "Film")
		@user = User.create(username: "John", full_name: "John Dust", email: "dust@gmail.com", password: "password", admin: true)
	end

	test "should get categories index" do
		get :index
		assert_response :success
	end

	test "should get new" do
		session[:user_id] = @user.id
		get :new
		assert_response :success
	end

	test "should get show" do
		get(:show, {'id' => @category.id})
		assert_response :success
	end

	test "should redirect when admin not logged in" do
		assert_no_difference 'Category.count' do
			post :create, category: { name: "Film"}
		end
		assert_redirected_to categories_path
	end

end