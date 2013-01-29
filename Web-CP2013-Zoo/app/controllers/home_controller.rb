class HomeController < ApplicationController
  def index
    @cages = Cage.all
    @mode = params[:mode]

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
