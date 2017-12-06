ActiveAdmin.register Projet do
  permit_params :develloppeur_profile_id, :client_profile_id, :title, :content, :repository_url
end
