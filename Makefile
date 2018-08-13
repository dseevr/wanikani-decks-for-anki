FILENAME="mega_deck.txt"

all: make_decks generate_mega_deck

generate_mega_deck:
	@rm -f "${FILENAME}"
	@find ./decks -type f -print0 | sort -z | xargs -0 -IDECK cat DECK >> "${FILENAME}"
	@echo "Created ${FILENAME}"

make_decks:
	ruby make_decks.rb

.PHONY: all generate_mega_deck make_decks