require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
  end

  def score
    @grid = params[:grid].split(' ')
    @result = check_if_word(params[:answer])
    @word = @result['word'].split('')

    if (@grid & @word).any?
      if @result['found']
        @reply = "#{@result['word']} is valid according to the grid and is an English word"
      else
        @reply = "#{@result['word']} is valid according to the grid, but is not a valid English word"
      end
    else
      @reply = "#{@result['word']} can’t be built out of the original grid"
    end
  end

  private

  def check_if_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = URI.open(url).read
    JSON.parse(user_serialized)
  end
end
