class BuildsController < ApplicationController
  before_filter :load_project
  
  def show
    @build = @project.builds.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @build }
    end
  end
  
  # This will be the action the git post-receive hook will hit
  def new
    @project.run_build
    respond_to do |format|
      format.html { render :nothing => true }
      format.xml { render :nothing => true }
    end
  end
  
protected
  def load_project
    @project = Project.find_by_name(params[:project])
  end
end
