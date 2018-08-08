class Hangman

  def initialize(player1 = 'AI', player2 = 'AI')
    @player1 = player1; @player2 = player2
    words = File.read "5desk.txt"
    word = words.split.select{|w| w.size.between?(5,12) }
    GameEngine.new(word[rand(0..word.length)])
  end

  class GameEngine
    def initialize(word)
      @hidden_word = (word)
      puts @hidden_word
    end

    def end_game(exit_text = "")
      puts exit_text
      exit(0)
    end
  end

  class Player
  end

  class Gameplay
    @incorrect_guesses = 0
    @used_letters = ""
  end

  def board
    puts %Q{
      x more incorrect guesses until failure!
      used letters = ""

      _____ _______ _____
    }
  end
end

new_game = Hangman.new()
new_game
