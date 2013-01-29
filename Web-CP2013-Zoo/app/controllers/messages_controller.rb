class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    @employee = Employee.find(params[:employee_id])
    @messages = @employee.messages

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])
    @employee = @message.employee

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @employee = Employee.find(params[:employee_id])

    @message = @employee.messages.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
    @employee = @message.employee
  end

  # POST /messages
  # POST /messages.json
  def create
    @employee = Employee.find(params[:employee_id])
    @message = @employee.messages.build(params[:message])

    respond_to do |format|
      if @message.save
        format.html { redirect_to employee_message_path(@employee, @message), notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: employee_message_path(@employee, @message) }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])
    @employee = @message.employee

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to employee_message_path(@employee, @message), notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @employee = @message.employee
    @message.destroy

    respond_to do |format|
      format.html { redirect_to employee_messages_url(@employee) }
      format.json { head :no_content }
    end
  end
end
