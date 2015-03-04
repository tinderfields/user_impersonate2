Rails.application.routes.draw do

  devise_for :users

  root :to => "home#index"

  mount TinderfieldsUserImpersonate::Engine => "/impersonate", as: "impersonate_engine"
end
