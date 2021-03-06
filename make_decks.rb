# encoding: utf-8

require "bundler/setup"
require "json"
require "anki"

headers = %w[front back]


(1..60).each_slice(5).each_with_index do |group, index|

  start_level = (index * 5) + 1
  end_level   = start_level + 4

  output_deck_filename = "wanikani-vocabulary-levels-%02d-through-%02d.txt" % [start_level, end_level]

  puts "Generating: #{output_deck_filename}"

  cards = []

  group.each do |n|
    f = File.read("data/#{n}.json", external_encoding: "utf-8", internal_encoding: "utf-8")

    JSON.parse(f)["requested_information"].each do |word|
      cards << {
        "front" => word["character"],
        # sometimes there is a trailing semicolon in the meaning text
        "back" =>  word["kana"] + "<br><br>" + word["meaning"].chomp(";")
      }
    end
  end

  deck = Anki::Deck.new(card_headers: headers, card_data: cards)

  # manually write the file instead of letting the anki gem do it so that
  # we can guarantee there's a newline on the end
  File.write("decks/#{output_deck_filename}", deck.generate_deck + "\n")
end
