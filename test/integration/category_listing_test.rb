require "test_helper"

class CategoryListingTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "Sport")
    @category2 = Category.create(name: "Travel")
  end


  test "listing of categories" do
    get '/categories'
    assert_select 'a[href=?]', category_path(@category), text: @category.name
    assert_select 'a[href=?]', category_path(@category2), text: @category2.name
  end
end
