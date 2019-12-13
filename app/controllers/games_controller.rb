require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = %w[A A B C D E E E F G H I
                  I I J K L M N O O P Q R
                  S T U U V W X Y Z]
    @value = alphabet.sample(10)
  end

  def score
    answer = params[:answer].upcase.split('')
    value = params[:value].split(' ')
    xoxo = answer - value
    check_letters = xoxo.empty?
    check_word = word_checker(params[:answer].downcase)

    @result =
      if check_letters == true && check_word == true
        "Nice! #{params[:answer].length} letters!"
      elsif check_letters == true && check_word == false
        'Nice try but this word do not exist!'
      else
        'Faux! Try again!'
      end
  end

  def word_checker(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized = open(url).read
    JSON.parse(serialized)['found']
  end
end
