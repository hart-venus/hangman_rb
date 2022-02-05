# frozen_string_literal: true

require 'json'
word_list_file = File.open('../google-10000-english-no-swears.txt')
word_list = word_list_file.readlines
word_list_filtered = word_list.select { |word| word.length > 5 && word.length < 12 }

def save(guessed_letters, letter_guess_array, guesses_left, random_word)
  save_hash = {
    guesses: guessed_letters,
    guesses_left: guesses_left,
    array: letter_guess_array,
    word: random_word
  }
  File.open('save.json', 'w') { |f| f.write(save_hash.to_json) }
  puts 'file saved successfully.'
  # puts "#{guessed_letters} #{letter_guess_array}, #{random_word}"
end

def start_game(word_list, saved_game=false)
  guesses_left = 10
  word_guessed = false
  guessed_letters = []
  random_word = word_list.sample unless saved_game
  letter_guess_array = Array.new(random_word.length - 1, '_') unless saved_game

  if saved_game
    guesses_left = saved_game['guesses_left']
    guessed_letters = saved_game['guesses']
    letter_guess_array = saved_game['array']
    random_word = saved_game['word']
  end
  
  until word_guessed || guesses_left.zero?
    puts letter_guess_array.join(' ')
    puts "Incorrect guesses left: #{guesses_left}"
    puts "Guessed letters: #{guessed_letters}"
    input = gets.chomp.downcase
    if input == 'save'
      save(guessed_letters, letter_guess_array, guesses_left, random_word)
      break
    end
    guessed_letter = input[0]
    if guessed_letters.include?(guessed_letter)
      puts 'You already guessed that letter!'
      next
    end

    if guessed_letter.nil?
      puts 'please input a letter.'
      next
    end

    guessed_letters << guessed_letter
    if check_letter(letter_guess_array, guessed_letter, random_word)
      letter_guess_array = check_letter(letter_guess_array, guessed_letter, random_word)
      unless letter_guess_array.include?('_')
        puts "Congrats! You guessed #{random_word} with #{guesses_left} guesses left."
        break
      end
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

def load_game
  savefile = File.read('save.json')
  saved_hash = JSON.parse(savefile) || 'Invalid file.'
  start_game([], saved_hash)
end

puts 'Welcome to Hangman! type "start" to start, or "load" to load a previous game. Type "save" anytime to save.'

input = gets.chomp.downcase
start_game(word_list_filtered) if input == 'start'
load_game if input == 'load'