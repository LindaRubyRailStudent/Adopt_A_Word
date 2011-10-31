class WordiesController < ApplicationController
  # GET /wordies
  # GET /wordies.json
  def index
    @wordies = Wordy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wordies }
    end
  end

  # GET /wordies/1
  # GET /wordies/1.json
  def show
    @wordy = Wordy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wordy }
    end
  end

  # GET /wordies/new
  # GET /wordies/new.json
  def new
    @wordy = Wordy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wordy }
    end
  end

  # GET /wordies/1/edit
  def edit
    @wordy = Wordy.find(params[:id])
  end

  # POST /wordies
  # POST /wordies.json
  def create
    @wordy = Wordy.new(params[:wordy])

    respond_to do |format|
      if @wordy.save
        format.html { redirect_to @wordy, notice: 'Wordy was successfully created.' }
        format.json { render json: @wordy, status: :created, location: @wordy }
      else
        format.html { render action: "new" }
        format.json { render json: @wordy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wordies/1
  # PUT /wordies/1.json
  def update
    @wordy = Wordy.find(params[:id])

    respond_to do |format|
      if @wordy.update_attributes(params[:wordy])
        format.html { redirect_to @wordy, notice: 'Wordy was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @wordy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wordies/1
  # DELETE /wordies/1.json
  def destroy
    @wordy = Wordy.find(params[:id])
    @wordy.destroy

    respond_to do |format|
      format.html { redirect_to wordies_url }
      format.json { head :ok }
    end
  end
end
