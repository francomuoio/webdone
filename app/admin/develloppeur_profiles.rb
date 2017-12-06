ActiveAdmin.register DevelloppeurProfile do
  permit_params :user_id, :github_uid, :github_username, :github_token
end
