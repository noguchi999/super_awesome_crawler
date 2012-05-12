require 'active_support/core_ext'
module Selector
  
  def selectors
    Base.selectors
  end

  class Base
  
    class << self
      cattr_accessor :selectors
      
      def behavior(proc)
        self.selectors ||= {}
        selectors.store(self.name.split("::").pop.underscore.to_sym, proc)
      end
    end
  end
end

Dir.glob("#{File.expand_path('..', __FILE__)}/plugins/*.rb") do |f|
  next if File.basename(f) == File.basename(__FILE__)
  
  require f
end