ActiveAdmin.register Review do
    permit_params :rating, :comment
end