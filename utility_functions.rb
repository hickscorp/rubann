# This file isn't meant to be used standalone and contains a set of utility
# function allowing to ease the training of our ANN.

# This function is in charge of downloading a wikipedia article given a language
# and an article title.
def wikipedia_page_text(lang, title)
  Wikipedia.configure { domain "#{lang}.wikipedia.org" }
  Wikipedia.find(title).text                          # Download the article.
           .downcase                                  # Lowercase it.
           .gsub(/[^#{Regexp.quote(ALPHABET)}]/i, '') # Remove everything that is not part of our alphabet.
           .gsub(/\s+/, ' ')                          # Replace multiple consecutive white spaces by just one.
end

# This function will return the frequency at which letter occurs in a given text.
def letter_frequencies(text)
  # The next couple of lines will build a dictionary that will contain the number
  # of time each letter was seen in the text.
  occurences = text.split('').each_with_object({}) do |letter, ret|
    ret[letter] = (ret[letter] || 0) + 1
  end
  # At this point, the `occurences` variable looks like `{a: 32, b: 25 ...}`.
  # It's not really what we want, so the next iteration makes it into frequencies
  # instead, eg {a: 0.25, b: 11, ...}. As this loop is the last statement in this
  # function, it will also be its return value.
  occurences.each_with_object({}) do |(letter, occurence), ret|
    ret[letter] = 1.0 / text.length * occurence
  end
end

def build_inputs(alphabet, frequencies)
  alphabet.split('').map { |letter| frequencies[letter] || 0.0 }
end
