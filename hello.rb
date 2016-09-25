# -*- coding: utf-8 -*-
require 'sinatra'
require 'rakuten_web_service'
require 'net/http'

#参考: https://github.com/k2works/sinatra_rakuten_api

get '/' do
  RakutenWebService.configure do |c|
    c.application_id = ENV["APPID"]
    c.affiliate_id = ENV["AFID"]
  end

  # Use genre id to fetch genre object
  @rankings = RakutenWebService::Ichiba::Item.ranking(:age => 40, :sex => 0)
  erb :item_ranking
end
