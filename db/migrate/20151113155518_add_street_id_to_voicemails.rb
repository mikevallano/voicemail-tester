class AddStreetIdToVoicemails < ActiveRecord::Migration
  def change
    add_reference :voicemails, :street, index: true, foreign_key: true
  end
end
