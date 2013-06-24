require 'Fetcher'


class PurchasesController < ApplicationController
  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all.reverse
    @user_purchases = current_user.purchases

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purchases }
    end
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @purchase }
    end
  end

  # GET /purchases/new
  # GET /purchases/new.json
  def new
    @purchase = Purchase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase }
    end
  end

  # GET /purchases/1/edit
  def edit
    @purchase = Purchase.find(params[:id])
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(params[:purchase])
    @purchase.user_id = current_user.id

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
        format.json { render json: @purchase, status: :created, location: @purchase }
      else
        format.html { render action: "new" }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  def hook
    message_data = params[:message_data]
    account_id = params[:account_id]
    unless message_data.nil?
      message_id = message_data[:message_id]
      unless message_id.nil? || account_id.nil?
        fetcher = Fetcher.new(account_id, message_id)
        matched = fetcher.fetch
        unless matched.nil? || matched.valid == false

          purchase = Purchase.new
          purchase.merchant_name = matched.merchant
          purchase.category = matched.category
          purchase.city = matched.location
          purchase.amount = matched.amount

          if purchase.save
            render :json => { :result => "ok", :purchase => matched }.as_json, :status => 202
          else
            render :json => { :result => "failed to save", :purchase => matched }.as_json, :status => 503
          end
        else
          render :json => { :result => "no purchases found" }.as_json, :status => 204
        end
      else
        render :json => { :result => "fail", :message => "missing message_id"}.as_json, :status => 422
      end
    else
      render :json => { :result => "fail", :message => "missing message_data"}.as_json, :status => 422
    end
  end

  # PUT /purchases/1
  # PUT /purchases/1.json
  def update
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      if @purchase.update_attributes(params[:purchase])
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to purchases_url }
      format.json { head :no_content }
    end
  end

end
