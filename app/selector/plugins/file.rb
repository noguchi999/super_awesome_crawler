module Selector
  class File < Base
    #Watirのバージョンによっては、動かないかも。その場合は、popup_worker.rbの利用を検討すること。
    behavior -> opts {%Q|file_field(:name, "#{opts[:name]}").set("#{opts[:value]}")|}
  end
end