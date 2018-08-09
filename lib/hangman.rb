class Hangman

  def initialize(player1 = 'AI',player2 = 'AI')
    Player.new(player1, player2)
    wds = File.read("5desk.txt").split
    GameEngine.new(wds.select{|w| w.size.between?(5,12)}[rand(0..wds.length)])
  end

  class GameEngine
    def initialize(word)
      $hidden_word = (word)
      $word_hidden = $hidden_word.chars{|w| w = '_'}
    end

    def end_game(exit_text = "")
      puts exit_text; exit(0)
    end
  end

  class Player

    def initialize(player_one, player_two)
      @player_one = player_one; @player_two = player_two
    end

    @wrongs = 0; @used_chars = ""; @alph = ('a'..'z').to_a; @turns = 1

    @board = %Q{
        #{8 - @wrongs} more incorrect guesses until failure!
        used letters = #{@used_chars}

        #{$word_hidden}
      }

    while @wrongs < 8 do
      if @turns % 2
        @player_two == 'AI' ? Player.ai : Player.human
      else
        @player_one == 'AI' ? Player.ai : Player.human
      end
      @turns += 1
    end

    def Player.ai
      puts "I am a robot"
      pick = @alph.select{|l| !(@used_chars.include?(l))}[rand(0..pick.length)]
      if $hidden_word.include?(pick)
        $word_hidden.chars do |c|
          if $hidden_word.each_index.select{|i| $hidden_word[i] == pick}.include?($word_hidden.index(c))
            c = pick; @used_chars << pick
          end
        end
        exit_game("Success!") if !($word_hidden.include?('_'))
      else
        @used_chars << pick; puts @board; @wrongs += 1
      end
    end

    def Player.human
      puts "I am a human"
      p '> '; pick = $stdin.gets.chomp

      if @used_chars.include?(pick)
        puts "That letter has already been chosen"; human
      elsif !(@used_chars.include?(pick)) && $hidden_word.include?(pick)
        $word_hidden.chars do |c|
          if $hidden_word.each_index.select{|i| $hidden_word[i] == pick}.include?($word_hidden.index(c))
            c = pick; @used_chars << pick
          end
        end
        exit_game("Success!") if !($word_hidden.include?('_'))
      elsif !(@used_chars.include?(pick)) && !($hidden_word.include?(pick))
        @used_chars << pick; puts @board; @wrongs += 1
      end

    end
  end
end

new_game = Hangman.new()
new_game
