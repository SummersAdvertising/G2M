#encoding: utf-8
class RecordsController < ApplicationController
  layout nil
  def index
    @records = Record.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @records }
    end
  end

  def show
    @record = Record.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record }
    end
  end

  def new
    @record = Record.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @record }
    end
  end

  def edit
    @record = Record.find(params[:id])

    unless(session[:record_id] && ( params[:id] == session[:record_id].to_s ) && @record)
      redirect_to root_path, alert: "記錄不存在"
    end
  end

  def create
    @record = Record.new(params[:record])

    respond_to do |format|
      if @record.save
        session[:record_id] = @record.id

        format.html { redirect_to edit_record_path(@record) }
        format.json { render json: @record, status: :created, location: @record }
      else
        format.html { render action: "new" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.html { redirect_to records_url }
      format.json { head :no_content }
    end
  end
end
