# encoding: utf-8

require "json"
require "anki"

headers = %w[front back]


(1..60).each_slice(5).each_with_index do |group, index|

  start_level = (index * 5) + 1
  end_level   = start_level + 4

  output_deck_filename = "wanikani-vocabulary-levels-#{start_level}-through-#{end_level}.txt"

  puts "Generating: #{output_deck_filename}"

  cards = []

  group.each do |n|
    f = File.read("data/#{n}.json", external_encoding: "utf-8", internal_encoding: "utf-8")

    JSON.parse(f)["requested_information"].each do |word|
      cards << {
        "front" => word["character"],
        "back" =>  word["kana"] + "<br><br>" + word["meaning"]
      }
    end
  end

  deck = Anki::Deck.new(card_headers: headers, card_data: cards)

  deck.generate_deck(file: "decks/#{output_deck_filename}")
end
