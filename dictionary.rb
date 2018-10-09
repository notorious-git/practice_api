require "http"

while true
  system "clear"
  puts "Welcome to the Dictionary app!"

  print "Enter a word: "
  input_word = gets.chomp

  response = HTTP.get("https://api.wordnik.com/v4/word.json/#{input_word}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=ac6099e63826b8650f05e22c4cc08baa2f21668e3f16176fd")
  definitions = response.parse

  response = HTTP.get("https://api.wordnik.com/v4/word.json/#{input_word}/pronunciations?useCanonical=false&limit=50&api_key=ac6099e63826b8650f05e22c4cc08baa2f21668e3f16176fd")
  pronunciations = response.parse

  response = HTTP.get("https://api.wordnik.com/v4/word.json/#{input_word}/topExample?useCanonical=false&api_key=ac6099e63826b8650f05e22c4cc08baa2f21668e3f16176fd")
  top_example = response.parse

  puts "DEFINITIONS"
  index = 0
  definitions.length.times do
    definition = definitions[index]
    puts "#{index}. #{definition["text"]}"
    puts
    index += 1
  end

  puts "PRONUNCIATIONS"
  pronunciations.each_with_index do |pronunciation, index|
    puts "#{index}. #{pronunciation["raw"]}"
    puts
  end

  puts "TOP EXAMPLE"
  puts top_example["text"]

  puts "Enter q to quit, or any other key to continue"
  input_choice = gets.chomp
  if input_choice == "q"
    puts "Goodbye!"
    break
  end
end
