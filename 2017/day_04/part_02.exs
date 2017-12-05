# --- Part Two ---

# For added security, yet another system policy has been put in place. Now, a valid passphrase must contain no two words that are anagrams of each other - that is, a passphrase is invalid if any word's letters can be rearranged to form any other word in the passphrase.

# For example:

# abcde fghij is a valid passphrase.
# abcde xyz ecdab is not valid - the letters from the third word can be rearranged to form the first word.
# a ab abc abd abf abj is a valid passphrase, because all letters need to be used when forming another word.
# iiii oiii ooii oooi oooo is valid.
# oiii ioii iioi iiio is not valid - any of these words can be rearranged to form any other word.
# Under this new system policy, how many passphrases are valid?

defmodule Day04.Part02 do
  def no_anagrams(list) do
    list
    |> Enum.reject(fn(passphrase) ->
      compare_to_list(passphrase, list)
    end)
    |> length == 0
  end

  defp compare_to_list(passphrase, list) do
    passphrase = String.graphemes(passphrase)
    Enum.filter(list, fn(el) ->
      el = String.graphemes(el)
      el -- passphrase == [] && passphrase -- el == []
    end)
    |> length == 1
  end
end

File.stream!("input.txt")
|> Stream.map(&String.trim/1)
|> Stream.map(&String.split/1)
|> Enum.filter(fn(list) ->
  list
  |> Enum.uniq
  |> length
  |> Kernel.==(length(list))
end)
|> Enum.filter(&Day04.Part02.no_anagrams/1)
|> length
|> IO.puts
