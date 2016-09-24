# -*- coding: utf-8 -*-
require 'sinatra'
require 'rakuten_web_service'

#参考: https://github.com/k2works/sinatra_rakuten_api

get '/' do
  @title = '楽天API利用テスト'
  erb :top
end

get '/age/:age/sex/:sex' do
  RakutenWebService.configuration do |c|
    c.application_id = ENV["APPID"]
    c.affiliate_id = ENV["AFID"]
  end

  age = "#{params['age']}"
  sex = "#{params['sex']}"
  if sex.to_i == 0
    sex_title = '男性'
  else
    sex = 1
    sex_title = '女性'
  end

  # Use genre id to fetch genre object
  @title = age + '代' + sex_title + 'のランキング TOP30'
  @rankings = RakutenWebService::Ichiba::Item.ranking(:age => age, :sex => sex)
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
