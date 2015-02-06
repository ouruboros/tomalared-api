class TagController < ApplicationController
  helper :post
  
  def follow
    @tag = Tag.find(params[:id])
    # Subscriptions.subscribe(current_user[:id], Subscriptions::S_TAG, @tag.id)
    if @tag.users << User.find(current_user[:id])
    
      # foto aleatoria de la cabezera de list por tags
      #    @tag_foto = Post.find(:all, :joins => 'JOIN posts_tags pt ON pt.post_id = posts.id',
      # :conditions => ['pt.tag_id = tags.id AND tags.id = ? AND posts.post_type = ?', @tag, "image"],
      # :order => 'rand()',
      # :limit => 1,
      # :include => [:tags, :user])
      
      # @tag_foto.each do |tag_foto|
      #   @foto_tag = tag_foto.content
      # end
      @users_tag =  Tag.find(@tag).users
      render :json => {:success => true }
    else
      render :json => {:success => false }
    end
  end

  def unfollow
    @tag = Tag.find(params[:id])
    current_user.tags.delete(@tag)
    # foto aleatoria de la cabezera de list por tags
    # @tag_foto = Post.find(:all, :joins => 'JOIN posts_tags pt ON pt.post_id = posts.id',
    #                       :conditions => ['pt.tag_id = tags.id AND tags.id = ? AND posts.post_type = ?', @tag, "image"],
    #                       :order => 'rand()',
    #                       :limit => 1,
    #                       :include => [:tags, :user])

    # @tag_foto.each do |tag_foto|
    #   @foto_tag = tag_foto.content
    # end
    @users_tag =  Tag.find_by_sql(['SELECT u.*, tu.tag_id FROM tags_users as tu, users as u WHERE u.id = tu.user_id and tu.tag_id = ?', @tag])
    render :json => {:success => true }

  end
  
  def list
    if params[:id]
      @tags = Tag.where(:id => params[:id]).first
    elsif params[:user_name]
      @tags = tags[:user_id]
      @tags = User.where(:id => params[:user_id]).first.tags
    else
      @tags = Tag.all
    end
    render :json => @tags
  end

  def delete
    tag = Tag.find(params[:id])
    tag.destroy
    render :json => {:success => true}
  end
end
