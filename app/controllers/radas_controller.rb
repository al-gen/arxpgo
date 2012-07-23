class RadasController < ApplicationController
  before_filter :authenticate_user!
  # GET /radas
  # GET /radas.json
  def index
    @radas = Rada.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @radas }
    end
  end

  # GET /radas/1
  # GET /radas/1.json
  def show
    @rada = Rada.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rada }
    end
  end

  # GET /radas/new
  # GET /radas/new.json
  def new
    @rada = Rada.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rada }
    end
  end

  # GET /radas/1/edit
  def edit
    @rada = Rada.find(params[:id])
  end

  # POST /radas
  # POST /radas.json
  def create
    @rada = Rada.new(params[:rada])

    respond_to do |format|
      if @rada.save
        format.html { redirect_to @rada, notice: 'Rada was successfully created.' }
        format.json { render json: @rada, status: :created, location: @rada }
      else
        format.html { render action: "new" }
        format.json { render json: @rada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /radas/1
  # PUT /radas/1.json
  def update
    @rada = Rada.find(params[:id])

    respond_to do |format|
      if @rada.update_attributes(params[:rada])
        format.html { redirect_to @rada, notice: 'Rada was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @rada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /radas/1
  # DELETE /radas/1.json
  def destroy
    @rada = Rada.find(params[:id])
    @rada.destroy

    respond_to do |format|
      format.html { redirect_to radas_url }
      format.json { head :ok }
    end
  end
end
