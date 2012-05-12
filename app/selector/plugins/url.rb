module Selector
  class Url < Base
    behavior -> opts {%Q|goto("#{opts[:value]}")|}
  end
end