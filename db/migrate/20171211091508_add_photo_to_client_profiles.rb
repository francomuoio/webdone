class AddPhotoToClientProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :client_profiles, :photo, :string
  end
end
