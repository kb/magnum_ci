class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    respond_to do |format|
      format.html
      format.xml { render :xml => @projects }
    end
  end
  
  def show
    @project = Project.find_by_name(params[:project])
    respond_to do |format|
      format.html
      format.xml { render :xml => @project }
    end
  end
  
  def new
    @project = Project.new
    respond_to do |format|
      format.html
      format.xml { render :xml => @project }
    end
  end
  
  def create
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to("/#{@project.name}") }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @project = Project.find_by_name(params[:project])
    respond_to do |format|
      format.html
      format.xml { render :xml => @project }
    end
  end
  
  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to("/#{@project.name}") }
        format.xml  { render :xml => @project, :status => :updated, :location => @project }
      else
        format.html { render :action => "edit"}
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to(projects_path)
  end
  
  def build
    Project.find_by_name(params[:project]).run_build
    render :nothing => true
  end
end
