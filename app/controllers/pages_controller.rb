class PagesController < ApplicationController
  def home
    @leads = Lead.all
    # @notes = @leads.notes.all
    @contacts = Contact.all
  end
end
