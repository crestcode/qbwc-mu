require 'test_helper'

class ProductFeedItemsControllerTest < ActionController::TestCase
  setup do
    @product_feed_item = product_feed_items(:one)
  end

  test "should get index" do
    get :index, user_id: @product_feed_item.user_id
    assert_response :success
    assert_not_nil assigns(:product_feed_items)
  end

  test "should show product_feed_item" do
    get :show, user_id: @product_feed_item.user_id, id: @product_feed_item
    assert_response :success
  end

  test "should destroy product_feed_item" do
    assert_difference('ProductFeedItem.count', -1) do
      delete :destroy, user_id: @product_feed_item.user_id, id: @product_feed_item
    end

    assert_redirected_to user_product_feed_items_path(@product_feed_item.user_id)
  end
end
