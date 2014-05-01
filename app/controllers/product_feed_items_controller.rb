class ProductFeedItemsController < ApplicationController
  # GET /product_feed_items
  # GET /product_feed_items.json
  def index
    @user_id = params[:user_id]
    @product_feed_items = ProductFeedItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_feed_items }
    end
  end

  # GET /product_feed_items/1
  # GET /product_feed_items/1.json
  def show
    @user_id = params[:user_id]
    @product_feed_item = ProductFeedItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_feed_item }
    end
  end

  # DELETE /product_feed_items/1
  # DELETE /product_feed_items/1.json
  def destroy
    @product_feed_item = ProductFeedItem.find(params[:id])
    @product_feed_item.destroy

    respond_to do |format|
      format.html { redirect_to user_product_feed_items_url(params[:user_id]) }
      format.json { head :no_content }
    end
  end
end
