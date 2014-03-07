class TicketsController < ApplicationController 
  before_action :authenticate_user!, except: [:index]
  def index
    @tickets = Ticket.all
  end

  def new
    @ticket=Ticket.new
  end

  def create
    @ticket=current_user.tickets.new ticket_params
    if @ticket.resolved?
      @ticket.resolver=current_user
    end
    if @ticket.save
      redirect_to tickets_path, notice: "You did it man, I don't know how, but YOU DID IT"
    else
      flash[:alert] = "Keep your spirits high and try again"
      render :new
    end
  end

  def update
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      if @ticket.update_attributes(update_params)
        if @ticket.resolved?
          @ticket.resolver=current_user
        else
          @ticket.resolver=nil
        end
        @ticket.save
        format.html {redirect_to tickets_path, notice: "resolved"}
        format.js {render}
      else
        redirect_to tickets_path, alert: "You are trying to do something I dont like"
      end
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title,:body,:resolved)
  end

  def update_params
    params.require(:ticket).permit(:resolved)
  end
end

