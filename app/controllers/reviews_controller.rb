class ReviewsController < ApplicationController

  def index

    # this is our list page for our reviews
    @reviews = Review.all

  end

  def new

    # the form for adding a new review
    @review = Review.new

  end

  def create

    # take the info from the form (and add it to the model)
    @review = Review.new(form_params)

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

    # destroy
    @review.destroy

    # redirect to home page
    redirect_to root_path

  end

  def edit

    #find the individual review (to edit)
    @review = Review.find(params[:id])

  end

  def update

    # find the individual review
    @review = Review.find(params[:id])

    # update with the new info from the form
    if @review.update(form_params)

      # redirect somewhere
      redirect_to review_path(@review)

    else

      render "edit"

    end

  end

  def form_params

    params.require(:review).permit(:title, :restaurant, :body, :score, :ambiance)

  end

end
