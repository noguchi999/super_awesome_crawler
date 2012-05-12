module Selector
  class Radio < Base
    behavior -> opts {%Q|radio(:id, "#{opts[:name]}").set|}
  end
end