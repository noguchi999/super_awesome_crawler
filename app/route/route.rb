#-*- coding: utf-8 -*-
require 'forwardable'

class Route
  extend Forwardable
  
  BEGINNING = {row: 3, column: 1}
  
  def initialize(sheet)
    @routes = build_routes(sheet)
  end
  
  def_delegator :@routes, :each, :names
  
  private
    def build_routes(sheet)
      routes = []
      (BEGINNING[:row]..sheet.row_count).each do |row_pos|
        (BEGINNING[:column]..sheet.column_count).each do |col_pos|
          break if sheet.cell(row_pos, col_pos).empty?

          routes << sheet.cell(row_pos, col_pos)
        end 
      end
      routes
    end
end