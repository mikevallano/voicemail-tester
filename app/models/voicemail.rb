class Voicemail < ActiveRecord::Base
  belongs_to :street

  scope :by_street, lambda { |street| where(:street_id => street.id) }
end
