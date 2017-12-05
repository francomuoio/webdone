class CreateDevelloppeurProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :develloppeur_profiles do |t|
      t.string :github_username
      t.string :github_token
      t.string :github_token_expiry
      t.string :github_uid
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
