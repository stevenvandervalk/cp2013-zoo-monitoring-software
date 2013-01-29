class ZooSetupUiController < ApplicationController
  def index
    @cages = Cage.all
    @employees = Employee.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
