ActiveAdmin.register ClientProfile do
  permit_params :first_name, :last_name, :phone_number, :user_id
end
