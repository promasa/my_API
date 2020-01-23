class PostsController < ApplicationController
  before_action :authorize!
  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    post.save
    serializer = PostSerializer.new(post)
    render json: serializer.as_json
  end

  def update
    @post = Post.where(id: params[:id]).first
    @post.update!(post_params)
    serializer = PostSerializer.new(@post)
    render json: serializer.as_json
  end

  def index
    query = Post.all
    query = query.page(params[:page]).per(params[:limit]).order(updated_at: :desc)
    if params[:query].present?
      query =query.where("text Like?" ,"%#{params[:query]}%")
    end
    serializer = ActiveModel::Serializer::CollectionSerializer.new(query,serializer:PostSerializer)
    render json: serializer.as_json
  end

  def destroy
    @post = Post.where(id: params[:id]).first
    @post.destroy!
    render json: {'message': '正常にUser削除されました'}
  end

  def post_params
    params.require(:post_params).permit(
      :text
    )
  end
  
  # def check_auth_update
  #   @user_user = Post.where(id: params[id]).first
  #   unless 
  # end

end
