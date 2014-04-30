class QbwcController < ApplicationController
  require 'Quickbooks'
  require 'rexml/document'
  protect_from_forgery :except => :api

  def qwc
    user = User.find(params[:user_id])
    if user
      qwc = <<-QWC
      <QBWCXML>
      <AppName>QBWC Multiuser Example</AppName>
      <AppID>QB</AppID>
      <AppURL>http://localhostmac:3000/apis/quickbooks/api</AppURL>
      <AppDescription>Rails-Quickbooks Integration</AppDescription>
      <AppSupport>http://localhostmac:3000/</AppSupport>
      <UserName>#{user[:username]}</UserName>
      <OwnerID>#{QBWC.owner_id}</OwnerID>
      <FileID>{90A44FB5-33D9-4815-AC85-BC87A7E7D1EB}</FileID>
      <QBType>QBPOS</QBType>
      <Scheduler>
        <RunEveryNMinutes>5</RunEveryNMinutes>
      </Scheduler>
      </QBWCXML>
      QWC
      send_data qwc, :filename => 'qbwc_mu.qwc'
    end
  end

  def api

    # increase entity_expansion_text_limit during web connector sessions for large (25+ items) pulls
    REXML::Document.entity_expansion_text_limit = 5_000_000

    # respond successfully to a GET which some versions of the Web Connector send to verify the url
    if request.get?
      render :nothing => true
      return
    end


    if params["Envelope"]["Body"].keys.first == "authenticate"

      username = params["Envelope"]["Body"]["authenticate"]["strUserName"]
      password = params["Envelope"]["Body"]["authenticate"]["strPassword"]

      user = User.find_by_username_and_password(username, password)

      if user

        QBWC.company_file_path = "Computer Name=#{user.computer_name};Company Data=#{user.company_data};Version=#{user.version}"

        # Clear the user's job queue each time (if not nil)
        QBWC.jobs[user.username].clear if QBWC.jobs[user.username]

        QBWC.add_job(user.username, :import_vendors) do
          '
          <?qbposxml version="3.0"?>
          <QBPOSXML>
          <QBPOSXMLMsgsRq onError="stopOnError">
            <ItemInventoryQueryRq>
            </ItemInventoryQueryRq>
          </QBPOSXMLMsgsRq>
          </QBPOSXML>
        '
        end

        QBWC.jobs[user.username][:import_vendors].set_response_proc do |qbxml|
          #puts "====================Dumping QBXML====================="
          #puts qbxml

          # If only a single item is returned, a hash is returned instead of an array, so we convert the hash into an array
          if qbxml["item_inventory_ret"].class == Hash
            item_inventory_ret_temp = qbxml["item_inventory_ret"]
            qbxml["item_inventory_ret"] = Array.new
            qbxml["item_inventory_ret"] << item_inventory_ret_temp
          end
          if qbxml["item_inventory_ret"]
            qbxml["item_inventory_ret"].each do |item|
              item_identifier = item["list_id"]

              product_feed_item = ProductFeedItem.find_by_item_identifier_and_user_id(item_identifier, user.id)
              product_feed_item ||= ProductFeedItem.new
              product_feed_item.item_identifier = item_identifier
              product_feed_item.user_id = user.id
              product_feed_item.name = item["desc1"]
              product_feed_item.description = item["desc2"]
              product_feed_item.inventory = item["on_hand_store01"]
              product_feed_item.price = item["price1"]
              product_feed_item.save
            end
          end
        end
      end
    end

    req = request
    puts "========== #{ params["Envelope"]["Body"].keys.first}  =========="
    res = QBWC::SoapWrapper.route_request(req)
    render :xml => res, :content_type => 'text/xml'
  end

end