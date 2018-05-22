class LeadsController < ApplicationController
  def index
    @leads = Lead.all
  end

  def search_lead
    @new_lead = Lead.new
    @new_lead.name = @new_lead.parsed_mail[0]
    @new_lead.email = @new_lead.parsed_mail[1]
    @new_lead.message = @new_lead.parsed_mail[2]
    @new_lead.save if @new_lead.new_record?
    redirect_to leads_path
  end

  def new
    @new_lead = Lead.new
  end

  def create
    @new_lead = Lead.new(lead_params)
    if @new_lead.save
      redirect_to leads_path
      flash[:notice] = "Lead successfully created!"
    else
      render :new
    end
  end

  private
  def lead_params
    params.require(:lead).permit(:name, :company, :email, :phone, :message, :status)
  end

end
