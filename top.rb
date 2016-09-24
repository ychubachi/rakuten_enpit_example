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

  sex = "#{params['sex']}"
  if sex.to_i == 0
    sex_title = '男性'
  else
    sex = 1
    sex_title = '女性'
  end

  age = "#{params['age']}"
  age_condition = (age.to_i / 10) * 10

  # Use genre id to fetch genre object
  @title = age_condition.to_s + '代' + sex_title + 'のランキング TOP30'
  @rankings = RakutenWebService::Ichiba::Item.ranking(:age => age_condition, :sex => sex)
  erb :item_ranking
end
