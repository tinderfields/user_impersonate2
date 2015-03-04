class TinderfieldsUserImpersonateGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  
  def engine_routes
    route 'mount TinderfieldsUserImpersonate::Engine => "/impersonate", as: "impersonate_engine"'
  end
  
  def configuration
    directory "config"
  end
  
  def views
    directory "app/views"
  end
end
