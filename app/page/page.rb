# -*- coding: utf-8 -*-
class Page
  include Operation
  
  attr_reader :browser
  
  def initialize(browser, excel_sheet)
    @browser    = browser
    @definition = excel_sheet
  end
end