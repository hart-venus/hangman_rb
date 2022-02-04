# frozen_string_literal: true

word_list_file = File.open('../google-10000-english-no-swears.txt')
word_list = word_list_file.readlines
word_list_filtered = word_list.select { |word| word.length > 5 && word.length < 12 }

def start_game(word_list)
  guesses_left = 10
  random_word = word_list.sample()
  puts random_word
end

puts 'Welcome to Hangman! type "start" to start the game.'
start_game(word_list_filtered) if gets.chomp == 'start'
