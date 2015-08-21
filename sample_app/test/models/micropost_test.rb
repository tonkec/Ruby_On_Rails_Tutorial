require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:antonija)
    @micropost = @user.microposts.build(content: "Lorem Ipsum")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid? 
  end

  test "content should be present" do
    @micropost.content = ""
    assert_not @micropost.valid?
  end

  test "content should not be longer than 140 chr" do
    @micropost.content = "" * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

  
end
