ActionController::Routing::Routes.draw do |map|
  # Only using resource to generate show and edit paths
  map.resources :projects, :except => [:show, :edit]

  # Root URL will hit the index action by default
  map.root :controller => 'projects'
  
  # URL for the post-recieve hook
  map.connect '/build.:format', :controller => 'projects', :action => 'build', :conditions => { :method => :post }   

  # Avoid resource generated routes for some pretty-urls
  map.connect '/:project', :controller => 'projects', :action => 'show'
  map.connect '/:project/edit', :controller => 'projects', :action => 'edit'
  map.connect '/:project/builds/:id', :controller => 'builds', :action => 'show'
end
