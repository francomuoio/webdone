ActiveAdmin.register User do
  permit_params :email, :role, :admin
end
