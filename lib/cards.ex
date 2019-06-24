defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck
  """
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

  @doc """
    Determines wether a deck contains a given cards

    ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    divides a deck into a hand and the reminder of the deck. The `hand size` determines how many cards.
    The doc test below, using the `examples stuff`, also works as a test, when in the elixir console you
    run mix test, it also run the doctest, so, if you change the hand to be Ace of Spad, it will fail.

    ## Examples

      iex> deck = Cards.create_deck
      iex>{hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
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

  def create_hand(hand_size) do
    #deck = Cards.create_deck
    #deck = Cards.shuffle(deck)
    #hand = Cards.deal(deck, hand_size) #normal code without the pipe operator
    Cards.create_deck #pipe operator is not magic, the expected first parameter needs to be the value returned by the previous function
    |>Cards.shuffle
    |>Cards.deal(hand_size) #after every call, the pipe pass the result as the first parameter to next function in the pipe
  end

end
