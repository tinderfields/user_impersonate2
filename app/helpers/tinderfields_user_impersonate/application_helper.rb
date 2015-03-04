module TinderfieldsUserImpersonate
  module ApplicationHelper
    def current_staff_user
      return unless session[:staff_user_id]
      staff_finder_method = config_value(TinderfieldsUserImpersonate::Engine.config, :staff_finder, 'find').to_sym
      staff_class_name = config_value(TinderfieldsUserImpersonate::Engine.config, :staff_class, 'User')
      staff_class = staff_class_name.constantize
      @staff_user ||= staff_class.send(staff_finder_method, session[:staff_user_id])
    end

    private

    def config_value(config, sym, default)
      config.respond_to?(sym) ? (config.send(sym) || default) : default
    end
  end
end
