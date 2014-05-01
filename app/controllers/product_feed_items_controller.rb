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

  # GET /product_feed_items/new
  # GET /product_feed_items/new.json
  def new
    @product_feed_item = ProductFeedItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_feed_item }
    end
  end

  # GET /product_feed_items/1/edit
  def edit
    @product_feed_item = ProductFeedItem.find(params[:id])
  end

  # POST /product_feed_items
  # POST /product_feed_items.json
  def create
    @product_feed_item = ProductFeedItem.new(params[:product_feed_item])

    respond_to do |format|
      if @product_feed_item.save
        format.html { redirect_to @product_feed_item, notice: 'Product feed item was successfully created.' }
        format.json { render json: @product_feed_item, status: :created, location: @product_feed_item }
      else
        format.html { render action: "new" }
        format.json { render json: @product_feed_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_feed_items/1
  # PUT /product_feed_items/1.json
  def update
    @product_feed_item = ProductFeedItem.find(params[:id])

    respond_to do |format|
      if @product_feed_item.update_attributes(params[:product_feed_item])
        format.html { redirect_to @product_feed_item, notice: 'Product feed item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_feed_item.errors, status: :unprocessable_entity }
      end
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
