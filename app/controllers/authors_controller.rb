class AuthorsController < ApplicationController

  #handling invalid records
  # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def show
    author = Author.find(params[:id])

    render json: author
  end

  # post
  # create! : will activate exception if data is invalid, which will then be handled by the rescue_from ActiveRecord::InvalidReccord
  def create
    author = Author.create(author_params)

    #using valid? to render correct response based on data validity
    if author.valid?
      render json: author, status: :created
    else
      render json: {errors: author.errors}, status: :unprocessable_entity
    end

  end

  private
  
  def author_params
    params.permit(:email, :name)
  end

  # def render_unprocessable_entity_response(invalid)
  #   render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  # end
  
end
