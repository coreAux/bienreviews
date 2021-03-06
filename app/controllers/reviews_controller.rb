class ReviewsController < ApplicationController

  # check if logged in
  before_action :check_login, except: [:index, :show]

  # this is our list page for our reviews
  def index

    @price = params[:price]
    @cuisine = params[:cuisine]
    @location = params[:location]

    # start with all ReviewsController@
    @reviews = Review.all

    # filtering by price
    if @price.present?
      @reviews = @reviews.where(price: @price)
    end

    # filtering by cuisine
    if @cuisine.present?
      @reviews = @reviews.where(cuisine: @cuisine)
    end

    # search near the location
    if @location.present?
      @reviews = @reviews.near(@location)
    end

  end

  def new

    # the form for adding a new review
    @review = Review.new

  end

  def create

    # take the info from the form (and add it to the model)
    @review = Review.new(form_params)

    # and then associate it with the user
    @review.user = @current_user

    # check if model can be saved
    if @review.save

      # if it is saveable we go to the home page
      redirect_to root_path

    else

      # if not saveable show the new review form
      # show the view for new.html.erb
      render "new"

    end

  end

  def show

    # individual review page
    @review = Review.find(params[:id])

  end

  def destroy

    # find the individual review
    @review = Review.find(params[:id])

    # destroy if they have access
    if @review.user == @current_user
      @review.destroy
    end

    # redirect to home page
    redirect_to root_path

  end

  def edit

    #find the individual review (to edit)
    @review = Review.find(params[:id])

    if @review.user != @current_user
      redirect_to root_path
    elsif @review.created_at < 1.hour.ago
      redirect_to review_path
    end

  end

  def update

    # find the individual review
    @review = Review.find(params[:id])

    if @review.user != @current_user
      redirect_to root_path
    else
      # update with the new info from the form
      if @review.update(form_params)
        # redirect somewhere
        redirect_to review_path(@review)
      else
        render "edit"
      end
    end

  end

  def form_params

    params.require(:review).permit(:title, :restaurant, :address, :photo, :body, :score, :ambiance, :cuisine, :price)

  end

end
