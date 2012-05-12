# coding: utf-8
require 'rspec'
require File.expand_path("app/selector/base")

describe Selector, "instance when it " do
  include Selector
  
  it "button should return button click string for instance_eval. " do
    opts = {name: "hoge", value: "piyo"}
    selectors[:button].call(opts).should eql %Q|button(:#{opts[:name]}, "#{opts[:value]}").click|
  end
  
  it "file should return file set string for instance_eval. " do
    opts = {name: "hoge", value: "piyo"}
    selectors[:file].call(opts).should eql %Q|file_field(:name, "#{opts[:name]}").set("#{opts[:value]}")|
  end
  
  it "link should return link click string for instance_eval. " do
    opts = {name: "hoge", value: "piyo"}
    selectors[:link].call(opts).should eql %Q|link(:#{opts[:name]}, "#{opts[:value]}").click|
  end
  
  it "radio should return radio set string for instance_eval. " do
    opts = {name: "hoge", value: "piyo"}
    selectors[:radio].call(opts).should eql %Q|radio(:id, "#{opts[:name]}").set|
  end
  
  it "select_one should return do advanced_select_list string for instance_eval. " do
    opts = {name: "hoge", value: "piyo"}
    expected_result = <<-EOS
                        def advanced_select_list
                          if select_list(:name, "#{opts[:name]}").include?("#{opts[:value]}")
                            select_list(:name, "#{opts[:name]}").select("#{opts[:value]}")
                          else
                            select_list(:name, "#{opts[:name]}").select(/#{opts[:value]}/)
                          end
                        end
                        advanced_select_list
                      EOS
    
    selectors[:select_one].call(opts).should eql expected_result
  end
  
  it "text should return text set string for instance_eval. " do
    opts = {name: "hoge", value: "piyo"}
    selectors[:text].call(opts).should eql %Q|text_field(:name, "#{opts[:name]}").set("#{opts[:value]}")|
  end
  
  it "url should return url goto string for instance_eval. " do
    opts = {name: "hoge", value: 'http://ec2-46-51-232-200.ap-northeast-1.compute.amazonaws.com/2013/madorin/'}
    selectors[:url].call(opts).should eql %Q|goto("#{opts[:value]}")|
  end
end