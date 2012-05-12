module Selector
  class Text < Base
    behavior -> opts {%Q|text_field(:name, "#{opts[:name]}").set("#{opts[:value]}")|}
  end
end