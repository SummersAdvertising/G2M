# encoding: utf-8
class TicketsController < ApplicationController
  # GET /tickets/new
  # GET /tickets/new.json
  def new
    @ticket = Ticket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end
  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(params[:ticket])
        
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to new_ticket_path, notice: '感謝您參與本次活動，我們將於 10 個工作日回覆您！' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end
  
end