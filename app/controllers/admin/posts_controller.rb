class Admin::PostsController < ApplicationController
    def index
        @posts = Post.all
    end
    
    def show
        @post = Post.find(params[:id])
        @member = @post.member
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        @post.update(post_params)
        redirect_to admin_posts_path
    end
    
    private
    
    def post_params
        params.require(:post).permit(:title, :body, :image, :genre_id, :post_status)
    end
end
