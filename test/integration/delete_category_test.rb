require "test_helper"

class DeleteCategoryTest < ActionDispatch::IntegrationTest

  def setup 
    @category = Category.create(name: "Nature")
    @admin_user = User.create(username: "John", email: "john@mail.com", password: "123", admin: true)
  end


  test "delete category" do
    
    log_in_as(@admin_user)

    assert_difference 'Category.count', -1 do
      delete category_url(@category)
    end

    follow_redirect!
    assert_match 'categories', response.body

  end
end
