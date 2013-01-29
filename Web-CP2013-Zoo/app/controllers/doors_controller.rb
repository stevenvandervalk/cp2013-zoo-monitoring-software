class DoorsController < ApplicationController
  # GET /doors
  # GET /doors.json
  def index
    @entrance = Entrance.find(params[:entrance_id])
    @doors = @entrance.doors
    @cage = @entrance.cage

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @doors }
    end
  end

  # GET /doors/1
  # GET /doors/1.json
  def show
    @door = Door.find(params[:id])
    @entrance = @door.entrance
    @cage = @entrance.cage

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @door }
    end
  end

  # GET /doors/new
  # GET /doors/new.json
  def new
    @entrance = Entrance.find(params[:entrance_id])
    @door = @entrance.doors.build
    @cage = @entrance.cage

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @door }
    end
  end

  # GET /doors/1/edit
  def edit
    @door = Door.find(params[:id])
    @entrance = @door.entrance
    @cage = @entrance.cage
  end

  # POST /doors
  # POST /doors.json
  def create
    @entrance = Entrance.find(params[:entrance_id])
    @door = @entrance.doors.build(params[:door])
    @cage = @entrance.cage

    respond_to do |format|
      if @door.save
        format.html { redirect_to cage_entrance_door_path(@cage, @entrance, @door), notice: 'Door was successfully created.' }
        format.json { render json: @door, status: :created, location: cage_entrance_door_path(@cage, @entrance, @door) }
      else
        format.html { render action: "new" }
        format.json { render json: @door.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /doors/1
  # PUT /doors/1.json
  def update
    @door = Door.find(params[:id])
    @entrance = @door.entrance
    @cage = @entrance.cage

    respond_to do |format|
      if @door.update_attributes(params[:door])
        format.html { redirect_to cage_entrance_door_path(@cage, @entrance, @door), notice: 'Door was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @door.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doors/1
  # DELETE /doors/1.json
  def destroy
    @door = Door.find(params[:id])
    @entrance = @door.entrance
    @cage = @entrance.cage
    @door.destroy

    respond_to do |format|
      format.html { redirect_to cage_entrance_doors_url(@cage, @entrance) }
      format.json { head :no_content }
    end
  end
end
