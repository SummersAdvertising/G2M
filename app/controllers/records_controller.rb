#encoding: utf-8
class RecordsController < ApplicationController
  # GET /records
  # GET /records.json
  def index
    @records = Record.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @records }
    end
  end

  # GET /records/1
  # GET /records/1.json
  def show
    @record = Record.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record }
    end
  end

  # GET /records/new
  # GET /records/new.json
  def new
    @record = Record.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @record }
    end
  end

  # GET /records/1/edit
  def edit
    @record = Record.find(params[:id])
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(params[:record])

    respond_to do |format|
      if @record.save
        format.html { redirect_to edit_record_path(@record), notice: 'Record was successfully created.' }
        format.json { render json: @record, status: :created, location: @record }
      else
        format.html { render action: "new" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /records/1
  # PUT /records/1.json
  def update
    @record = Record.find_by_id(params[:id])
    @signup = Signup.find_by_record_id(params[:id]) || Signup.create(:record_id => @record.id)

    params[:signup][:office_interested] = params[:signup][:office_interested].to_json
    params[:signup][:pc_interested] = params[:signup][:pc_interested].to_json
    params[:signup][:pc_os] = params[:signup][:pc_os].to_json
    params[:signup][:office_version] = params[:signup][:office_version].to_json

    respond_to do |format|
      if ( @record.user_fbid || @record.update_attributes(params[:record]) )
        @signup.update_attributes(params[:signup])

        format.html { redirect_to root_path, notice: '參加成功 XDDD。' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.html { redirect_to records_url }
      format.json { head :no_content }
    end
  end
end
