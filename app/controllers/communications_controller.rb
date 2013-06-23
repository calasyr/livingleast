class CommunicationsController < ApplicationController
  # GET /communications
  # GET /communications.json
  def index
    @communications = Communication.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @communications }
    end
  end

  # GET /communications/1
  # GET /communications/1.json
  def show
    @communication = Communication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @communication }
    end
  end

  # GET /communications/new
  # GET /communications/new.json
  def new
    @communication = Communication.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @communication }
    end
  end

  # GET /communications/1/edit
  def edit
    @communication = Communication.find(params[:id])
  end

  # POST /communications
  # POST /communications.json
  def create
    @communication = Communication.new(params[:communication])

    respond_to do |format|
      if @communication.save
        format.html { redirect_to @communication, notice: 'Communication was successfully created.' }
        format.json { render json: @communication, status: :created, location: @communication }
      else
        format.html { render action: "new" }
        format.json { render json: @communication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /communications/1
  # PUT /communications/1.json
  def update
    @communication = Communication.find(params[:id])

    respond_to do |format|
      if @communication.update_attributes(params[:communication])
        format.html { redirect_to @communication, notice: 'Communication was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @communication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /communications/1
  # DELETE /communications/1.json
  def destroy
    @communication = Communication.find(params[:id])
    @communication.destroy

    respond_to do |format|
      format.html { redirect_to communications_url }
      format.json { head :no_content }
    end
  end
end
