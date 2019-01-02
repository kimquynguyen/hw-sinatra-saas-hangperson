class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  
  # def guess(char)
      
   #end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(letter)
    # raise error if argument is invalid
    #alpha is any ASCII character
    raise ArgumentError if (letter.to_s == '') or !(letter =~ /[[:alpha:]]/ )
    
    # turns this all lower case so we dont have to case check everytime
    letter.downcase!
    
    # check letter and if it doesn't exist, add it in the corresponding variable
    #include? is a function that checks to see if a variable is included in a given array
    if @word.include?(letter) 
      if @guesses.include?(letter)
        return false
      else
        @guesses += letter
      end
    else 
      if @wrong_guesses.include?(letter)
        return false
      else
        @wrong_guesses += letter 
      end
    end
    true
  end
  
  def word_with_guesses
    guessword=''
    @word.each_char do |letter|
      if @guesses.include?(letter)
        guessword += letter
      else
        guessword += '-'
      end
    end
    guessword
  end
  
  def check_win_or_lose
    if self.word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end


  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
