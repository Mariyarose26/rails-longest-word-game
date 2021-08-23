require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ("A".."Z").to_a.sample }
  end
  def score
    @attempt = params[:word].upcase
    @letters = params[:letters]
    @user_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{@attempt}").read
    @user = JSON.parse(@user_serialized)
    @outcome = {}  
    if @attempt.upcase.chars.all? { |str| @letters.count(str.upcase) >= @attempt.chars.count(str) } == false
      @outcome[:message] ="not in the Grid provided. Try Again!!!"
      @outcome[:score] = 0
    elsif @user["found"] == false
      @outcome[:message] = "not an English Word.Try Again!!!"
      @outcome[:score] = 0
    else
      @outcome[:message] = "an English Word. Well Done!!!"
      @outcome[:score] = 5
    end
  end
end
