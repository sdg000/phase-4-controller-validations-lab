class PostsController < ApplicationController

  #handling invalid records
  # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


  def show
    post = Post.find(params[:id])
    
    render json: post
  end

  def update
    post = find_post
    post.update(post_params)

    #using valid? to render correct response based on data validity
    if post.valid?
      render json: post
    else 
      render json: {errors: post.errors}, status: :unprocessable_entity\
    end

  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  def find_post
    Post.find(params[:id])
  end

  # def render_unprocessable_entity_response(invalid)
  #   render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  # end


end
