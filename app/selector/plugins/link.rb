module Selector
  class Link < Base
    behavior -> opts {%Q|link(:#{opts[:name]}, "#{opts[:value]}").click|}
  end
end