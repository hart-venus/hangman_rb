# frozen_string_literal: true

word_list_file = File.open('../google-10000-english-no-swears.txt')
word_list = word_list_file.readlines
word_list_filtered = word_list.select { |word| word.length > 5 && word.length < 12 }

def start_game
  puts 'hi'
end

puts 'Welcome to Hangman! type "start" to start the game.'
start_game if gets.chomp == 'start'
