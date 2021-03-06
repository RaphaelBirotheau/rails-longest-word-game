require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = 10.times.map { alphabet.sample }
  end

  def score
    word = params[:guess]
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    answer = JSON.parse(response.read)
    check_word(answer)
  end

  def check_word(word)
    x = nil
    array = params["hidden_array"].gsub(" ", "").split("")
    guess = params["guess"].split("")
    if guess.all? {|x| array.include?(x)}
       x = true
     end
    if x == true && word["found"] == true
      @response = word["length"]
    else
      @response = "El wordo no existo"
    end
  end
end
