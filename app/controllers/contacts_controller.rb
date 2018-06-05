class ContactsController < ApplicationController

  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @new_contact = Contact.new
  end

  def create
    @new_contact = Contact.new(contact_params)
    if @new_contact.save
      redirect_to contacts_path
      flash[:notice] = "Contact successfully created"
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :company, :email, :phone, :address, :city, :postcode)
  end

end
