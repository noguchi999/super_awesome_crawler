#-*- coding: utf-8 -*-
require 'active_support/core_ext'
module Operation 
  include Selector
  
  BEGINNING = {row: 3, column: 1, header: 2}
  
  def execute
    build_operations.each do |step|
      @browser.instance_eval step
    end
  end
  
  def analyze
    execute
    
    Analyzer.new(self)
  end
  
  private
    def build_operations
      steps = []
      (BEGINNING[:row]..@definition.row_count).each do |row_pos|
        (BEGINNING[:column]..@definition.column_count).each do |col_pos|
          break if @definition.cell(BEGINNING[:header], col_pos).empty?
          next  if @definition.cell(row_pos, col_pos).empty?
          
          header = @definition.cell(BEGINNING[:header], col_pos).to_s
          unless header.split(':').size == 2
            raise "Illegal format error: #{header}"
          end
          
          name  = header.split(':')[0]
          type  = header.split(':')[1].underscore.to_sym
          value = @definition.cell(row_pos, col_pos)
          
          steps << selectors[type].call(name: name, value: value)
        end
      end
      steps
    end
end