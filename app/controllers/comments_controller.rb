class CommentsController < ApplicationController    
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to @commentable
    else
      render :action => 'new'
    end
  end
  
  private

    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end