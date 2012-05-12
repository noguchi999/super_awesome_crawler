# -*- coding: utf-8 -*-
class Analyzer
  COMMANDS = %w{text_fields links buttons images select_lists radios checkboxes file_fields}
  
  def initialize(page)
    @url = page.browser.url
    @elements = []
    @pairs = []
    
    COMMANDS.each do |command|
      page.browser.__send__(command).each_with_index do |element, index|
        element.instance_eval do
          def method_missing(method, *args)
            case method.to_s
              when "id", "name", "type", "text"
                ""
              else
                super
            end
          end
        end
        @elements << "Id:#{element.id}, Name:#{element.name}, Type:#{element.type}, Text:#{element.text}, Index:#{index}"
        if !element.id.blank?
          @pairs << "#{element.id}:#{element.type}"
        elsif !element.name.blank?
          @pairs << "#{element.name}:#{element.type}"
        else
          @pairs << "index:#{element.type}"
        end
      end
    end
  end
  
  def elements(opts={})
    options = {exclude: []}.merge(opts)
    options[:exclude].each do |keyword|
      @elements.reject!{|v| v[/#{keyword}/]}
    end
    @elements
  end
  
  def show(opts={})
    puts @url
    puts elements(opts).join("\n")
  end
  
  def pairs
    puts @url
    puts @pairs.join("\t")
  end
end