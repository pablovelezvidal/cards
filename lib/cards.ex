defmodule Cards do
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    # list comprehension
    for suit <- suits, value <- values do # get a single list with all the possible combinations of the two list without using two nested for loops
      "#{value} of #{suit}" # variable interpolation in strings
    end

    # List.flatten(cards) -> one solution to flatten a list of nested list if it is done with two for loops nested

  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write!(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary) # :erlang is the call to erlang code whereas :ok, :error are atoms, like strings
      {:error, _reason} -> "That file does not exists"
    end
  end

end
