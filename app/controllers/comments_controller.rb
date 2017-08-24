class CommentsController<ApplicationController
before_action :get_parent
skip_before_action :get_parent, only: [:new]

  def new
    if params[:comment_id]
      @parent = Comment.find_by_id(params[:comment_id])
    elsif params[:comment][:commentable_type] == "Playlist"
      @parent = Playlist.find_by_id(params[:comment][:commentable_id])
    end
    @comment = @parent.comments.build
  end

  def create

    @comment = @parent.comments.new(comment_params)
    if @comment.save
      redirect_to playlist_path(@comment.playlist)
    else
      render :new
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:commentable_type, :user_id, :commentable_id, :body)
  end

  def get_parent
    if params[:comment][:commentable_type]== "Playlist"
    @parent = Playlist.find_by_id(params[:comment][:commentable_id])
  elsif params[:comment_id]
    @parent = Comment.find_by_id(params[:comment_id])
  elsif params[:comment][:commentable_type] == "Comment"
    @parent = Comment.find_by_id(params[:comment][:commentable_id])
  end
  end



end
