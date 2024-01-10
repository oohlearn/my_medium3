class StoriesController < ApplicationController

    before_action :authenticate_user!
    before_action :find_story, only:[:edit, :update, :destroy]
        # 在這個controllser，只要進行action前沒有登入，就把沒有登入的使用者踢回登入畫面
        # 也可限定單個action   後面加上only: [:new]  或是濾掉except


        
    def index
        @stories = current_user.stories.order(created_at: :desc)
        # 按照建立時間降階排序
    end
    
    def new     
        # @story = Story.new 可以改寫成下面那行，只要在user.rb加上 has_many :stories
        @story = current_user.stories.new
        
    end

    def create
        @story = current_user.stories.new(story_params)
        # 按下發布文章的按鈕之後，會多個參數publish出現，然後就將status設為publish
        @story.publish! if params[:publish]

        if @story.save
            if params[:publish]
                redirect_to stories_path, notice: "已成功發布"
            else
                redirect_to edit_story_path(@story), notice: "已儲存"
            end
            # 如果有:publish這個參數，就回到故事列表，沒有的話就回到(停在)該故事的edit畫面
        else
            render :new
            #重新渲染new的畫面
            #  puts @story.errors.full_messages # 將錯誤訊息輸出到控制台
        end
    end

    def edit
    end


    def update
        if @story.update(story_params)
            case
            when params[:publish]
                @story.publish!
                redirect_to stories_path, notice: "故事已發佈"
            when params[:unpublish]
                @story.unpublish!
                redirect_to stories_path, notice: "故事已下架"
            else
                redirect_to edit_story_path(@story), notice: "故事已儲存"
            end
        else
            render :edit
        end
    end

    def destroy
        @story.destroy
        redirect_to stories_path, notice: "故事已刪除"
    end


    # 針對送過來的資料進行清洗，只允許給過的東西進資料庫
    private
    def story_params
        params.require(:story).permit(:title, :content, :cover_image)
    end

    def find_story
        @story = current_user.stories.friendly.find(params[:id])
    end



end
