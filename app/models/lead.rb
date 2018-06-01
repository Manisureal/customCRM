class Lead < ApplicationRecord
  has_many :notes
  accepts_nested_attributes_for :notes#, allow_destroy: true
  validates :email, uniqueness: true
  require 'gmail'

  def parsed_mail
    gmail = Gmail.connect(ENV["GOOGLE_CLIENT_ID"],ENV["GOOGLE_CLIENT_SECRET"])
    gmail_mail = gmail.inbox.emails(:from => "manisureal@gmail.com").last
    arr = gmail_mail.body.raw_source.split("\r\n")
    6.times do arr.shift end
    31.times do arr.pop end
    arr.delete("<p>")
    arr.delete("</p>")
    # arr
    new_arr = []
    arr.each do |a|
      split = a.split
      split.delete_at(0)
      new_arr << split.join(' ')
    end
    new_arr
    # @lead = Lead.new(name: arr[0], email: arr[1], message: arr[2])
    # @lead.save
  end

  private
  # def parse_gmail
  #   gmail = Gmail.connect("mansoor@caremeds.co.uk","Purple874")
  #   gmail_mail = gmail.inbox.emails(:from => "manisureal@gmail.com").last
  #   arr = gmail_mail.body.raw_source.split("\r\n")
  #   6.times do arr.shift end
  #   31.times do arr.pop end
  #   arr.delete("<p>")
  #   arr.delete("</p>")
  #   arr
  #   Lead.new(name: arr[0], email: arr[1], message: arr[2])
  # end
end
