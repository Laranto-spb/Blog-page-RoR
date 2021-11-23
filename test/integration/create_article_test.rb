require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "John", email: "john@mail.com", password: "123", admin: true)
    log_in_as(@user)
  end

  test 'create a new article' do
    get '/articles/new'
    assert_response :success

    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "Some title", description: "Some description", user_id: @user}}
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success

    assert_match 'Some title', response.body
    assert_match 'Some description', response.body
  end

  test 'create article with an empty title' do
    get '/articles/new'
    assert_response :success

    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: " ", description: "Some description", user_id: @user}}
    end

    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'

  end

end
