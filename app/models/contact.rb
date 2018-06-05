class Contact < ApplicationRecord
  belongs_to :lead, optional: true
end
