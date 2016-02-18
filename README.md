# WaniKani decks for Anki

I don't like how WaniKani forces you to learn the "most common" reading for kanji and repeatedly shows them to you as cards (which you'll get wrong constantly) so I wrote a script which will turn the output of their "vocabulary" API endpoints into Anki decks.

I broke the 6,000 words down into decks of 500 so you can import one which is roughly your skill level.

## Usage

Just import one of the .txt decks into Anki.

You can get Anki here:  [Anki website](http://ankisrs.net/)

If you want to regenerate the decks from scratch, you will need to generate an API key on the WaniKani site and run the following in the **data** directory to download all the JSON used by **make_decks.rb**:

```sh
export API_KEY="your api key here"
for f in {1..60}; do echo $f; URL="https://www.wanikani.com/api/user/${YOUR_API_KEY}/vocabulary/$f"; echo $URL; curl -o $f.json $URL; sleep 2; done
```

Then run:

```rb
ruby make_decks.rb
```

You'll need the `anki` gem installed.  `gem install anki` to get it.

## License

BSD
