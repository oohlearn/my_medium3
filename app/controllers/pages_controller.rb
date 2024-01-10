class PagesController < ApplicationController
    before_action :find_story, only: [:show]
    def index
        @stories = Story.published_stories
    end

    def show
        @user = User.find_by(username: params[:username])
      end
    

    def user 
    end

    private
    def find_story
        @story = Story.friendly.find(params[:story_id])
    end
end
