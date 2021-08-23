require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ("A".."Z").to_a.sample }
  end
  def score
    @attempt = params[:word]
    @letters = params[:letters]
    @user_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{@attempt}").read
    @user = JSON.parse(@user_serialized)
    @outcome = {}  
    if @attempt.upcase.chars.all? { |str| @letters.count(str.upcase) >= @attempt.upcase.chars.count(str) } == false
      @outcome[:message] ="not in the grid"
      @outcome[:score] = 0
    elsif @user["found"] == false
      @outcome[:message] = "not an english word"
      @outcome[:score] = 0
    else
      @outcome[:message] = "well done"
      @outcome[:score] = 5
    end
  end
end
