# -*- coding: utf-8 -*-
class CommentController < ApplicationController
  def new
    @comment = Comment.create!(:body => params[:body], :post_id => params[:post_id], :user_id => params[:user_id])
    
    if @comment
      require 'htmlentities'
      coder = HTMLEntities.new
      string = @comment.body
      @comment.body = coder.encode(string, :basic)
      
      # Agregar tags
      t11 = Array.new
      @comment.body.split.each do |t|
        if t.first == '#'
          t = t.gsub(/^#/,"")
          t = t.gsub(/[áäà]/i, "a")
          t = t.gsub(/[éëè]/i, "e")
          t = t.gsub(/[íïì]/i, "i")
          t = t.gsub(/[óöò]/i, "o")
          t = t.gsub(/[úüù]/i, "u")
          t = t.gsub(/[^a-zA-Z0-9ñÑçÇ\']/i, "")
          t11 << t
        end
      end
      
      t11.each do |t|
        tag = Tag.find_by_name(t) || Tag.new(:name => t)
        @comment.post.tags << tag
      end
    end
    if @comment.save
      render :json  => {:message => 'El comentario se ha guardado correctamente.'}
    else
      render :json => {:message => 'Hubo un problema al guardar el mensaje.'}
    end
  end
  
  def list
    @post = Post.where(:id => params[:id]).first
    render :json => @post.comments
  end

end
