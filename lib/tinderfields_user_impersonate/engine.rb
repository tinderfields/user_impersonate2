module TinderfieldsUserImpersonate
  class Engine < ::Rails::Engine
    isolate_namespace TinderfieldsUserImpersonate
    
    initializer "tinderfields_user_impersonate.devise_helpers" do
      if Object.const_defined?("Devise")
        require "tinderfields_user_impersonate/devise_helpers"
        Devise.include_helpers(TinderfieldsUserImpersonate::DeviseHelpers)
      end
    end

    config.to_prepare do
      ::ApplicationController.helper(TinderfieldsUserImpersonate::ApplicationHelper)
      ::ApplicationController.send(:include, TinderfieldsUserImpersonate::ApplicationHelper)
    end
  end
end
