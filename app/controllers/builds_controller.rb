class BuildsController < ApplicationController
  before_filter :load_project
  
  def show
    @build = @project.builds.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @build }
    end
  end
  
  def new
    # I know... @project.builds.build is odd... I couldn't think of a better name for the model. Suggestions?
    @build = @project.builds.build
    respond_to do |format|
      format.html
      format.xml { render :xml => @build }
    end
  end
  
protected
  def load_project
    @project = Project.find_by_name(params[:project])
  end
end
