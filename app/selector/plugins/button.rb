module Selector
  class Button < Base
    behavior -> opts {%Q|button(:#{opts[:name]}, "#{opts[:value]}").click|}
  end
end