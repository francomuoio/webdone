class CreateProjets < ActiveRecord::Migration[5.1]
  def change
    create_table :projets do |t|
      t.string :title
      t.string :content
      t.string :repository_url
      t.references :develloppeur_profile, foreign_key: true
      t.references :client_profile, foreign_key: true

      t.timestamps
    end
  end
end
