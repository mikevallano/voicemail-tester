class Voicemail < ActiveRecord::Base
  belongs_to :street

  scope :by_street, lambda { |user| where(:street_id => street.id) }
end
