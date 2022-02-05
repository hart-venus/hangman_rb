# frozen_string_literal: true

word_list_file = File.open('../google-10000-english-no-swears.txt')
word_list = word_list_file.readlines
word_list_filtered = word_list.select { |word| word.length > 5 && word.length < 12 }

def start_game(word_list)
  guesses_left = 10
  word_guessed = false
  guessed_letters = []
  random_word = word_list.sample
  letter_guess_array = Array.new(random_word.length - 1, '_')

  until word_guessed || guesses_left.zero?
    puts letter_guess_array.join(' ')
    puts "Incorrect guesses left: #{guesses_left}"
    puts "Guessed letter: #{guessed_letters}"
    guessed_letter = gets.chomp.downcase[0]
    next if guessed_letters.include?(guessed_letter)

    guessed_letters << guessed_letter
    if check_letter(letter_guess_array, guessed_letter, random_word)
      letter_guess_array = check_letter(letter_guess_array, guessed_letter, random_word)
    else
      guesses_left -= 1
    end

  end

  puts "tough luck! Word was #{random_word}" if guesses_left.zero?
end

def check_letter(letter_guess_array, guessed_letter, random_word)
  return_value = nil

  letter_guess_array.each_with_index do |_, index|
    if guessed_letter == random_word[index]
      letter_guess_array[index] = random_word[index]
      return_value = letter_guess_array
    end
  end

  return_value
end

puts 'Welcome to Hangman! type "start" to start the game.'
start_game(word_list_filtered) if gets.chomp == 'start'
