class FeedbacksController < ApplicationController

  theme :theme_resolver, only: [:show]

  def show
    render
  end

end
