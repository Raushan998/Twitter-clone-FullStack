class TweetsController < ApplicationController
    include TweetsHelper
    before_action :authenticate_user!, except: [:home]
    before_action :set_tweet, only: [:edit, :update, :new_retweet, :create_retweet, :list_retweets, :new_comment, :create_comment]

    def home
        @tweets = Tweet.where(is_active: true).where(retweet_id: nil)
    end

    def new
        @tweet = Tweet.new
    end
    
    def new_retweet
       
    end

    def create
        @tweet = Tweet.new(tweet_params)
        unless params[:true].blank?
            @tweet.assign_attributes({user: current_user, is_active: true})
        else
            @tweet.assign_attributes({user: current_user, is_active: false})
        end
        unless @tweet.save
            flash[:notice] = @tweet.errors
        end
        redirect_to "/"
        # format.html {redirect_to list_retweets_tweet_path(@tweet.id), notice: "Tweet has been added successfully"}
    end
    
    def draft
        @tweet = current_user.tweets.where(is_active: false).where(retweet_id: nil)
    end

    def update
        # puts TweetsHelper.html_format(@tweet.username)
        unless params[:like].blank?
            if @tweet.user == current_user
                flash[:notice] = "You cannot like your own tweet"
            elsif @tweet.likes.include? current_user.id
                @tweet.likes.delete(current_user.id)
                @tweet.save
            else
                @tweet.likes.push(current_user.id)
                @tweet.save
            end
            redirect_to "/"
        else
            @tweet.update!(tweet_params)
            unless params[:true].blank?
                @tweet.assign_attributes({is_active: true})
            else
                @tweet.assign_attributes({is_active: false})
            end
            unless @tweet.save
                flash[:notice] = @tweet.errors
            end
            redirect_to draft_tweets_url
        end
    end

    def create_retweet
        @retweet = @tweet.retweets.new(title: params[:title])
        unless params[:true].blank?
            @retweet.assign_attributes({user: current_user, is_active: true})
        else
            @retweet.assign_attributes({user: current_user, is_active: false})
        end
        unless @retweet.save
            flash[:notice] = "Tweet cannot be saved!!!"
        end
        redirect_to "/"
    end
    
    def list_retweets
        @retweets = @tweet.retweets.where(is_active: true)
    end
    
    private

    def tweet_params
        params.require(:tweet).permit(:title, :avatar, :profile_video)
    end

    def set_tweet
        @tweet = Tweet.find(params[:id])
    end

    def comment_params
        params.permit(:title)
    end
end
