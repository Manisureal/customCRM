class LeadsController < ApplicationController
  def index
    # @leads = Lead.all
    @leads = if params[:lead]
      sql_query = "name ILIKE :lead OR status ILIKE :lead"
      # Lead.where('name LIKE ?', "%#{params[:lead]}%").page(params[:page]).per(9)
      Lead.where(sql_query, lead: "%#{params[:lead]}%").page(params[:page]).per(9)
    else
      Lead.order(:id).page(params[:page]).per(9)
    end
    @status = ["New","Contacted","Converted","Rejected"]
  end

  def show
    @lead = Lead.find(params[:id])
    @lead.viewed = true
    @lead.save
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

  def edit
    @lead = Lead.find(params[:id])
  end

  def update
    @lead = Lead.find(params[:id])
    @lead.update(lead_params)
    if @lead.status == "Closed - Converted" || @lead.status == "Working - Contacted"
      @contact = Contact.new(name: @lead.name, company: @lead.company, email: @lead.email, phone: @lead.phone, lead_id: @lead.id)
      @contact.errors.messages
      if @contact.save
        redirect_to request.referrer
        flash[:notice] = "Lead# #{@lead.id} was converted into a contact"
      end
      # @lead.update(status_update)
    else
      redirect_to request.referrer
      flash[:notice] = "Lead# #{@lead.id} was successfully updated"
    end
  end

  def destroy
    @lead = Lead.find(params[:id])
    if @lead.destroy
      redirect_to leads_path
      flash[:notice] = "Lead##{@lead.id} successfully deleted!"
    end
  end

  def search_lead
    @new_lead = Lead.new
    @new_lead.name = @new_lead.parsed_mail[0]
    @new_lead.email = @new_lead.parsed_mail[1]
    @new_lead.message = @new_lead.parsed_mail[2]
    if @new_lead.save #@new_lead.new_record?
      redirect_to leads_path
      flash[:notice] = "Lead# #{@new_lead.id} was successfully retrieved"
    else
      redirect_to leads_path
      flash[:alert] = "No new lead currently"
    end
  end

  def convert_lead
    @lead = Lead.find(params[:id])
    @lead.status = "Converted"
    @lead.save
    @contact = Contact.new(name: @lead.name, company: @lead.company, email: @lead.email, phone: @lead.phone, lead_id: @lead.id)
    if @contact.save
      redirect_to leads_path
      flash[:notice] = "Lead was successfully converted"
    end
  end

  def please_wait
  end

  private
  def lead_params
    params.require(:lead).permit(:name, :company, :email, :phone, :message, :status, :lead, notes_attributes: [:content])
  end

  def status_update
    params.require(:lead).permit(:status)
  end
end
