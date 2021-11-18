require "test_helper"

class DeleteCategoryTest < ActionDispatch::IntegrationTest

  def setup 
    @category = Category.create(name: "Nature")
  end


  test "delete category" do

    assert_difference 'Category.count', -1 do
      delete category_url(@category)
    end

    follow_redirect!
    assert_match 'categories', response.body

  end
end
