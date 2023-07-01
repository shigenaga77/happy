class Admin::PostsController < ApplicationController
    before_action :authenticate_admin!

    def index
        @posts = Post.page(params[:page]).order(created_at: :desc).per(10)
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

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to admin_posts_path
    end

    private

    def post_params
        params.require(:post).permit(:title, :body, :image, :genre_id, :post_status)
    end
end
