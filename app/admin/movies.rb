ActiveAdmin.register Movie do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #permit_params :title, :description, :category, :rating, :user_id, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :category, :rating, :user_id, :image]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params do
    params = [:title, :description, :category, :rating, :user_id, :image, :published_at]
  end  

  form do |f|
    f.inputs do
      f.input :user_id, :label =>"Admin", :as => :select, :collection => User.where(:admin => true ).map { |u| [u.email, u.id] }, :prompt => "Select Admin"
      f.input :title, label: 'Title (128 characters maximum)'
      f.input :description, label: 'Description (300 characters maximum)'
      f.input :category
      f.input :image, as: :file, label: 'Add illustrations to the movie'
    end
    f.actions
  end
  show do
    attributes_table do
      row :title
      row :image do |ad|
        image_tag url_for(ad.image), size: "200x300"
      end
    end
  end
  
  controller do
    def find_resource
      begin
        scoped_collection.where(slug: params[:id]).first!
      rescue ActiveRecord::RecordNotFound
        scoped_collection.find(params[:id])
      end
    end
  end
end
