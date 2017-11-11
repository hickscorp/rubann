#!/usr/bin/env ruby

require 'wikipedia'
require 'ruby-fann'
require './utility_functions.rb'

TRAIN = false
SEED = {
  en: %w(Cat Dog Dream Coffee Person President Academic_degree Telephone Language Smile),
  fr: %w(Chat Chien Rêve Café Persone Président Grade_universitaire_en_France Téléphone Langage Sourire),
  es: %w(Felis_silvestris_catus Canis_lupus_familiaris Sueño Café Persona Presidente Título_académico Teléfono Idioma Sonrisa),
  pl: %w(Jezus_Chrystus Niemcy Druga_Świątynia Habilitacja Profesor Tytuł_naukowy Neologizm),
  pt: %w(Gato Cão Sonho Café Humano Presidente Grau_acadêmico Telefone Língua Riso)
}

LANGUAGES ||= SEED.keys
ALPHABET = "abcdefghijklmnopqrstuvwxyzàáâãæèéêëíîïñóôõùúûüąćęłńœśźż’' "

# This function is in charge of training a new neural network.
def train_neural_network
  # Prepare the inputs and outputs that will be used.
  # For every input that we create, we will need a matching output, as
  # each output represents the *expected* output of the neural network during
  # training and without which back-propagation is impossible. Therefore,
  # inputs and outputs are both lists of lists (lists of vectors).
  inputs    = []
  outputs   = []

  # Loop for each language with this outer loop. It means that the inside will
  # run as many times as we have different languages to train on.
  SEED.each do |lang, articles|
    # Prepare an array containing as many 0.0 values as we have languages.
    output = Array.new LANGUAGES.length, 0.0
    # Set the output that matches the current language to 1.0.
    output[LANGUAGES.index lang] = 1.0
    # At this point, the `ouput` variable contains something like [0.0, 0.0, 0.0]
    # and points the neural network to the expected output language we want.

    # Now we need an inner loop that will process each article.
    puts "Processing language #{lang}..."
    articles.each do |article|
      # Download the article text for the current language.
      text = wikipedia_page_text lang, article
      # Build the per-letter frequency dictionary.
      frequencies = letter_frequencies text
      # Transform the frequencies dictionary into our single input vector.
      input = build_inputs ALPHABET, frequencies
      inputs << input
      outputs << output
      puts "  Crawled page #{article}, length: #{text.length}"
    end
  end

  # Here we initialize a new neural network and store it in the variable named
  # `net`. Later, any operation we need to perform over the neural network could
  # be invoked using `net.something`. The neural network is initialized using
  # the various sizes of our training dataset and expected output length.
  net = RubyFann::Standard.new num_inputs: ALPHABET.length,
                               num_outputs: LANGUAGES.length,
                               hidden_neurons: [ALPHABET.length]
  # Our neural network being from a library, it expects a very specific training
  # dataset format, so we will create one here to train on. The training object
  # will be the most simple one containing our inputs and outputs, and will be
  # stored in a variable named `train`.
  train = RubyFann::TrainData.new inputs: inputs, desired_outputs:  outputs

  # Now we're going to train the neural network. The parameters that the library
  # expects are: the training dataset, the maximum number of iteration before
  # aborting, the visual reporting of the state of the training and the desired
  # target error rate (accuracy) of the resulting network.
  net.train_on_data train, 1000, 10, 0.01

  # As we might want to re-use the same network later if it proves itself to be
  # good enough, let's save it to the hard disk in a file.
  net.save 'frequencies.train'

  # As we want anyone calling this function to be able to use the trained network,
  # we make sure to return it here in the end.
  net
end

def load_neural_network
  RubyFann::Standard.new filename: 'frequencies.train'
end

# We want to either train or load the neural network from a file based on
# the value of our TRAIN constant.
net = if TRAIN
  train_neural_network
else
  load_neural_network
end

# Pipe our test into the same filtering pipeline as we did for our training
# dataset, so the normalization is the same.
text        = "Bonjour, mon nom est Toothy et je suis un lapin domestique. J'aime manger du foin et suivre les gens."
frequencies = letter_frequencies text
# Run our neural network and store the result in the `outputs` variable.
outputs     = net.run build_inputs ALPHABET, frequencies
# Print out each output and the language it corresponds to, to make sure our
# network has properly been trained.
LANGUAGES.each_with_index do |lang, idx|
  puts "#{lang}: #{outputs[idx].round 2}"
end
