class Addpostusername < ActiveRecord::Migration
  def change 
#    add_column :posts, :user_name, :string
    remove_column :posts, :post_type
  end
end
