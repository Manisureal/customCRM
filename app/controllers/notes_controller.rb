class NotesController < ApplicationController
  def index
  end

  def new
    @lead = Lead.find(params[:lead_id])
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.lead = Lead.find(params[:lead_id])
    # @lead = Lead.find(params[:lead_id])
    # @note = @lead.notes.new(note_params)
    @note.save
  end

  private
  def note_params
    params.require(:note).permit(:content)
  end
end
