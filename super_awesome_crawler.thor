# -*- coding: utf-8 -*-
require 'watir'
require 'yaml'
require File.expand_path('lib/excel_reader')
require File.expand_path('app/apps')

class SuperAwesomeCrawler < Thor
  COMMANS = {show: "show", pairs: "pairs"}
  
  desc "execute env", "config/excel_config.ymlで指定されたExcelを読み込んで、そこで指定されたページと要素に対して操作を行う."
  def execute(env)
    excel_config = YAML.load_file('config/excel_config.yml')[env]
    book         = ExcelReader::Book.new(file_path: excel_config[:file_path], range: excel_config[:range], sentinel: excel_config[:sentinel])
    route        = Route.new(book.sheet('Route'))
    
    open_browser
    
    route.names do |name|
      Page.new(@browser, book.sheet(name)).execute
    end
  end
  
  desc "analyze command env", "config/excel_config.ymlで指定されたExcelを読み込んで、そこで指定されたページの要素を出力する."
  def analyze(command, env)
    raise ArgumentError, "invalid augment #{command}. usage: #{COMMANS.keys} ." unless COMMANS[command.to_sym]
    
    excel_config = YAML.load_file('config/excel_config.yml')[env]
    book         = ExcelReader::Book.new(file_path: excel_config[:file_path], range: excel_config[:range], sentinel: excel_config[:sentinel])
    route        = Route.new(book.sheet('Route'))
    
    open_browser
    
    route.names do |name|
      Page.new(@browser, book.sheet(name)).analyze.__send__(command)
    end
  end
  
  private
    def open_browser
      if @browser.nil?
        Watir::Browser.default = "ie"
        @browser = Watir::Browser.new
      end
    end
end