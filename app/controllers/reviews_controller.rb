class ReviewsController < ApplicationController

  def index

    # this is our list page for our reviews

    @number = rand(101)

    @reviews = ["The Smile", "Baby Bo's", "Chipotle", "Albion", "McDonalds"]

  end

end
