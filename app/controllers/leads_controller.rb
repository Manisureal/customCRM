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

end
