module Selector
  class SelectOne < Base
    behavior -> opts {
                      <<-EOS
                        def advanced_select_list
                          if select_list(:name, "#{opts[:name]}").include?("#{opts[:value]}")
                            select_list(:name, "#{opts[:name]}").select("#{opts[:value]}")
                          else
                            select_list(:name, "#{opts[:name]}").select(/#{opts[:value]}/)
                          end
                        end
                        advanced_select_list
                      EOS
                     }
  end
end