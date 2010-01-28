class BuildsController < ApplicationController
  before_filter :load_project
  
  def show
    @build = @project.builds.find(params[:id])
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
