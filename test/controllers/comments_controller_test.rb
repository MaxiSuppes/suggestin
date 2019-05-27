require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
  end

  test "unlogged user can't see comments" do
    get comments_url
    assert_response :redirect
  end

  test "unlogged user can't see a comment" do
    get comment_url(@comment)
    assert_response :redirect
  end

  test "unlogged user can add a new comment" do
    get new_comment_url
    assert_response :success
  end

  test "unlogged user can create comment" do
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { content: @comment.content, user_id: @comment.user_id } }
    end

    assert_redirected_to comment_url(Comment.last)
  end
end
