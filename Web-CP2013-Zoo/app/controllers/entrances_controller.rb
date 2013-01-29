class EntrancesController < ApplicationController
  # GET /entrances
  # GET /entrances.json
  def index
    @cage = Cage.find(params[:cage_id])
    @entrances = @cage.entrances

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entrances }
    end
  end

  # GET /entrances/1
  # GET /entrances/1.json
  def show
    @entrance = Entrance.find(params[:id])
    @cage = @entrance.cage

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entrance }
    end
  end

  # GET /entrances/new
  # GET /entrances/new.json
  def new
    @cage = Cage.find(params[:cage_id])

    @entrance = @cage.entrances.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entrance }
    end
  end

  # GET /entrances/1/edit
  def edit
    @entrance = Entrance.find(params[:id])
    @cage = @entrance.cage
  end

  # POST /entrances
  # POST /entrances.json
  def create
    @cage = Cage.find(params[:cage_id])
    @entrance = @cage.entrances.build(params[:entrance])

    respond_to do |format|
      if @entrance.save
        format.html { redirect_to cage_entrance_path(@cage, @entrance), notice: 'Entrance was successfully created.' }
        format.json { render json: @entrance, status: :created, location: cage_entrance_path(@cage, @entrance) }
      else
        format.html { render action: "new" }
        format.json { render json: @entrance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entrances/1
  # PUT /entrances/1.json
  def update
    @entrance = Entrance.find(params[:id])
    @cage = @entrance.cage

    respond_to do |format|
      if @entrance.update_attributes(params[:entrance])
        format.html { redirect_to cage_entrance_path(@cage, @entrance), notice: 'Entrance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entrance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entrances/1
  # DELETE /entrances/1.json
  def destroy
    @entrance = Entrance.find(params[:id])
    @cage = @entrance.cage
    @entrance.destroy

    respond_to do |format|
      format.html { redirect_to cage_entrances_url(@cage) }
      format.json { head :no_content }
    end
  end
end
