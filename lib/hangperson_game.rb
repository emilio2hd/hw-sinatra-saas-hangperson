class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @game_status = :play
  end

  def guess(letter)
    raise ArgumentError if "#{letter}".empty? || !letter.match(/[a-z]/i)

    letter.downcase!

    if @word.include?(letter) && !@guesses.include?(letter)
      @guesses += letter
      @game_status = :win if word_with_guesses == @word
      return true
    elsif !@guesses.include?(letter) && !@wrong_guesses.include?(letter)
      @wrong_guesses  += letter
      @game_status = :lose if @wrong_guesses.length == 7
      return true
    end

    return false
  end

  def word_with_guesses
    word_guessed = "-" * @word.length

    (0..(word.length-1)).each do |i|
      if @guesses.include?(word[i])
        word_guessed[i] = word[i]
      end
    end

    word_guessed
  end

  def check_win_or_lose
    @game_status
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
