defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards.
  """
  @doc """
  Returns a set list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
        value <> " of " <> suit
    end

  end

  @doc """
  Returns a shuffled List from the provided list/
  """
  def shuffle(deck) do 
    Enum.shuffle(deck)
  end

  @doc """
  Determines whether the deck contains a given card.

  ## Examples

      iex(1)> deck = Cards.create_deck
      iex(2)> Cards.contains?(deck,"Ace of Spades")
      true

  """

  def contains?(deck, card) do
    Enum.member?(deck,card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck. The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex(1)> deck = Cards.create_deck
      iex(2)> {hand, rest_of_the_deck} = Cards.deal(deck,2)
      iex(3)> hand
      ["Ace of Spades", "Two of Spades"]
      iex(4)> rest_of_the_deck
      ["Three of Spades", "Four of Spades", "Five of Spades",
      "Ace of Clubs", "Two of Clubs", "Three of Clubs", "Four of Clubs",
      "Five of Clubs", "Ace of Hearts", "Two of Hearts", "Three of Hearts",
      "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
      "Two of Diamonds", "Three of Diamonds", "Four of Diamonds",
      "Five of Diamonds"] 

  """

  def deal(deck, hand_size) do 
    Enum.split(deck, hand_size)
  end  

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do

    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file doesn't exist"
    end
    
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end

# defmodule Example do
#   def hello do
#     "HEYY!"
#   end
# end
  