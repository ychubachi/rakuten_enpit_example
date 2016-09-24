# -*- coding: utf-8 -*-
require 'sinatra'
require 'rakuten_web_service'

#参考: https://github.com/k2works/sinatra_rakuten_api

get '/' do
  RakutenWebService.configuration do |c|
    c.application_id = ENV["APPID"]
    c.affiliate_id = ENV["AFID"]
  end

  # Use genre id to fetch genre object
  @title = '40代男性のランキング TOP30'
  @rankings = RakutenWebService::Ichiba::Item.ranking(:age => 40, :sex => 0)
  erb :item_ranking
end

# 洋菓子ランキング
get '/sweets' do
  RakutenWebService.configuration do |c|
    c.application_id = ENV["APPID"]
    c.affiliate_id = ENV["AFID"]
  end

  # Use genre id to fetch genre object
  @title = '洋菓子のランキング TOP30'
  @rankings = RakutenWebService::Ichiba::Item.ranking(:genreId => 100283)
  erb :sweets_ranking

end
