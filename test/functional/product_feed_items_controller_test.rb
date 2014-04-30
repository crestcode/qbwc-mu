require 'test_helper'

class ProductFeedItemsControllerTest < ActionController::TestCase
  setup do
    @product_feed_item = product_feed_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_feed_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_feed_item" do
    assert_difference('ProductFeedItem.count') do
      post :create, product_feed_item: { description: @product_feed_item.description, inventory: @product_feed_item.inventory, item_identifier: @product_feed_item.item_identifier, name: @product_feed_item.name, price: @product_feed_item.price, user_id: @product_feed_item.user_id }
    end

    assert_redirected_to product_feed_item_path(assigns(:product_feed_item))
  end

  test "should show product_feed_item" do
    get :show, id: @product_feed_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_feed_item
    assert_response :success
  end

  test "should update product_feed_item" do
    put :update, id: @product_feed_item, product_feed_item: { description: @product_feed_item.description, inventory: @product_feed_item.inventory, item_identifier: @product_feed_item.item_identifier, name: @product_feed_item.name, price: @product_feed_item.price, user_id: @product_feed_item.user_id }
    assert_redirected_to product_feed_item_path(assigns(:product_feed_item))
  end

  test "should destroy product_feed_item" do
    assert_difference('ProductFeedItem.count', -1) do
      delete :destroy, id: @product_feed_item
    end

    assert_redirected_to product_feed_items_path
  end
end
