class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tweet
    before_action :set_comment, only: [:update]
    def index
    end

    def new
        @comment = Comment.new
    end
    
    def create
        @comment = @tweet.comments.new(comment_params)
        unless params[:true].blank?
            @comment.assign_attributes({is_active: true, user: current_user})
        else
            @comment.assign_attributes({is_active: false, user: current_user})
        end
        unless @comment.save
            flash[:notice] = "Comment cannot be saved!!!"
            redirect_to new_tweet_comment_path
        end
        redirect_to "/"
    end

    def draft_comment
        @comments = current_user.comments.where("tweet_id=? and is_active=?", @tweet.id, false)
    end
    
    def list_comment
        @comments = @tweet.comments.where(is_active: true)
    end

    def update
        debugger
        @comment.update(comment_params)
        unless params[:true].blank?
            @comment.assign_attributes({is_active: true})
        else
            @comment.assign_attributes({is_active: false})
        end
        unless @comment.save
            flash[:notice] = "comment cannot be saved!!!"
            redirect_to draft_comment_tweet_comment_index_path
        end
        redirect_to "/"
    end

    private
    
    def comment_params
        params.require(:comment).permit(:title)
    end

    def set_tweet
        @tweet = Tweet.find(params[:tweet_id])
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end
end
