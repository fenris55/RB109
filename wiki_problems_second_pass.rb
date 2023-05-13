=begin
second pass on wiki codewars problems
only completed up to the 40s on the first pass
beginning 4/16

1.Count letters in string
(https://www.codewars.com/kata/5808ff71c7cfa1c6aa00006d/train/ruby)
6 kyu

=begin
Count letters in string
In this kata, you've to count lowercase letters in a given string and return the
letter count in a hash with 'letter' as key and count as 'value'. The key must
be 'symbol' instead of string in Ruby

Example:

letterCount('arithmetics') #=> {:a=>1, :c=>1, :e=>1, :h=>1, :i=>2, :m=>1, :r=>1, :s=>1, :t=>2}

P:
write a method that takes a lowercase string and returns a hash that has each
letter of the string as a key and its count in the word as the value

input: string (lowercase letters only)
return: hash (with letter symbols as keys and integers (counts) as values)

rules:
-input string will only hold lowercase letters
-create hash with each letter as key and its count as symbol
-each key must be a symbol, not a string

E:
p letter_count('codewars') == {:a=>1, :c=>1, :d=>1, :e=>1, :o=>1, :r=>1, :s=>1, :w=>1})
p letter_count('activity') == {:a=>1, :c=>1, :i=>2, :t=>2, :v=>1, :y=>1}
p letter_count('arithmetics') == {:a=>1, :c=>1, :e=>1, :h=>1, :i=>2, :m=>1, :r=>1, :s=>1, :t=>2})

D:
-hash to hold letter counts
-iterative structure to loop over input string and populate hash with counts

A:
-initialize letter_count hash with default value 0
-iterate over each character in input string
  -convert current letter to symbol and add to letter_count hash as a key, while
  incrementing value by 1
-return letter_count hash

def letter_count(string)
  letter_count = Hash.new(0)
  string.each_char do |letter|
    letter_count[letter.to_sym] += 1
  end
  letter_count
end

p letter_count('codewars') == {:a=>1, :c=>1, :d=>1, :e=>1, :o=>1, :r=>1, :s=>1, :w=>1}
p letter_count('activity') == {:a=>1, :c=>1, :i=>2, :t=>2, :v=>1, :y=>1}
p letter_count('arithmetics') == {:a=>1, :c=>1, :e=>1, :h=>1, :i=>2, :m=>1, :r=>1, :s=>1, :t=>2}

2.Find all pairs
(https://www.codewars.com/kata/5c55ad8c9d76d41a62b4ede3/train/ruby)
7 kyu

Find all pairs

You are given array of integers, your task will be to count all pairs in that
array and return their count.

Notes:

Array can be empty or contain only one value; in this case return 0
If there are more pairs of a certain number, count each pair only once. E.g.:
for [0, 0, 0, 0] the return value is 2 (= 2 pairs of 0s)
Random tests: maximum array length is 1000, range of values in array is between
0 and 1000
Examples
[1, 2, 5, 6, 5, 2]  -->  2
...because there are 2 pairs: 2 and 5

[1, 2, 2, 20, 6, 20, 2, 6, 2]  -->  4
...because there are 4 pairs: 2, 20, 6 and 2 (again)

P:
Write a method that takes an array of integers and returns an integer
representing the number of pairs in the array

input: array of integers
return: integer (count of pairs)

rules:
-return 0 of array is empty, has only 1 element, or has no pairs
-a pair must consist of unique occurences of a number

E:
p pairs([1, 2, 5, 6, 5, 2]) == 2
p pairs([1, 2, 2, 20, 6, 20, 2, 6, 2]) == 4
1: 1 -> 1/2 -> 0
2: 2 -> 4/2 -> 2

p pairs([0, 0, 0, 0, 0, 0, 0]) == 3
count: 7 -> 7 /2 -> 3

D:
-array of unique values to iterate over
  -transform each value to count

A:
-create copy of unique values in input array (unique_numbers)
-iterate over unique numbers, performing transformation
  -find count of current number in input array
-save result as counts
-iterate over counts array, performing transformation
  -divide each element by 2
-pair_counts
-return the sum of the elemnets in the pair_counts array

def pairs(array)
  unique_numbers = array.uniq
  counts = unique_numbers.map do |num|
    array.count(num)
  end
 pair_counts = counts.map { |num| num / 2 }
 pair_counts.sum
end

def pairs(array)
  array.uniq.map { |num| array.count(num) / 2 }.sum
end

p pairs([1, 2, 5, 6, 5, 2]) == 2
p pairs([1, 2, 2, 20, 6, 20, 2, 6, 2]) == 4
p pairs([0, 0, 0, 0, 0, 0, 0]) == 3
p pairs([1000, 1000]) == 1
p pairs([]) == 0
p pairs([54]) == 0

3.Return substring instance count
(https://www.codewars.com/kata/5168b125faced29f66000005/train/ruby)
7 kyu

Return substring instance count
Complete the solution so that it returns the number of times the search_text is
found within the full_text.

Usage example:

solution('aa_bb_cc_dd_bb_e', 'bb') # should return 2 since bb shows up twice
solution('aaabbbcccc', 'bbb') # should return 1

P:
write a method that takes 2 strings and finds the number of times the second
string occurs within the first

input: 2 strings
return: integer

rules:
-find count occurrence of 2nd string in 1st string
questions - assume all letters are lowercase? assume no spaces?

D:
-iterative structure to find substrings

A:
-initialize count to 0
-iterative over index positions from 0 to string1 size minus string2 size (index)
  -take slice of string1 starting at current index with length of string2 size
  -if slice is equal to string 2,
    -increment count by 1
-return count

def solution(string1, string2)
  count = 0
  (0..string1.size - string2.size).each do |index|
   count +=1 if string1[index, string2.size] == string2
  end
  count
end

p solution('abcdeb','b') == 2
p solution('abcdeb', 'a') == 1
p solution('abbc', 'bb') == 1
p solution('aaabbbcccc', 'bbb') == 1


4.Alphabet symmetry
(https://www.codewars.com/kata/59d9ff9f7905dfeed50000b0)
7 kyu

Alphabet symmetry
Consider the word "abode". We can see that the letter a is in position 1 and b
is in position 2. In the alphabet, a and b are also in positions 1 and 2. Notice
also that d and e in abode occupy the positions they would occupy in the
alphabet, which are positions 4 and 5.

Given an array of words, return an array of the number of letters that occupy
their positions in the alphabet for each word. For example,

solve(["abode","ABc","xyzD"]) = [4, 3, 1]
See test cases for more examples.

Input will consist of alphabet characters, both uppercase and lowercase. No
spaces.


P:
write a method that takes an array of strings an returns an array of integers;
integers are a count for each string of the letters that occupy alphabet positions

input: array of string
return: array of integers

rules:
-input strings can be uppercase or lowercase with no spaces
-for each string, find the count of letters whose position in the string is the
same as position in the alphabet

E:
p solve(["abode","ABc","xyzD"]) == [4,3,1]
p solve(["abide","ABc","xyz"]) == [4,3,0]
p solve(["IAMDEFANDJKL","thedefgh","xyzDEFghijabc"])== [6,5,7]
p solve(["encode","abc","xyzD","ABmD"]) == [1, 3, 1, 3]

D:
-array of lowercase a-z
-iterative structure to loop over input array and find a count for each string
-array of counts

A:
-initialize alphabet to lowercase range 'a'-'z' and convert to array
-iterate over array (word), performing transformation
  -iterate over each downcased letter and index in a string (letter, index) performing selection
    -check if current index is the same as the index of that letter in the
    alphabet array
    -select letter if indices as the same
  -save return value of inner iteration as selected_letters
  -find count of selected letters

def solve(array)
  alphabet = ('a'..'z').to_a
  array.map do |word|
    word.downcase.chars.select.with_index do |letter, index|
     index == alphabet.index(letter)
    end.count
  end
end

p solve(["abode","ABc","xyzD"]) == [4,3,1]
p solve(["abide","ABc","xyz"]) == [4,3,0]
p solve(["IAMDEFANDJKL","thedefgh","xyzDEFghijabc"])== [6,5,7]
p solve(["encode","abc","xyzD","ABmD"]) == [1, 3, 1, 3]

5.Longest vowel chain
(https://www.codewars.com/kata/59c5f4e9d751df43cf000035/train/ruby)
7 kyu
=begin
Longest vowel chain
The vowel substrings in the word codewarriors are o,e,a,io. The longest of these
has a length of 2. Given a lowercase string that has alphabetic characters only
and no spaces, return the length of the longest vowel substring. Vowels are any
of aeiou.

P:
write a method that takes a string and returns an integer representing the length
of the longest subtring containing only vowels

input: string
return: integer

rules:
-input string will only hold lowercase letters
-find and return length of longest substring containing only vowels
-vowels here are aeiou

E:
p solve("iiihoovaeaaaoougjyaw") == 8
['iii', 'oo', 'aeaaaoou', a] -> 'aeaaaoou' -> 8

p solve("strengthlessnesses") == 1
['e', 'e', 'e', 'e'] -> 'e' -> 1

D:
-array of vowels
-get_all_substrings helper method

A:
-define get_all_vowel_substrings helper method
  -initialize vowels to array of lowercase vowels
  -initialize vowel_substrings array
  -iterate from 0 up to length of string, exclusive (start_index)
    -iterate from start_index to length of string, exclusive (end_index)
      -take slice of string ranging from start_index to end_index
      -initialize substring to slice
        -convert substring to array of character
          -if all characters are included in vowels array
            -push substring slice to vowel_substrings array
  -return vowel_substrings array
-initialie longest_substring to the result of selecting the longest substring
from vowel_substrings array
-find and return the length of longest_substring

=end
def get_all_vowel_substrings(string)
  vowels = %w(a e i o u)
  vowel_substrings = []
  (0...string.size).each do |start_index|
    (start_index...string.size).each do |end_index|
     substring = string[start_index..end_index]
      if substring.chars.all? {|letter| vowels.include?(letter) }
        vowel_substrings << substring
      end
    end
  end
  vowel_substrings
end

def solve(string)
  vowel_substrings = get_all_vowel_substrings(string)
  longest_substring = vowel_substrings.max_by { |substring| substring.size }
  longest_substring.size
end
=begin
#refactored:
def solve(string)
  get_all_vowel_substrings(string).max_by { |substring| substring.size }.size
end

p solve("codewarriors") == 2
p solve("suoidea") == 3
p solve("iuuvgheaae") == 4
p solve("ultrarevolutionariees") == 3
p solve("strengthlessnesses") == 1
p solve("cuboideonavicuare") == 2
p solve("chrononhotonthuooaos") == 5
p solve("iiihoovaeaaaoougjyaw") == 8

6.Non-even substrings
(https://www.codewars.com/kata/59da47fa27ee00a8b90000b4/train/ruby)
6 kyu
=begin
Given a string of integers, return the number of odd-numbered substrings that
can be formed.

For example, in the case of "1341", they are 1, 1, 3, 13, 41, 341, 1341, a total
of 7 numbers.

solve("1341") = 7. See test cases for more examples.

P:
write a number and return an integer representing the number of odd numbers that
exist as substrings

input: string (number)
return: integer (count of off numbers in string)

rules:
-identify how many odd numbers are present in the input string
-return count of odd numbers
-assume valid input

E:
solve("1341") = 7. See test cases for more examples.
-get all substrings:
1, 13, 134, 1341, 3, 34, 341, 4, 41, 1
-convert to integers
- find odd numbers
1, 13, 1341, 3, 341, 41, 1
-find count:
7

D:
-iterative structure to get all substrings
-array to hold substrings
-iterative structure to find and return count of odd substrings

A:
-initialize odd_substrings to an emptry array
-begin iteration to access all substrings
  -iterate from 0 up to string size, exclusive (start_index)
    -iterate from start_index to string size, exclusive (end_index)
      -take slice of string from start_index and ranging up to end_index, inclusive
        -add slice to string is slice converted to an integer is odd
-find and return size of odd_substrings array

def solve(string_number)
  odd_substrings = []
  (0...string_number.size).each do |start_index|
    (start_index...string_number.size).each do |end_index|
     slice = string_number[start_index..end_index]
     odd_substrings << slice if slice.to_i.odd?
    end
  end
  odd_substrings.size
end


p solve("1341") == 7
p solve("1357") == 10
p solve("13471") == 12
p solve("134721") == 13
p solve("1347231") == 20
p solve("13472315") == 28


7.Substring fun
(https://www.codewars.com/kata/565b112d09c1adfdd500019c/train/ruby)
7 kyu
=begin
Complete the function that takes an array of words.

You must concatenate the nth letter from each word to construct a new word which
should be returned as a string, where n is the position of the word in the list.

For example:

["yoda", "best", "has"]  -->  "yes"
  ^        ^        ^
  n=0     n=1     n=2
Note: Test cases contain valid input only - i.e. a string array or an empty
array; and each word will have enough letters.

P:
given an array of strings, created an return a new string formed of the letters
that correspond to the index postition of each string within the array

input: array (of strings)
return: string

rules:
-create and return a string
-new string should be formed of the letters whose index positions correspond
with the position of each string within the array
-if input array is empty, return an empty string
-explicitly return empty string if input array is empty
-assume valid input

E:
p nth_char(['No', 'No']) == 'No'
array index 0: 'No' -> string index 0: 'N'
array index 1: 'No' -> stinrg index 1 -> 'o'
result: 'No'

D:
-empty string to build result and return
-iterative structure to loop over integers from 0 to array size

A:
-return empty string if input array is empty
-initialize result to empty string
-iterate from 0 up to string size, exclusive (index)
  -use index reference to access the letter and word at current index of input array
    (array[0][0], array[1][1]) -> array[index][index]
  -add accessed letter to result string
-return result string

def nth_char(array)
  return '' if array.empty?
  result = ''
  (0...array.size).each do |index|
   result << array[index][index]
  end
  result
end

p nth_char(['yoda', 'best', 'has']) == 'yes'
p nth_char([]) == ''
p nth_char(['X-ray']) == 'X'
p nth_char(['Chad', 'Morocco', 'India', 'Algeria', 'Botswana', 'Bahamas', 'Ecuador', 'Micronesia']) ==  'Codewars'

8.Repeated Substring
(https://www.codewars.com/kata/5491689aff74b9b292000334/train/ruby)
6 kyu
=begin
For a given nonempty string s find a minimum substring t and the maximum number
k, such that the entire string s is equal to t repeated k times. The input
string consists of lowercase latin letters. Your function should return a tuple
(in Python) (t, k) or an array (in Ruby and JavaScript) [t, k]

Example #1:

for string

s = "ababab"
the answer is

["ab", 3]
Example #2:

for string

s = "abcde"
the answer is
['abcde', 1]
because for this string "abcde" the minimum substring t, such that s is t
repeated k times, is itself.


write a method that takes a string and returns an array. the array should hold
the smallest substring that can be repeated to form the input string and an
integer representing the number of times that substring must be repeated

input: string
return: array (holding a substring and an integer)

rules:
-input string will only contain lower case letters
-if no substring can be repeated to form the input string, the return array
should hold the entire string and integer 1
-if multiple substrings can be repeated to form the input string, find the smallest

E:
p f("ababab") == ["ab", 3]
-get all substrings
['a, ab, 'aba, 'abab', 'ababa', 'ababab', 'b', 'ba', 'bab'...]
sort:
['a', 'b', 'ab', 'ba']
-sort all substrings
-iterate over sorted substrings
-multiply the substring by the size of the input string divided by substring size
-check if equal to input string
-if equal, add to result

A:
-get all substrings - helper method
  -initialize substrings to empty array
  -iterate from 0 up to string size, exclusive (start_index)
    -iterate from start_idnex up to string size, exclusive (end_index)
      -take slice from input string ranging from start_index to end_index
      -push slice to substrings array

 -sort substrings array by size

 -intialize result to empty array
 -iterate over sorted_substrings array (substring)
    -initialize multiplier to the result of dividing string size by substring size
    -multiply current substring by multiplier and check if equal to input string
      -if equal, push substring to result array
      -push multiplier to result array
-return result array

def get_all_substrings(string)
  substrings = []
  (0...string.size).each do |start_index|
    (start_index...string.size).each do |end_index|
     substrings << string[start_index..end_index]
    end
  end
  substrings
end

def f(string)
  substrings = get_all_substrings(string)
  sorted_substrings = substrings.sort_by { |ss| ss.size }

  result = []
  sorted_substrings.each do |substring|
    multipler = string.size / substring.size
    if substring * multipler == string
      result << substring
      result << multipler
      return result
    end
  end
end

p f("ababab") == ["ab", 3]
p f("abcde") == ["abcde", 1]


9.Typoglycemia Generator
(https://www.codewars.com/kata/55953e906851cf2441000032/train/ruby)
5 kyu

=begin
Background
There is a message that is circulating via public media that claims a reader can
easily read a message where the inner letters of each words is scrambled, as
long as the first and last letters remain the same and the word contains all the
letters.

Another example shows that it is quite difficult to read the text where all the
letters are reversed rather than scrambled.

In this kata we will make a generator that generates text in a similar pattern,
but instead of scrambled or reversed, ours will be sorted alphabetically

Requirement
return a string where:

1) the first and last characters remain in original place for each word
2) characters between the first and last characters must be sorted
alphabetically
3) punctuation should remain at the same place as it started, for example:
shan't -> sahn't

Assumptions

1) words are seperated by single spaces
2) only spaces separate words, special characters do not, for example:
tik-tak -> tai-ktk
3) special characters do not take the position of the non special characters,
for example: -dcba -> -dbca
4) for this kata puctuation is limited to 4 characters: hyphen(-),
apostrophe('), comma(,) and period(.)
5) ignore capitalisation

for reference: http://en.wikipedia.org/wiki/Typoglycemia

P:
wrte a mehod that takes a string and alphabetically sorts all letters in the
string except for the first and last lettter and punctuation.

input: string
return: string

rules:
-ignore punctuation
-split words only at spaces (not at punctuation)
-only 4 special characters will be included (. , - ')
-leading and trailing punctuation does not count as the first letter of a word
-

E:
return string if string size is less than 4

ASK: does string contain a space?
if no: iterate over letters
if yes: split input array of words and iterate over each word; then iterate over each letter

-initialize special_chars array
-initialize special chars hash
-initialize new_string to empty string

-iterate over each char with index
  -if current character is included in the special characters array
    -add to hash with index as key and character as value
  -else, push current char to new string

if new_string includes a space
  -split string into array of words and iterte over
    -sort the range of characters from index 1 to index -2 and concatenate
  back to first and last character
-else, sort the range of characters from index 1 to index -2 and concatenate
  back to first and last character

iterate over special chars hash (index, char)
  insert char at index of sorted string

-return sorted string

#FINALLY! solved for the first time 4/23
def scramble_words(string)
  return string if string.size < 4

  special_characters = %w(, . - ')
  special_chars_in_string = Hash.new(0)
  new_string = ''

  string.each_char.with_index do |char, index|
    if special_characters.include?(char)
      special_chars_in_string[index] = char
    else
      new_string << char
    end
  end

  if new_string.include?(' ')
    new_string = new_string.split.map do |word|
      word[0] + word[1..-2].chars.sort.join + word[-1]
    end.join(' ')
  else
    new_string = new_string[0] + new_string[1..-2].chars.sort.join + new_string[-1]
  end

  special_chars_in_string.each do |index, char|
    new_string.insert(index, char)
  end
  new_string
end

p scramble_words('professionals') == 'paefilnoorsss'
p scramble_words('i') == 'i'
p scramble_words('') == ''
p scramble_words('me') == 'me'
p scramble_words('you') == 'you'
p scramble_words('card-carrying') == 'caac-dinrrryg'
p scramble_words("shan't") == "sahn't"
p scramble_words('-dcba') == '-dbca'
p scramble_words('dcba.') == 'dbca.'
p scramble_words("you've gotta dance like there's nobody watching, love like
you'll never be hurt, sing like there's nobody listening, and live like it's
heaven on earth.") == "you've gotta dacne like teehr's nbdooy wachintg, love like ylo'ul neevr be hrut, sing like teehr's nbdooy leiinnstg, and live like it's haeevn on earth."


10.Most frequently used words in a text]
(https://www.codewars.com/kata/51e056fe544cf36c410000fb/train/ruby)
4 kyu
=begin
Write a function that, given a string of text (possibly with punctuation and
line-breaks), returns an array of the top-3 most occurring words, in descending
order of the number of occurrences.

Assumptions:
A word is a string of letters (A to Z) optionally containing one or more
apostrophes (') in ASCII. (No need to handle fancy punctuation.)
Matches should be case-insensitive, and the words in the result should be
lowercased.

Ties may be broken arbitrarily.

If a text contains fewer than three unique words, then either the top-2 or top-1
words should be returned, or an empty array if a text contains no words.

Examples:
top_3_words("In a village of La Mancha, the name of which I have no desire to
call to
mind, there lived not long since one of those gentlemen that keep a lance
in the lance-rack, an old buckler, a lean hack, and a greyhound for
coursing. An olla of rather more beef than mutton, a salad on most
nights, scraps on Saturdays, lentils on Fridays, and a pigeon or so extra
on Sundays, made away with three-quarters of his income.")
# => ["a", "of", "on"]

top_3_words("e e e e DDD ddd DdD: ddd ddd aa aA Aa, bb cc cC e e e")
# => ["e", "ddd", "aa"]

top_3_words("  //wont won't won't")
# => ["won't", "wont"]
Bonus points (not really, but just for fun):
Avoid creating an array whose memory footprint is roughly as big as the input
text.
Avoid sorting the entire array of unique words.

P:
write a method that takes a string and returns an array holding the 3 most-used words

input: string
return: array

rules:
-if input is empty string, return empty array
-if input string contains less than 3 unique words, return array with 1 or 2
elements (still in descending order)
-return array should be sorted so that word with highest count comes first
-apostrophes should be included as part of a word
-words are unique based on if they contain apostrophes (cant != can't)
-all other punctuation (and spaces) should be ignored
-method should should be case-insensitive and all words in return should be downcased

E:
p top_3_words("a a a  b  c c  d d d d  e e e e e") == ["e", "d", "a"]
initialize empty hash
iterate over string
for each character, add word/char to hash as key and increment count/value by one


D:
-array of lowercase letters a-z and apostrophe (valid_chars)
-hash to hold space-separated words/characters as keys and count as value
-iterative structure to populate hash with count of each word
-iterateive structure to find the 3 highest hash value and place corresponding keys into array and return

A:
MAIN METHOD:
-invoke get_clean_string helper method (return clean string)
-invoke find_counts helper method (return a hash of counts)
-sort hash, reverse return, seleted first 23 elements, push element at index 0
of each subarray to result array

1.clean string:
  -define get_clean_string helper method
  -initialize valid_chars to range 'a'..'z', convert to array, append apostrophe
  -initialize clean_string to empty string
  -iterate over downcased input string
    -push to clean_string if char is included in valid_chars
      OR char is a space
-return clean string

2.find counts
-define find_counts helper method
-initialize counts hash with default value of 0
-iterate over each word in input string
  -set word to hash key and increment value by 1
-return counts hash

3. find result
-initialize result array
-sort hash by value (returns a nested array) and reverse
-take the first 3 elements and push element of index 0 of each element to result array

-return result array

def get_clean_string(string)
  valid_chars = ('a'..'z').to_a << "'"
  clean_string = ''
  string.downcase.each_char do |char|
    if valid_chars.include?(char) || char == ' '
      clean_string << char
    end
  end
  clean_string
end

def find_counts(string)
  counts_hash = Hash.new(0)
  string.split(' ').each do |word|
    counts_hash[word] += 1
  end
  counts_hash
end

def top_3_words(string)
 clean_string = get_clean_string(string)
 count_hash = find_counts(clean_string)
 sorted_hash = count_hash.sort_by {|word, count| count }.reverse

 result = []
 return result if count_hash.empty?

 if sorted_hash.size >= 1
  result << sorted_hash[0][0]
 end

 if sorted_hash.size >= 2
  result << sorted_hash[1][0]
 end

 if sorted_hash.size >= 2
   result << sorted_hash[2][0]
 end
 p result
end

#### 1. [] is being accessed on nil at some place
###2. apostropher is being added to count hash, coutnerd, and returned
p top_3_words("a a a  b  c c  d d d d  e e e e e") == ["e", "d", "a"]
p top_3_words("e e e e DDD ddd DdD: ddd ddd aa aA Aa, bb cc cC e e e") == ["e", "ddd", "aa"]
#p top_3_words("  //wont won't won't ") == ["won't", "wont"]
p top_3_words("  , e   .. ") == ["e"]
p top_3_words("  ...  ") == []
p top_3_words("  '  ") == []
p top_3_words("  '''  ") == []
p top_3_words("""In a village of La Mancha, the name of which I have no desire to call to
mind, there lived not long since one of those gentlemen that keep a lance
in the lance-rack, an old buckler, a lean hack, and a greyhound for
coursing. An olla of rather more beef than mutton, a salad on most
nights, scraps on Saturdays, lentils on Fridays, and a pigeon or so extra
on Sundays, made away with three-quarters of his income.""") == ["a", "of", "on"]


def domain_name(url)
  new_string = ''
  alphabet = ('a'..'z').to_a
  (0...url.size).each do |index|
   # break if url[index] == '.'
    if !alphabet.include?(url[index])
      next
    else
    new_string << url[index..-1]
    break
  end
  end
 p new_string
end



def domain_name(url)
  alphabet = ('a'..'z').to_a
  string = ''
  placeholder = ''

  url.chars.each_with_index do |letter, index|
   if alphabet.include?(letter)
    placeholder << letter
   # p placeholder
    string = placeholder
    #p string
   else
     break if letter == '.'

     placeholder = ''
    next
   end
 end
 string
 end

def domain_name(url)

  period_split = url.split('.')
  array = []
  period_split.each do |slice|
    array << slice unless slice.include?('www') || slice.include?('com')
  end
  p array
end

p domain_name("http://google.com") == "google"
p domain_name("http://google.co.jp") == "google"
p domain_name("www.xakep.ru") == "xakep"
p domain_name("https://youtube.com") == "youtube"
p domain_name("http://github.com/carbonfive/raygun") == "github"
p domain_name("http://www.zombie-bites.com") == "zombie-bites"
p domain_name("https://www.cnet.com") #== "cnet"

12. Detect Pangram
(https://www.codewars.com/kata/545cedaa9943f7fe7b000048/train/ruby)
6 kyu
A pangram is a sentence that contains every single letter of the alphabet at
least once. For example, the sentence "The quick brown fox jumps over the lazy
dog" is a pangram, because it uses the letters A-Z at least once (case is
irrelevant).

Given a string, detect whether or not it is a pangram. Return True if it is,
False if not. Ignore numbers and punctuation.

P:
write a method that takes a string and returns a boolean indicating whether the
string contains all letters of the alphabet

input: string
output: boolean

rules:
-ignore non-letter chars
-ignore case

E:
p panagram?("The quick brown fox jumps over the lazy dog.") == true
p panagram?("This is not a pangram.") == false

D:
-array of lowercase alphabet
-iterative structure to check whetehr every chaacter in alphabet is included
in the downcased string

A:
-initialize range of lowercase a-z
-iterate over range
  -check if current alphabet letter is included in downcased input string
-if all letters are inlcuded return true; else return false

def panagram?(string)
  ('a'..'z').all? { |letter| string.downcase.include?(letter) }
end

p panagram?("The quick brown fox jumps over the lazy dog.") == true
p panagram?("This is not a pangram.") == false

#retrying url

11.Extract the domain name from a URL
(https://www.codewars.com/kata/514a024011ea4fb54200004b/train/ruby)
5 kyu
=begin
Write a function that when given a URL as a string, parses out just the domain
name and returns it as a string. For example:

domain_name("http://github.com/carbonfive/raygun") == "github"
domain_name("http://www.zombie-bites.com") == "zombie-bites"
domain_name("https://www.cnet.com") == "cnet"


P:
write a string representing a url and returns the substring representing the
domain name

input: string
return: string (substring of input string)

rules:
-find domain name substring and return
-domain will will always be followed by a period
-domain name can be preceeded by a forward slash or a period
-additional forwrd slashes and period can be present in input string

E:
domain_name("http://github.com/carbonfive/raygun") == "github"
# / domain name .
domain_name("http://www.zombie-bites.com") == "zombie-bites"
# . domain name .
domain_name("https://www.cnet.com") == "cnet"
# . domain name .
p domain_name("http://google.com") == "google"
# / dm .
p domain_name("http://google.co.jp") == "google"
# / dm .
p domain_name("www.xakep.ru") == "xakep"
#. dm .
p domain_name("https://youtube.com") == "youtube"
/ dm .

D:
-array of input string substrings split at '/'
-iterative structure to perform selection, selecting the substring that include '.'

A:
think i need to hand / and no / separately
if string includes '/':
  -split at forward slash
  -select elements that include '.'
  -split at period
  -select and return first element
else (no forward slash):
  initiazize index array
  iterate over each char and index
  -if current element is '.', push index to index array
  -take slice of input string starting at first index + 1 and ending at second
  index, exclusive

def domain_name(string)
  if string.include?('/')
    split_string = string.split('/')
    substrings_with_period = split_string.select { |ss| ss.include?('.') }
    period_split = substrings_with_period[0].split('.')
    substrings = period_split.delete_if { |el| el == 'www' }
    substrings.first
  else
    indices = []
    string.each_char.with_index { |char, index| indices << index if char == '.'}
    string[indices[0].succ...indices[1]]
  end
end

p domain_name("http://google.com") == "google"
p domain_name("http://google.co.jp") == "google"
p domain_name("www.xakep.ru") == "xakep"
p domain_name("https://youtube.com") == "youtube"
p domain_name("http://github.com/carbonfive/raygun") == "github"
p domain_name("http://www.zombie-bites.com") == "zombie-bites"
p domain_name("https://www.cnet.com") == "cnet"

def url_with_forward_slash(string)
  split_string = string.split('/')
  substrings_with_period = split_string.select { |ss| ss.include?('.') }
  period_split = substrings_with_period[0].split('.')
  substrings = period_split.delete_if { |el| el == 'www' }
  substrings.first
end

def url_with_no_forward_slash(string)
  indices = []
  string.each_char.with_index { |char, index| indices << index if char == '.'}
  string[indices[0].succ...indices[1]]
end

def domain_name(string)
  if string.include?('/')
    url_with_forward_slash(string)
  else
    url_with_no_forward_slash(string)
  end
end

#refactored to ternary and modified 2nd helper method to account for test cases
that have a period but no leading chars, like 'google.com'
def url_with_forward_slash(string)
  split_string = string.split('/')
  substrings_with_period = split_string.select { |ss| ss.include?('.') }
  period_split = substrings_with_period[0].split('.')
  substrings = period_split.delete_if { |el| el == 'www' }
  substrings.first
end

def url_with_no_forward_slash(string)
  indices = []
  string.each_char.with_index { |char, index| indices << index if char == '.'}
  if indices.size > 1
    string[indices[0].succ...indices[1]]
  else
    string.split('.').first
  end
end

def domain_name(string)
  string.include?('/') ? url_with_forward_slash(string) : url_with_no_forward_slash(string)
end

p domain_name("http://google.com") == "google"
p domain_name("http://google.co.jp") == "google"
p domain_name("www.xakep.ru") == "xakep"
p domain_name("https://youtube.com") == "youtube"
p domain_name("http://github.com/carbonfive/raygun") == "github"
p domain_name("http://www.zombie-bites.com") == "zombie-bites"
p domain_name("https://www.cnet.com") == "cnet"


13. Kebabize
(https://www.codewars.com/kata/57f8ff867a28db569e000c4a/train/ruby)
6 kyu
Modify the kebabize function so that it converts a camel case string into a
kebab case.

kebabize('camelsHaveThreeHumps') // camels-have-three-humps
kebabize('camelsHave3Humps') // camels-have-humps
Notes:

the returned string should only contain lowercase letters

P:
write a method that takes a string with no spaces in which each word begins with
a capital letter and return a new string with only lowercase letters in which each
word is separated by a hyphen

input: string
return: string

rules:
-input string will begin with lowercase letter
-input string with have no spaces
-each new word in input string it demarked by captial letter
-input string can contain non-letter characters
-return string should contain only lowercase letter characters
-each word should be separated by hyphen
-non-letter chars should be deleted
-assumption - return a new string

E:
p kebabize('myCamelCasedString') == 'my-camel-cased-string'

['my', 'Camel', 'Cased', 'String'] -> ['my', 'camel', 'cased', 'string']
['my', 'camel', 'cased', 'string'].join('-') -> 'my-camel-cased-string'

p kebabize('myCamelHas3Humps') == 'my-camel-has-humps'

'myCamelHas3Humps') -> delete unless char is included in a-z or A-Z
['my', 'Camel', 'Has3 'Humps'] -> ['my', 'camel', 'hash3', 'humps']

['my', 'camel', 'cased', 'string'].join('-') -> 'my-camel-cased-string'

D:
-empty result string
-iterative structure to loop over the input string and push characters to the
result string

A:
-initialize result to empty string
-iterate over each character in input string
  -if letter is included in range a-z
    -push to result string
  -else letter is included in range A-Z
    -concatenate '-' and downcase letter before pushing
-return result string

def kebabize(string)
  result = ''
  string.each_char do |char|
    if ('a'..'z').include?(char)
      result << char
    elsif ('A'..'Z').include?(char)
      result << "-#{char.downcase}"
    end
  end
  p result
end

p kebabize('myCamelCasedString') == 'my-camel-cased-string'
p kebabize('myCamelHas3Humps') == 'my-camel-has-humps'


14. Dubstep
(https://www.codewars.com/kata/551dc350bf4e526099000ae5/train/ruby)
6 kyu
Polycarpus works as a DJ in the best Berland nightclub, and he often uses
dubstep music in his performance. Recently, he has decided to take a couple of
old songs and make dubstep remixes from them.

Let's assume that a song consists of some number of words (that don't contain
WUB). To make the dubstep remix of this song, Polycarpus inserts a certain
number of words "WUB" before the first word of the song (the number may be
zero), after the last word (the number may be zero), and between words (at least
one between any pair of neighbouring words), and then the boy glues together all
the words, including "WUB", in one string and plays the song at the club.

For example, a song with words "I AM X" can transform into a dubstep remix as
"WUBWUBIWUBAMWUBWUBX" and cannot transform into "WUBWUBIAMWUBX".

Recently, Jonny has heard Polycarpus's new dubstep track, but since he isn't
into modern music, he decided to find out what was the initial song that
Polycarpus remixed. Help Jonny restore the original song.

Input
The input consists of a single non-empty string, consisting only of uppercase
English letters, the string's length doesn't exceed 200 characters

Output
Return the words of the initial song that Polycarpus used to make a dubsteb
remix. Separate the words with a space.

Examples
song_decoder("WUBWEWUBAREWUBWUBTHEWUBCHAMPIONSWUBMYWUBFRIENDWUB")  =>  WE ARE
THE CHAMPIONS MY FRIEND

P:
-write a method that takes a string with words separated by 'WUB' and returns
that string with all 'WUB's removed and the remaining words separating by single
spaces

input: string
return: string

rules:
-assumption - return a new string
-remove all occurences of 'WUB' and return string with remaining words separated
by single spaces with no leading or trailing spaces
-input string will not be empty
-all characters will be uppercase letters

D:
-array of substrings from input string split at each 'WUB'
-iterative strucutre to select non-empty strings and rejoin with single spaces

A:
-split the input into an array of substrings, with each split occuring at each
instance of 'WUB'
-from returned array, select non-empty strings
-rejoin selected strings with a space between each string
-return

def song_decoder(string)
  words_array = string.split('WUB')
  words_array.select { |word| !word.empty? }.join(' ')
end


def song_decoder(string)
  p string.split('WUB').join(' ').strip.gsub(/\s+/, ' ') ### regex for removing multiple spaces
end

p song_decoder("AWUBBWUBC") == "A B C"
p song_decoder("AWUBWUBWUBBWUBWUBWUBC") == "A B C"
p song_decoder("WUBAWUBBWUBCWUB") == "A B C"
p song_decoder("WUBWEWUBAREWUBWUBTHEWUBCHAMPIONSWUBMYWUBFRIENDWUB") == "WE ARE THE CHAMPIONS MY FRIEND"
p song_decoder("WUBIWUBWUBWUBSEEWUBTHEWUBLIGHT") == "I SEE THE LIGHT"

##first attempt at word pattern below wtih no pedac:
def word_pattern(pattern, s)
hash = Hash.new(0)

unique_pattern = pattern.chars.uniq
unique_words = s.split('.').uniq

pattern.size.times do |num|
  hash[unique_pattern[num]] = unique_words[num]
  end

string_array = s.split(' ')
pattern.each_char.with_index do |letter, index| #a
  if !(hash[letter] == string_array[index])
    return false
  end
end
true

end

hash { 'a' => 'cat',
        'b' => 'dog'
      }

string_array = s.to_a
"abba".eachwith_index do |letter, index| #a
  hash[letter] == string_array[index]


Word Pattern
Given a pattern and a string s, find if s follows the same pattern.
Here follow means a full match, such that there is a bijection between a letter
in pattern and a
non-empty word in s.

Example 1:
Input: pattern = "abba", s = "dog cat cat dog"
Output: true

Example 2:
Input: pattern = "abba", s = "dog cat cat fish"
Output: false

Example 3:
Input: pattern = "aaaa", s = "dog cat cat dog"
Output: false

P:
write a method that takes 2 strings and returns a boolean indicating whether the
word occurence in the second string matches the letter pattern in the first string

input: 2 strings (letter pattern and string of words)
return: boolean

rules:
-letters in first string create a pattern
-check if word occurence in second string matches the pattern of word occurence
in second string
-assumption? - both input strings will be equal size and non-empty

E:
("abba", "dog cat cat dog") == true
a = dog
b = cat
abba = dog cat cat dog

("aaaa", "dog cat cat dog") == false
a = dog
aaaa = dog dog dog dog

D:
-hash to create a reference key with pattern letters as keys and associated word
as value
-arrays of unique chars in both input strings
-array of words from string
-iterative structure to loop over each character and index in pattern, checking
if the associated hash key is equal to the string array element

A:
-convert pattern to array of characters, create copy with only unique characters,
and save to unique_pattern_characters
-convert string to array of characters, create copy with only unique characters,
and save to unique_string_characters

-if the 2 uniq array are not the same size, return false

-initialize word_and_letter to new hash with default value of 0
-iterate over indices from 0 to size of pattern, exclusive
  -use index reference to set a new hash key to pattern element of unique string
  and set value to unique_string_characters element at current index

-convert input string to array of word (word_array)

iterate over each char in pattern with index
  -use hash reference to check if value associated with current letter/key (which will be
  value/word) is equal to the word/element located at the corresponding index
  in the word_array
  -if not equal, return false
-if iteration finishes, return true

def word_pattern(pattern, string)
  unique_letters = pattern.chars.uniq
  unique_words = string.split.uniq
  return false if unique_letters.size != unique_words.size

  word_and_letter = Hash.new(0)
  (0...unique_letters.size).each do |index|
    word_and_letter[unique_letters[index]] = unique_words[index]
  end

  word_array = string.split

  pattern.each_char.with_index do |letter, index|
    return false unless word_and_letter[letter] == word_array[index]
  end

  true
end

#refactored:
def validate_input(pattern, string)
  pattern.chars.uniq.size == string.split.uniq.size ? true : false
end

def create_reference_hash(pattern, string)
  unique_letters = pattern.chars.uniq
  unique_words = string.split.uniq

  word_and_letter = Hash.new(0)
  (0...unique_letters.size).each do |index|
    word_and_letter[unique_letters[index]] = unique_words[index]
  end
   word_and_letter
end

def compare_word_and_pattern(pattern, string, hash)
   word_array = string.split

   pattern.each_char.with_index do |letter, index|
   return false unless hash[letter] == word_array[index]
  end
  true
end

def word_pattern(pattern, string)
  return false unless validate_input(pattern, string)
  word_and_letter = create_reference_hash(pattern, string)
  compare_word_and_pattern(pattern, string, word_and_letter)
end

p word_pattern("abba", "dog cat cat dog") == true
p word_pattern("abba", "dog cat cat fish") == false
p word_pattern("aaaa", "dog cat cat dog") == false

15. Take a Ten Minute Walk
(https://www.codewars.com/kata/54da539698b8a2ad76000228/train/ruby)
6 kyu
You live in the city of Cartesia where all roads are laid out in a perfect grid.
You arrived ten minutes too early to an appointment, so you decided to take the
opportunity to go for a short walk. The city provides its citizens with a Walk
Generating App on their phones -- everytime you press the button it sends you
an array of one-letter strings representing directions to walk
(eg. ['n', 's', 'w', 'e']). You always walk only a single block in a direction
and you know it takes you one minute to traverse one city block, so create a
function that will return true if the walk the app gives you will take you
exactly ten minutes (you don't want to be early or late!) and will, of course,
return you to your starting point. Return false otherwise.

Note: you will always receive a valid array containing a random assortment of
direction letters ('n', 's', 'e', or 'w' only). It will never give you an empty
array (that's not a walk, that's standing still!).

P:
write a method that takes an array of letters (representing directions) and
returns a boolean indicating wether following the given directions will
1. take 10 minutes (1 minute per letter) and 2. return you to your start
position

input: array (of letter n, e, s, w)
return: boolean

rules:
-assume valid input (input array will only hold letters n e s w)
-input array will never be empty
-assuming -> method should return false if input array size is not 10
-

E:
p is_valid_walk(['w']) == false
1 direction == 1 minutes -> returns false

p is_valid_walk(['w','e','w','e','w','e','w','e','w','e','w','e']) == false
12 direction == 12 minutes -> returns false

p is_valid_walk(['n','s','n','s','n','s','n','s','n','s']) == true

start count at 0
for n, add 1
for 2, subtract 1
0 + 1 - 1 + 1 - 1 + 1 - 1 + 1 - 1 + 1 - 1
  ['n','s','n','s','n','s','n','s','n','s']

north_south_count = 0 +1 +1 +1 - 1 +1 -1 +1 -1 +1 -1
for north, +1
for south, -1
east_west_count = 0
for east, +1
for west, -1

p is_valid_walk(['n','n','n','s','n','s','n','s','n','s']) == false

D:
-north_south_count initialized to 0
-east_west_count initialized to 0
-iterative strucutre to loop over input array and increment or decrement counts
  -control flow structure to determing counting

A:
-return false unless size of input array is 10
-initialize north_south count to 0
-initialize east_west count to 0
-begin iteration over input array (direction)
  initialize case statement for direction
    -when 'n' then increment north_south_count by 1
    -when 's' then decrement north_south_count by 1
    -when 'e' then increment east_west_count by 1
    -when 'w' then decrement east_west_count by 1
-when iteration in complete, check if both north_south count and east_west count
equal zero (return value)

def is_valid_walk(directions)
  return false unless directions.size == 10
  north_south_count = 0
  east_west_count = 0

  directions.each do |direction|
    case direction
    when 'n' then north_south_count += 1
    when 's' then north_south_count -= 1
    when 'e' then east_west_count += 1
    when 'w' then east_west_count -= 1
    end
  end
  north_south_count == 0 && east_west_count == 0
end

#from codewars:
-same logic can be acheived by comparing counts of n/s and e/w for equality
and checking that the overall count is 10

def is_valid_walk(directions)
  directions.count('n') == directions.count('s') && directions.count('e') == directions.count('w') && directions.count == 10
end

p is_valid_walk(['n','s','n','s','n','s','n','s','n','s']) == true
p is_valid_walk(['w','e','w','e','w','e','w','e','w','e','w','e']) == false
p is_valid_walk(['w']) == false
p is_valid_walk(['n','n','n','s','n','s','n','s','n','s']) == false

16. Stop gninnipS My sdroW!
(https://www.codewars.com/kata/5264d2b162488dc400000001)
6 kyu
Write a function that takes in a string of one or more words, and returns the
same string, but with all five or more letter words reversed (Just like the
name of this Kata). Strings passed in will consist of only letters and spaces.
Spaces will be included only when more than one word is present.

Examples: spinWords( "Hey fellow warriors" ) => returns "Hey wollef sroirraw"

P:
write a method that takes a string and returns the same string will all words
that have 5 or more letters reverse

input: string
return: string

rules:
-if a word has 5 or more letters, reverse it
-input strings will only hold letters and spaces
-input string can be a single word
-method with return a copy of input string if the length of each word is < 5

E:
p spinWords("Hey fellow warriors") == "Hey wollef sroirraw"

['Hey', 'fellow', 'warriors']
counts: 3, 6, 8 (reverse if count is 5 or greater)
['Hey', 'wollef', 'sroirraw']
'Hey wollef sroirraw'

p spinWords("test") == "test"
#be mindful of how the string is split into an array

p spinWords("This is a test") == "This is a test"
#all words have less than 5 chars

D:
-array of all words in input string
-iterative structure to loop over word array, checking count and performing
transformation if count is 5 or greater

A:
-initialize word_array to input string split into array of words at spaces
-iterate over word_array, performing transformation
  -if size of current word is 5 or greater, reverse
-save result array as reversed_words
-convert reversed_words to string separated by spaces

def spinWords(string)
  word_array = string.split(' ')
  reversed_words = word_array.map do |word|
   if word.size >= 5
     word.reverse
   else
     word
   end
  end

  reversed_words.join(' ')
end

p spinWords("Hey fellow warriors") == "Hey wollef sroirraw"
p spinWords("This is a test") == "This is a test"
p spinWords("This is another test") == "This is rehtona test"
p spinWords("test") == "test"

17. Write Number in Expanded Form
(https://www.codewars.com/kata/5842df8ccbd22792a4000245)
6 kyu
Write Number in Expanded Form
You will be given a number and you will need to return it as a string in
Expanded Form. For example:

expanded_form(12); # Should return '10 + 2'
expanded_form(42); # Should return '40 + 2'
expanded_form(70304); # Should return '70000 + 300 + 4'
NOTE: All numbers will be whole numbers greater than 0.

P:
write a method that takes an integer and returns a string representing that
integer in expanded form

input integer
return: string

rules:
-write integer in expanded form
-zeros should be ignored

E:
p expanded_form(12) == '10 + 2'
'12'
reversed: 21
(1, 2) = index
'2'+ ('0' * index)
20,
string size: 2
string size
##########
trying again

17. Write Number in Expanded Form
(https://www.codewars.com/kata/5842df8ccbd22792a4000245)
6 kyu
Write Number in Expanded Form
You will be given a number and you will need to return it as a string in
Expanded Form. For example:

expanded_form(12); # Should return '10 + 2'
expanded_form(42); # Should return '40 + 2'
expanded_form(70304); # Should return '70000 + 300 + 4'
NOTE: All numbers will be whole numbers greater than 0.

P: write a method that takes an integer and returns a string representing that
integer in expanded form.

input: integer
return: string

rules:
-assume input is a whole number greater than 0

E:
p expanded_form(70304) == '70000 + 300 + 4'
[7, 0, 3, 0, 4]

[4, 0, 3, 0, 7]
[0, 1, 2, 3, 4]
#number of zero to be added corresponds to index position
[4, 00, 300, 0000, 70000] -> reverse: [70000, 0, 300, 0, 4]

D:
-string version of input integer
-reversed array of string number in input integer
-iterative structure to loop over numbers array with index position, performing transformation
  -next if index == 0
  -num + (0 * index)
-structure to perform selection of transformed elements that are not 0
-strcuture to rejoin elements as a string separated by ' + '

A:
-convert input array to string
-reverse string
-convert string to array of single-character elements (numbers array)
-iterate over number_array and index, performing transformation
  -return current number if current index is zero
  -multiply string 0 by current index
  -concatenate to current array element
  -store result in new array
-save return of iteration as transformed_numbers
-reverse transformed_numbers
-iterate over transformed numbers and delete all elements that are greater than
0 when converted to an integer (selected_numbers)
-join selected numbers to string joined with ' + '

def expanded_form(int)
  numbers_array = int.to_s.reverse.chars
  transformed_numbers = numbers_array.map.with_index do |num, index|
    num if index == 0
    num << ('0' * index)
  end
  transformed_numbers.reverse.select { |num| num if num.to_i > 0 }.join(' + ')
end

p expanded_form(12) == '10 + 2'
p expanded_form(42) == '40 + 2'
p expanded_form(70304) == '70000 + 300 + 4'


18. Persistent Bugger.
(https://www.codewars.com/kata/55bf01e5a717a0d57e0000ec/train/ruby)
6 kyu
Write a function, persistence, that takes in a positive parameter num and
returns its multiplicative persistence, which is the number of times you must
multiply the digits in num until you reach a single digit.

For example:

 persistence(39) # returns 3, because 3*9=27, 2*7=14, 1*4=4
                 # and 4 has only one digit

 persistence(999) # returns 4, because 9*9*9=729, 7*2*9=126,
                  # 1*2*6=12, and finally 1*2=2

 persistence(4) # returns 0, because 4 is already a one-digit number

 P:
 write a method that takes an integer, splits it into digits, and repeats until
 the result in a 1-digit number. Return the count of times the digit was split
 and multiplied

 input: integer
 return: integer (count)

 rules:
 -assume valid input
 -split integer into digits and find product
  -repeat until result is a 1-digit number
  -count number of splits/ultiplications
-if input integer is a 1-digit number, return 0

E:
p persistence(999) == 4
[9, 9, 9] -> 729
[7, 2, 9] -> 126
[1, 2, 6] -> 12
[1, 2] ->2

p persistence(25) == 2
[2, 5] -> 10
[1, 0] -> 0

p persistence(39) == 3
[3, 9] -> 27
[2, 7] ->14
[1, 4] -> 4
 =end

p persistence(39) == 3
p persistence(4) == 0
p persistence(25) == 2
p persistence(999) == 4

D:
-count variable to keep track of number of loops
-loop to split integer into an array of digits, find the product, and increment
the count

A:
-define method with parameter integer
-initialize count to 0
-initialize a loop
  -break if integer is less than 10
  -split input integer into array of digits
  -find product of digits in the array
  -reassign product to integer
  increment count
-end iteration ends, return count

def persistence(integer)
  count = 0
  loop do
   break if integer < 10
   integer = integer.digits.reduce(:*)
   count += 1
  end
  count
end

p persistence(39) == 3
p persistence(4) == 0
p persistence(25) == 2
p persistence(999) == 4


19. Title Case
(https://www.codewars.com/kata/5202ef17a402dd033c000009)
6 kyu
A string is considered to be in title case if each word in the string is either
(a) capitalised (that is, only the first letter of the word is in upper case) or
(b) considered to be an exception and put entirely into lower case unless it is
the first word, which is always capitalised.

Write a function that will convert a string into title case, given an optional
list of exceptions (minor words). The list of minor words will be given as a
string with each word separated by a space. Your function should ignore the case
of the minor words string -- it should behave in the same way even if the case
of the minor word string is changed.


p title_case('a clash of KINGS', 'a an the of') == 'A Clash of Kings'
p title_case('THE WIND IN THE WILLOWS', 'The In') == 'The Wind in the Willows'
p title_case('the quick brown fox') == 'The Quick Brown Fox'


38. String transformer
(https://www.codewars.com/kata/5878520d52628a092f0002d0/train/ruby)
6 kyu
Given a string, return a new string that has transformed based on the input:

Change case of every character, ie. lower case to upper case, upper case to lower case.
Reverse the order of words from the input.
Note: You will have to handle multiple spaces, and leading/trailing spaces.

For example:

"Example Input" ==> "iNPUT eXAMPLE"
You may assume the input only contain English alphabet and spaces.

P:
write a method that takes a string and returns a new string with: 1. the case
of each character reverse 2. the appearance of each word in te string reversed
3.spaces maintained as they appear in teh input string

input: string
return: string

rules
-swap case of each character
-reverse the order of words
-maintain spaces as they appear in input string
-expect leading, trailing, and multiple spaces between words

E:
" Example   Input " ==> "iNPUT eXAMPLE"

swap case:
" Example   Input " -> " eXAMPLE   iNPUT "

create array holding just words:
['eXAMPLE', 'iNPUT']

convert string to array of characters:
[" ", "E", "x", "a", "m", "p", "l", "e", " ", " ", " ", "I", "n", "p", "u", "t", " "]

take slice of spaces
[[" "], ["E", "x", "a", "m", "p", "l", "e"], [" ", " ", " "], ["I", "n", "p", "u", "t"], [" "]]

iterate over nested array. if subarray does not contain space, replace with last
element in words array
1st iteration:
["eXAMPLE", ]
[[" "], "iNPUT", [" ", " ", " "], ["I", "n", "p", "u", "t"], [" "]]

2nd iteration:
[ ]
[[" "], "iNPUT", [" ", " ", " "], "eXAMPLE", [" "]]

flatten and join result:
[[" "], "iNPUT", [" ", " ", " "], "eXAMPLE", [" "]]  -> " iNPUT   eXAMPLE "

D:
-input string
-array of chars from string
-array of words from string
-return string

A:
-swap case of each character in string
-save words in string to array (words_array)
-convert string to array of all characters (char_array)
-take slices of char array at space (sliced_array)
  -iterate over string
  -take slice when current char is a space and next char is not OR when current
    char is not a space and next char is
-iterate over sliced_array (result_array)
  -if current subarray contains a space,
    join
  -else,
    remove last element in the words array
    replace current subarray with removed word
-join result_array

def transform_string(string)
  words_array = string.split
  char_array = string.chars
  sliced_array = char_array.slice_when do |char1, char2|
    char1 == ' ' && char2 != ' ' || char1 != ' ' && char2 == ' '
  end

  result_array = sliced_array.map do |subarray|
    if subarray.include?(' ')
      subarray
    else
      words_array.pop
    end
  end
 result_array.flatten.join.swapcase
end

#p transform_string(" Example   Input ") == " iNPUT   eXAMPLE "
p transform_string("You Know  When  THAT Hotline Bling") == "bLING hOTLINE  that  wHEN kNOW yOU" #does not pass codewars


#array = ['a', 'b', 'c', 'e']
#sliced_arr = array.slice_when {|char1, char2| char1.ord + 1 != char2.ord}.to_a
#p sliced_arr


19. Title Case
(https://www.codewars.com/kata/5202ef17a402dd033c000009)
6 kyu
A string is considered to be in title case if each word in the string is either
(a) capitalised (that is, only the first letter of the word is in upper case) or
(b) considered to be an exception and put entirely into lower case unless it is
the first word, which is always capitalised.

Write a function that will convert a string into title case, given an optional
list of exceptions (minor words). The list of minor words will be given as a
string with each word separated by a space. Your function should ignore the case
of the minor words strdef title_case(string, exceptions = '')
  exceptions = exceptions.downcase.split
  string.downcase.split.map.with_index do |word, index|
    exceptions.include?(word) && index != 0 ? word : word.capitalize
  end.join(' ')

end
p title_case('a clash of KINGS', 'a an the of') == 'A Clash of Kings'
p title_case('THE WIND IN THE WILLOWS', 'The In') == 'The Wind in the Willows'
p title_case('the quick brown fox') == 'The Quick Brown Fox'
ing -- it should behave in the same way even if the case
of the minor word string is changed.

p title_case('a clash of KINGS', 'a an the of') == 'A Clash of Kings'
p title_case('THE WIND IN THE WILLOWS', 'The In') == 'The Wind in the Willows'
p title_case('the quick brown fox') == 'The Quick Brown Fox'

21. Find the Mine!
(https://www.codewars.com/kata/528d9adf0e03778b9e00067e/train/ruby)
6 kyu
You've just discovered a square (NxN) field and you notice a warning sign. The
sign states that there's a single bomb in the 2D grid-like field in front of you.

Write a function mineLocation/MineLocation that accepts a 2D array, and returns
the location of the mine. The mine is represented as the integer 1 in the 2D
array. Areas in the 2D array that are not the mine will be represented as 0s.

The location returned should be an array (Tuple<int, int> in C#) where the first
element is the row index, and the second element is the column index of the bomb
location (both should be 0 based). All 2D arrays passed into your function will
be square (NxN), and there will only be one mine in the array.

P:
write a method that takes a nested array with integers as subarray element.
Return an array with 2 integers: the index position of the subarray holding the
1, and the index position of the 1 within that subarray

rules:
-input is 2-D array
-subarray elements will consist only of zeros and 1 one

E:
p mineLocation([ [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 1, 0], [0, 0, 0, 0] ]) == [2, 2]

D:
input: nested array
return: array (holding 2 integers/index positions)

A:
-initialize empty result array
-iterate over input array with index (subarray)
  -if subarray includes 1
    -push current index to result variable
      -iterate over subarray with index (number)
        -if number == 1,
          -push current index to result array
-return result array


def mineLocation(array)
  result = []
  array.each_with_index do |subarray, index|
   if subarray.include?(1)
     result << index
     subarray.each_with_index do |number, index|
       result << index if number == 1
     end
   end
  end
  result
end

p mineLocation( [ [1, 0, 0], [0, 0, 0], [0, 0, 0] ] ) == [0, 0]
p mineLocation( [ [0, 0, 0], [0, 1, 0], [0, 0, 0] ] ) == [1, 1]
p mineLocation( [ [0, 0, 0], [0, 0, 0], [0, 1, 0] ] ) == [2, 1]
p mineLocation([ [1, 0], [0, 0] ]) == [0, 0]
p mineLocation([ [1, 0, 0], [0, 0, 0], [0, 0, 0] ]) == [0, 0]
p mineLocation([ [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 1, 0], [0, 0, 0, 0] ]) == [2, 2]


22. Scramblies
(https://www.codewars.com/kata/55c04b4cc56a697bb0000048/train/ruby)
5 kyu
Complete the function scramble(str1, str2) that returns true if a portion of
str1 characters can be rearranged to match str2, otherwise returns false.

Notes:

Only lower case letters will be used (a-z). No punctuation or digits will be
included.
Performance needs to be considered
Input strings s1 and s2 are null terminated.

P: write a method that takes 2 strings and returns a boolean if string 2
can be formed with the letters in string 1

rules:
-input strings will only include lowercase letters
-each letter from string 2 must meet 2 requirements:
  1. must be included in first string
  2. count of letter in string 1 must be greater than or equal to count of letter
  in second string

E:
p scramble('cedewaraaossoqqyt', 'codewars') == true
p scramble('katas', 'steak') == false

D:
-input: 2 strings
-array holding all characters from string2
-return: boolean

A:
-create array of all characters fom string 2
-begin iteration over string2 array
  -check if letter is included in string 1 AND is the count of the letter in
  string 1 greater than or equal to the count of the letter in string2
-if all iterations return true, return; else false

def scramble(string1, string2)
  string2_chars = string2.chars
  string2_chars.all? do |letter|
   string1.include?(letter) && string1.count(letter) >= string2.count(letter)
 end
end

p scramble('rkqodlw', 'world') == true
p scramble('cedewaraaossoqqyt', 'codewars') == true
p scramble('katas', 'steak') == false
p scramble('scriptjava','javascript') == true
p scramble('scriptingjava','javascript') == true

25. Pete, the baker
(https://www.codewars.com/kata/525c65e51bf619685c000059/train/ruby)
5 kyu
Pete likes to bake some cakes. He has some recipes and ingredients.
Unfortunately he is not good in maths. Can you help him to find out, how many
cakes he could bake considering his recipes?

Write a function cakes(), which takes the recipe (object) and the available
ingredients (also an object) and returns the maximum number of cakes Pete can
bake (integer). For simplicity there are no units for the amounts (e.g. 1 lb of
flour or 200 g of sugar are simply 1 or 200). Ingredients that are not present
in the objects, can be considered as 0.

Examples:

// must return 2
cakes({flour: 500, sugar: 200, eggs: 1}, {flour: 1200, sugar: 1200, eggs: 5, milk: 200});
// must return 0
cakes({apples: 3, flour: 300, sugar: 150, milk: 100, oil: 100}, {sugar: 500, flour: 2000, milk: 2000});

def cakes(recipe, inventory)
  return 0 if !recipe.keys.all? { |ingredient| inventory.keys.include?(ingredient) } || inventory.empty?

  counts = []
  recipe.each do |ingredient, amount|
  counts << inventory[ingredient] / amount
  end
  counts.min
end

p cakes({"flour"=>500, "sugar"=>200, "eggs"=>1},{"flour"=>1200, "sugar"=>1200, "eggs"=>5, "milk"=>200}) == 2
p cakes({"cream"=>200, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>1700, "flour"=>20000, "milk"=>20000, "oil"=>30000, "cream"=>5000}) == 11
p cakes({"apples"=>3, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>500, "flour"=>2000, "milk"=>2000}) == 0
p cakes({"apples"=>3, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>500, "flour"=>2000, "milk"=>2000, "apples"=>15, "oil"=>20}) == 0
p cakes({"eggs"=>4, "flour"=>400},{}) == 0
p cakes({"cream"=>1, "flour"=>3, "sugar"=>1, "milk"=>1, "oil"=>1, "eggs"=>1},{"sugar"=>1, "eggs"=>1, "flour"=>3, "cream"=>1, "oil"=>1, "milk"=>1}) == 1


=end



=begin
## P: Understanding the Problem:
## E: Examples and Test Cases:
## D: Data Structures:
## A: Algorithm:
## C: Implementing a solution in Code:
=end

=begin
Write a method to find the longest common prefix string amongst an array of strings
If no common prefix, return empty string.
All given inputs are in lowercase letters a-z.

P:
-write a method that takes an array of strings and returns the longest shared leading substring


rules:
-return empty string if there is no common leading substring
-all input is lower a-z

E:
p common_prefix(%w(interspecies interstellar interstate)) == 'inters'

D:
input: array of string
return: string (leading substring)

A:
-initialize test_word to result of removing first element of input array
-iterate over each char and index of test word
  -if all elements of input array have the
  same current character at the current index
    -continue iterating
  -else
    -take slice from test word from index 0 up to current index mins 1

##review: practice coding this out using different approach
def common_prefix(array)
  test_word = array.shift
  test_word.each_char.with_index do |letter, index|
    if !array.all? { |word| word[index] == letter}
      index.zero? ? (return '') : (return test_word[0..index.pred])
    end
  end
end

p common_prefix(%w(flower flow flight)) == 'fl'
p common_prefix(%w(dog racecar car)) == ''
p common_prefix(%w(interspecies interstellar interstate)) == 'inters'
p common_prefix(%w(throne dungeon)) == ''
p common_prefix(%w(throne throne)) == 'throne'

23. Longest alphabetical substring
(https://www.codewars.com/kata/5a7f58c00025e917f30000f1)
6 kyu
Find the longest substring in alphabetical order.

Example: the longest alphabetical substring in "asdfaaaabbbbcttavvfffffdf" is
"aaaabbbbctt".

There are tests with strings up to 10 000 characters long so your code will need
to be efficient.

The input will only consist of lowercase characters and will be at least one
letter long.

If there are multiple solutions, return the one that appears first.

def longest(string)
 slices = string.chars.slice_when { |char1, char2| char1.ord > char2.ord  }.to_a
 slices.map!(&:join).max_by(&:size)
end

p longest('asd') == 'as'
p longest('nab') == 'ab'
p longest('abcdeapbcdef') == 'abcde'
p longest('asdfaaaabbbbcttavvfffffdf') == 'aaaabbbbctt'
p longest('asdfbyfgiklag') =='fgikl'
p longest('z') == 'z'
p longest('zyba') == 'z'


26. Mean Square Error
(https://www.codewars.com/kata/51edd51599a189fe7f000015/train/ruby)
Complete the function that accepts two integer arrays of equal length
compares the value each member in one array to the corresponding member in the
other
squares the absolute value difference between those two values
and returns the average of those squared absolute value difference between each
member pair.
Examples
[1, 2, 3], [4, 5, 6]              -->   9   because (9 + 9 + 9) / 3
[10, 20, 10, 2], [10, 25, 5, -2]  -->  16.5 because (0 + 25 + 25 + 16) / 4
[-1, 0], [0, -1]                  -->   1   because (1 + 1) / 2

def solution(arr1, arr2)
 squares = []
  (0...arr1.size).each do |index|
    diff = (arr1[index] - arr2[index]).abs
    squares << diff * diff
  end
  squares.sum.fdiv(squares.size)
end

p solution([1, 2, 3], [4, 5, 6]) == 9
p solution([10, 20, 10, 2], [10, 25, 5, -2]) == 16.5
p solution([-1, 0], [0, -1]) == 1

28. Where my anagrams at?
(https://www.codewars.com/kata/523a86aa4230ebb5420001e1)
5 kyu
What is an anagram? Well, two words are anagrams of each other if they both contain the same letters. For example:

'abba' & 'baab' == true

'abba' & 'bbaa' == true

'abba' & 'abbba' == false

'abba' & 'abca' == false
Write a function that will find all the anagrams of a word from a list. You will
be given two inputs a word and an array with words. You should return an array
of all the anagrams or an empty array if there are none. For example:

def anagrams(str, arr)
  arr.select { |word| word.chars.sort == str.chars.sort }
end

p anagrams('abba', ['aabb', 'abcd', 'bbaa', 'dada']) == ['aabb', 'bbaa']
p anagrams('racer', ['crazer', 'carer', 'racar', 'caers', 'racer']) == ['carer', 'racer']
p anagrams('laser', ['lazing', 'lazy',  'lacer']) == []

29. Split Strings
(https://www.codewars.com/kata/515de9ae9dcfc28eb6000001)
6 kyu
Complete the solution so that it splits the string into pairs of two characters
. If the string contains an odd number of characters then it should replace the
missing second character of the final pair with an underscore ('_').

def solution(str)
  return [] if str.empty?
  result = []
  (0...str.size).step(2) { |index| result << str[index, 2] }
  result.last << '_' if result.last.size == 1
  result
end
#alt solution:

def solution(str)
  return [] if str.empty?
  result = []
  (0...str.size).each { |index| result << str[index, 2] if index.even? }
  result.last << '_' if result.last.size == 1
  result
end

p solution('abc') == ['ab', 'c_']
p solution('abcdef') == ['ab', 'cd', 'ef']
p solution("abcdef") == ["ab", "cd", "ef"]
p solution("abcdefg") == ["ab", "cd", "ef", "g_"]
p solution("") == []


30. Anagram difference
(https://www.codewars.com/kata/5b1b27c8f60e99a467000041)
6 kyu
Given two words, how many letters do you have to remove from them to make them
anagrams?
Example
First word : c od e w ar s (4 letters removed)
Second word : ha c k er r a nk (6 letters removed)
Result : 10
Hints
A word is an anagram of another word if they have the same letters (usually in
a different order).
Do not worry about case. All inputs will be lowercase.

P:
write a method that takes 2 strings and returns an integer representing how many
letters must be removed from both strings combined to make they anagrams

rules:
-one or both input strings can be empty
-if the input strings have no corresponding letters, all letters should be removed
and empty strings are considered anagrams
-all input is lowercase
-strings may not be of equal length

E:
p anagram_difference('', '') == 0
p anagram_difference('ab', 'ba') == 0
#if sorted input strings are equal return 0

p anagram_difference('aab', 'a') == 2
str1 count 'a' -> 2
str1 count 'b'-> 1

str2 count 'a' ->1
str2 'b' -> 0

D:
input -2 strings
array of removed char
return: integer

A:
-sort and compare str1 and str1
-if equal, return 0

-create arrays of unique characters from input string
-initialize empty array of removed chars

extract to helper method:
-iterate over str1 unique chars array
  -if current letter is not included in str2
    -push letter to removed chars array
  -else
    -if count of current letter in str1 is greater than count of current letter in string 2,
      -find absolute difference between count of current letter in string 1 and string 2
        -push current letter to removed letters array number of times indicated by absolute difference
-repeat iteration for str2
-find and return size of removed hars array

def get_removed_chars(string1, string2, array)
  string1_chars = string1.chars.uniq
  string1_chars.each do |letter|
    if string1.count(letter) > string2.count(letter)
      abs_difference = string1.count(letter) - string2.count(letter)
      abs_difference.times { |num| array << letter }
    elsif !string2.include?(letter)
        array << letter
    end
    p array
  end
  array
end

def anagram_difference(str1, str2)
  return 0 if str1.chars.sort == str2.chars.sort
  removed_chars = []
  removed_chars = get_removed_chars(str1, str2, removed_chars)
  removed_chars = get_removed_chars(str2, str1, removed_chars)
  removed_chars.count
end

p anagram_difference('', '') == 0
p anagram_difference('a', '') == 1
p anagram_difference('', 'a') == 1
p anagram_difference('ab', 'a') == 1
p anagram_difference('ab', 'ba') == 0
p anagram_difference('ab', 'cd') == 4
p anagram_difference('aab', 'a') == 2
p anagram_difference('a', 'aab') == 2
p anagram_difference('codewars', 'hackerrank') == 10


31. Anagram Detection
(https://www.codewars.com/kata/529eef7a9194e0cbc1000255)
7 kyu
An anagram is the result of rearranging the letters of a word to produce a new
word (see wikipedia).

Note: anagrams are case insensitive

Complete the function to return true if the two arguments given are anagrams of
each other; return false otherwise.

Examples
"foefet" is an anagram of "toffee"

"Buckethead" is an anagram of "DeathCubeK"

def is_anagram(str1, str2)
  str1.downcase.chars.sort == str2.downcase.chars.sort
end

p is_anagram('Creative', 'Reactive') == true
p is_anagram("foefet", "toffee") == true
p is_anagram("Buckethead", "DeathCubeK") == true
p is_anagram("Twoo", "WooT") == true
p is_anagram("dumble", "bumble") == false
p is_anagram("ound", "round") == false
p is_anagram("apple", "pale") == false

32. Highest Scoring Word
(https://www.codewars.com/kata/57eb8fcdf670e99d9b000272)
6 kyu
Given a string of words, you need to find the highest scoring word.

Each letter of a word scores points according to its position in the alphabet:
a = 1, b = 2, c = 3 etc.

You need to return the highest scoring word as a string.

If two words score the same, return the word that appears earliest in the
original string.

All letters will be lowercase and all inputs will be valid.

NOTE: initially using ASCII values as letter score. Did not work -- in test case
2, instead returns "climbing" (also the only test case in which the highest-scoring)
word is not also the longest word

def high(string)
  alpha = ('a'..'z').to_a
  scores = string.split.map do |word|
         p   word.chars.map {|letter| alpha.index(letter) + 1}.sum ## initially tried converting to ASCII value in inner block - math did not work
           end
           p scores
  index = scores.index(scores.max)
  string.split[index]
end

#p high('man i need a taxi up to ubud') == 'taxi'
p high('what time are we climbing up the volcano') == 'volcano'
#p high('take me to semynak') == 'semynak'
#p high('aaa b') == 'aaa'

33. Replace With Alphabet Position
(https://www.codewars.com/kata/546f922b54af40e1e90001da)
6 kyu
In this kata you are required to, given a string, replace every letter with its position in the alphabet.

If anything in the text isn't a letter, ignore it and don't return it.

"a" = 1, "b" = 2, etc.

Example
alphabet_position("The sunset sets at twelve o' clock.")
Should return "20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12 15 3 11" (as a string)

def alphabet_position(string)
  string.downcase.gsub(/[^a-z]/, '').chars.map {|el| el.ord - 96 }.join(" ")
end

p alphabet_position("The sunset sets at twelve o' clock.") == "20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12 15 3 11"
p alphabet_position("-.-'") == ""

34. Sherlock on pockets
(https://www.codewars.com/kata/53bb1201392478fefc000746)
6 kyu
Sherlock has to find suspects on his latest case. He will use your method, dear
Watson. Suspect in this case is a person which has something not allowed in
his/her pockets.

Allowed items are defined by array of numbers.

Pockets contents are defined by map entries where key is a person and value is
one or few things represented by an array of numbers (can be nil or empty array
if empty), example:

pockets = {
  bob: [1],
  tom: [2, 5],
  jane: [7]
}

Write a method which helps Sherlock to find suspects. If no suspect is found or
there are no pockets (pockets == nil), the method should return nil.

##NOT solved - moved to PEDAC page

def find_suspects(hash, array)
  return nil if hash == nil
  result = hash.select do |name, pocket|
    pocket.any? { |num| !array.include?(num) }
  end.keys
  return nil if result.empty?
end

pockets = {
  bob: [1],
  tom: [2, 5],
  jane: [7]
}

p find_suspects(pockets, [1, 2]) == [:tom, :jane]
p find_suspects(pockets, [1, 7, 5, 2]) == nil
p find_suspects(pockets, []) == [:bob, :tom, :jane]
p find_suspects(pockets, [7]) == [:bob, :tom]

35. Mexican Wave
(https://www.codewars.com/kata/58f5c63f1e26ecda7e000029/train/ruby)
6 kyu

In this simple Kata your task is to create a function that turns a string into a
Mexican Wave. You will be passed a string and you must return that string in an
array where an uppercase letter is a person standing up.
Rules
1.  The input string will always be lower case but maybe empty.
2.  If the character in the string is whitespace then pass over it as if it was
an empty seat.

def wave(string)
  result = []
  (0...string.size).each do |index|
    next if string[index] == ' '
    result << string[0...index] + string[index].upcase + string[index.succ...string.size]
  end
  result
end

p wave("hello") == ["Hello", "hEllo", "heLlo", "helLo", "hellO"]
p wave("codewars") == ["Codewars", "cOdewars", "coDewars", "codEwars", "codeWars", "codewArs", "codewaRs", "codewarS"]
p wave("") == []
p wave("two words") == ["Two words", "tWo words", "twO words", "two Words", "two wOrds", "two woRds", "two worDs", "two wordS"]
p wave(" gap ") == [" Gap ", " gAp ", " gaP "]

36. Delete a Digit
(https://www.codewars.com/kata/5894318275f2c75695000146/train/ruby)
6 kyu
Task
Given an integer n, find the maximal number you can obtain by deleting exactly
one digit of the given number.

Example
For n = 152, the output should be 52;

For n = 1001, the output should be 101.

Input/Output
[input] integer n

Constraints: 10 ≤ n ≤ 1000000.

[output] an integer

def delete_digit(num)
  results =[]
  nums = num.digits.reverse
  (0...nums.size).each do |index|
    results << (nums[0...index] + nums[index.succ...nums.size]).join.to_i
  end
  results.max
end

p delete_digit(152) == 52
p delete_digit(1001) == 101
p delete_digit(10) == 1

37. Multiples of 3 or 5
(https://www.codewars.com/kata/514b92a657cdc65150000006/train/ruby)
6 kyu
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get
3, 5, 6 and 9. The sum of these multiples is 23.

Finish the solution so that it returns the sum of all the multiples of 3 or 5
below the number passed in.

Note: If the number is a multiple of both 3 and 5, only count it once.

def solution(num)
  multiples = []
  num.times do |number|
    multiples << number if (number % 3 == 0 || number % 5 == 0)
  end
 multiples.sum
end

p solution(10) == 23
p solution(20) == 78
p solution(200) == 9168

38. String transformer
(https://www.codewars.com/kata/5878520d52628a092f0002d0/train/ruby)
6 kyu
Given a string, return a new string that has transformed based on the input:

Change case of every character, ie. lower case to upper case, upper case to
lower case.
Reverse the order of words from the input.
Note: You will have to handle multiple spaces, and leading/trailing spaces.

For example:

"Example Input" ==> "iNPUT eXAMPLE"
You may assume the input only contain English alphabet and spaces.

###OMG finally solved. Worked this several times and would not pass codewars
test cases. I thought the appeance of spaces needed to be maintained. Instead, the
entire string needed to be reverse, so spaces as well as words appear in reverse
order

def transform_string(string)
  string = string.swapcase
  string_words = string.split(' ')
  string_slices = string.chars.reverse.slice_when {|a, b| a == ' ' || b == ' ' }.to_a
  result = string_slices.map do |slice|
  slice.include?(' ') ? slice : string_words.pop
  end
  result.join
end

p transform_string(" Example   Input ") == " iNPUT   eXAMPLE "
p transform_string("You Know  When  THAT Hotline Bling") == "bLING hOTLINE that
wHEN  kNOW yOU"

39. Largest product in a series
(https://www.codewars.com/kata/529872bdd0f550a06b00026e/train/ruby)
6 kyu
Complete the greatestProduct method so that it'll find the greatest product of
five consecutive digits in the given string of digits.

For example:

greatestProduct("123834539327238239583") // should return 3240
The input string always has more than five digits.

def greatest_product(string_num)
  slices = []
  (0..string_num.size - 5).each do |index|
   slices << string_num[index, 5]#.to_i.digits.reduce(&:*)
  end
  num_arrays = slices.map do |string|
    string.chars.map {|num| num.to_i }
  end
   num_arrays.map {|arr| arr.reduce(&:*) }.max
end

p greatest_product("123834539327238239583") == 3240
p greatest_product("395831238345393272382") == 3240
p greatest_product("92494737828244222221111111532909999") == 5292
p greatest_product("92494737828244222221111111532909999") == 5292
p greatest_product("02494037820244202221011110532909999") == 0


40. Duplicate Encoder
(https://www.codewars.com/kata/54b42f9314d9229fd6000d9c/train/ruby)
6 kyu
The goal of this exercise is to convert a string to a new string where each
character in the new string is "(" if that character appears only once in the
original string, or ")" if that character appears more than once in the original
string. Ignore capitalization when determining if a character is a duplicate.

Examples
"din"      =>  "((("
"recede"   =>  "()()()"
"Success"  =>  ")())())"
"(( @"     =>  "))(("

def duplicate_encode(string)
  string.downcase.chars.map do |el|
    string.count(el) > 1 ? ')' : '('
  end.join
end

p duplicate_encode("din") == "((("
p duplicate_encode("recede") == "()()()"
p duplicate_encode("Success") == ")())())"
p duplicate_encode("(( @") == "))(("

41. Backspaces in string
(https://www.codewars.com/kata/5727bb0fe81185ae62000ae3/train/ruby)
6 kyu
Assume "#" is like a backspace in string. This means that string "a#bc#d" actually is "bd"

Your task is to process a string with "#" symbols.

Examples
"abc#d##c"      ==>  "ac"
"abc##d######"  ==>  ""
"#######"       ==>  ""
""              ==>  ""

#$###NOT SOLVED
def clean_string(string)
 string_chars = string.chars
  result = string_chars.map.with_index do |el, idx|
  if str.size <= idx
    if el == '#'
      string[idx.pred] = ' '
      string[idx] = ' '
    else
      string[idx]
    end
      string.squeeze!(' ')
  end
end
p result
p string
end
p clean_string('abc#d##c') #== "ac"
p clean_string('abc####d##c#') == ""

42. Sort Arrays (Ignoring Case)
(https://www.codewars.com/kata/51f41fe7e8f176e70d0002b9/train/ruby)
6 kyu
Sort the given strings in alphabetical order, case insensitive. For example:

["Hello", "there", "I'm", "fine"]  -->  ["fine", "Hello", "I'm", "there"]
["C", "d", "a", "B"])              -->  ["a", "B", "C", "d"]

def sortme(arr)
  arr.sort_by {|s| s.downcase }
end
p sortme(["Hello", "there", "I'm", "fine"]) == ["fine", "Hello", "I'm", "there"]
p sortme(["C", "d", "a", "Ba", "be"]) == ["a", "Ba", "be", "C", "d"]
p sortme(["CodeWars"]) == ["CodeWars"]

43. Transform To Prime
(https://www.codewars.com/kata/5a946d9fba1bb5135100007c/train/ruby)
6 kyu
Task :
Given a List [] of n integers , find the minimum number to be inserted in a
list, so that the sum of all elements of the list should equal the closest prime
number .

Notes
List size is at least 2 .

List's numbers will only have positives (n > 0) .

Repetition of numbers in the list could occur .

The newer list's sum should equal the closest prime number .

Input >> Output Examples
1- minimumNumber ({3,1,2}) ==> return (1)
Explanation:
Since , the sum of the list's elements equal to (6) , the minimum number to be
inserted to transform the sum to prime number is (1) , which will make *the sum
of the List** equal the closest prime number (7)* .
2-  minimumNumber ({2,12,8,4,6}) ==> return (5)
Explanation:
Since , the sum of the list's elements equal to (32) , the minimum number to be
inserted to transform the sum to prime number is (5) , which will make *the sum
of the List** equal the closest prime number (37)* .
3- minimumNumber ({50,39,49,6,17,28}) ==> return (2)
Explanation:
Since , the sum of the list's elements equal to (189) , the minimum number to be
inserted to transform the sum to prime number is (2) , which will make *the sum
of the List** equal the closest prime number (191)* .

def minimum_number(array)
  sum = array.sum

  until 2.upto(sum-1).all? { |num| !(sum % num == 0) }
    sum += 1
  end
  sum - array.sum
end

p minimum_number([3,1,2]) == 1
p minimum_number([5,2]) == 0
p minimum_number([1,1,1]) == 0
p minimum_number([2,12,8,4,6]) == 5
p minimum_number([50,39,49,6,17,28]) == 2

44. Counting Duplicates
(https://www.codewars.com/kata/54bf1c2cd5b56cc47f0007a1/train/ruby)
6 kyu
Count the number of Duplicates
Write a function that will return the count of distinct case-insensitive
alphabetic characters and numeric digits that occur more than once in the input
string. The input string can be assumed to contain only alphabets (both
uppercase and lowercase) and numeric digits.

Example
"abcde" -> 0 # no characters repeats more than once
"aabbcde" -> 2 # 'a' and 'b'
"aabBcde" -> 2 # 'a' occurs twice and 'b' twice (`b` and `B`)
"indivisibility" -> 1 # 'i' occurs six times
"Indivisibilities" -> 2 # 'i' occurs seven times and 's' occurs twice
"aA11" -> 2 # 'a' and '1'
"ABBA" -> 2 # 'A' and 'B' each occur twice

def duplicate_count(string)
  hash = Hash.new(0)
  string.downcase.chars.uniq.each do |el|
    hash[el] = string.downcase.count(el)
  end
  hash.values.select { |v| v > 1 }.size
end

#codewars solution:
def duplicate_count(text)
  ('a'..'z').count { |c| text.downcase.count(c) > 1 }
end


p duplicate_count("") == 0
p duplicate_count("abcde") == 0
p duplicate_count("abcdeaa") == 1
p duplicate_count("abcdeaB") == 2
p duplicate_count("Indivisibilities") == 2

45. Alphabetized
(https://www.codewars.com/kata/5970df092ef474680a0000c9/train/ruby)
6 kyu
The alphabetized kata
Re-order the characters of a string, so that they are concatenated into a new
string in "case-insensitively-alphabetical-order-of-appearance" order.
Whitespace and punctuation shall simply be removed!

The input is restricted to contain no numerals and only words containing the
english alphabet letters.

Example:

alphabetized("The Holy Bible") # "BbeehHilloTy"

def alphabetized(string)
  string.gsub(/[^a-zA-Z]/, '').chars.sort_by { |el| el.downcase }.join
end

p alphabetized("") == ""
p alphabetized(" ") == ""
p alphabetized(" a") == "a"
p alphabetized("a ") == "a"
p alphabetized(" a ") == "a"
p alphabetized("A b B a") == "AabB"
p alphabetized(" a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z") == "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ"

46. Sum of Digits / Digital Root
(https://www.codewars.com/kata/541c8630095125aba6000c00/train/ruby)
6 kyu
In this kata, you must create a digital root function.

A digital root is the recursive sum of all the digits in a number. Given n, take
the sum of the digits of n. If that value has more than one digit, continue
reducing in this way until a single-digit number is produced. This is only
applicable to the natural numbers.

Here's how it works:

digital_root(16)
=> 1 + 6
=> 7

digital_root(942)
=> 9 + 4 + 2
=> 15 ...
=> 1 + 5
=> 6

digital_root(132189)
=> 1 + 3 + 2 + 1 + 8 + 9
=> 24 ...
=> 2 + 4
=> 6

digital_root(493193)
=> 4 + 9 + 3 + 1 + 9 + 3
=> 29 ...
=> 2 + 9
=> 11 ...
=> 1 + 1
=> 2

def digital_root(n)
  until n.digits.size == 1
    n = n.digits.sum
  end
    n
end

#codewars solution uses recursion:
def digital_root(n)
  n < 10 ? n : digital_root(n.digits.sum)
end

p digital_root(16) == 7
p digital_root(456) == 6

47. Array.diff
(https://www.codewars.com/kata/523f5d21c841566fde000009/train/ruby)
6 kyu
Your goal in this kata is to implement a difference function, which subtracts
one list from another and returns the result.

It should remove all values from list a, which are present in list b.

array_diff([1,2],[1]) == [2]
If a value is present in b, all of its occurrences must be removed from the other:

array_diff([1,2],[1]) == [2]

def array_diff(arr1, arr2)
  arr1 - arr2
end

p array_diff([1,2], [1]) == [2]
p array_diff([1,2,2], [1]) == [2,2]
p array_diff([1,2,2], [2]) == [1]
p array_diff([1,2,2], []) == [1,2,2]
p array_diff([], [1,2]) == []


48. Where is my parent!?(cry)
(https://www.codewars.com/kata/58539230879867a8cd00011c/train/ruby )
Where's my parent?
6 kyu
Mothers arranged a dance party for the children in school. At that party, there
are only mothers and their children. All are having great fun on the dance floor
when suddenly all the lights went out. It's a dark night and no one can see each
other. But you were flying nearby and you can see in the dark and have ability
to teleport people anywhere you want.

Legend:
-Uppercase letters stands for mothers, lowercase stand for their children, i.e.
"A" mother's children are "aaaa".
-Function input: String contains only letters, uppercase letters are unique.
Task:
Place all people in alphabetical order where Mothers are followed by their
children, i.e. "aAbaBb" => "AaaBbb".

def find_children(string)
 string.chars.sort.sort_by(&:downcase).join
end

#common ocdewars solution: not sure what is happening here
def find_children(dancers)
  dancers.chars.sort_by{ |c| [c.downcase, c]}.join
end

p find_children("abBA") == "AaBb"
p find_children("AaaaaZazzz") == "AaaaaaZzzz"
p find_children("CbcBcbaA") == "AaBbbCcc"
p find_children("xXfuUuuF") == "FfUuuuXx"
p find_children("") == ""

####NOT solved
49. Playing with digits
(https://www.codewars.com/kata/5552101f47fc5178b1000050/train/ruby)
6 kyu
Some numbers have funny properties. For example:

89 --> 8¹ + 9² = 89 * 1

695 --> 6² + 9³ + 5⁴= 1390 = 695 * 2

46288 --> 4³ + 6⁴+ 2⁵ + 8⁶ + 8⁷ = 2360688 = 46288 * 51

Given a positive integer n written as abcd... (a, b, c, d... being digits) and a
positive integer p

we want to find a positive integer k, if it exists, such as the sum of the
digits of n taken to the successive powers of p is equal to k * n.
In other words:

Is there an integer k such as : (a ^ p + b ^ (p+1) + c ^(p+2) + d ^ (p+3) + ...)
= n * k

If it is the case we will return k, if not return -1.

Note: n and p will always be given as strictly positive integers.

dig_pow(89, 1) should return 1 since 8¹ + 9² = 89 = 89 * 1
dig_pow(92, 1) should return -1 since there is no k such as 9¹ + 2² equals 92 * k
dig_pow(695, 2) should return 2 since 6² + 9³ + 5⁴= 1390 = 695 * 2
dig_pow(46288, 3) should return 51 since 4³ + 6⁴+ 2⁵ + 8⁶ + 8⁷ = 2360688 = 46288 * 5

p dig_pow(89, 1) == 1
p dig_pow(92, 1) == -1
p dig_pow(46288, 3) == 51
p dig_pow(695, 2) == 2

50. Equal Sides Of An Array
(https://www.codewars.com/kata/5679aa472b8f57fb8c000047/train/ruby)
Equal sides of an array
6 kyu
You are going to be given an array of integers. Your job is to take that array
and find an index N where the sum of the integers to the left of N is equal to
the sum of the integers to the right of N. If there is no index that would make
this happen, return -1.

For example:

Let's say you are given the array {1,2,3,4,3,2,1}: Your function will return the
index 3, because at the 3rd position of the array, the sum of left side of the
index ({1,2,3}) and the sum of the right side of the index ({3,2,1}) both equal
6.

Let's look at another one.
You are given the array {1,100,50,-51,1,1}: Your function will return the index
1, because at the 1st position of the array, the sum of left side of the index
({1}) and the sum of the right side of the index ({50,-51,1,1}) both equal 1.

Last one:
You are given the array {20,10,-80,10,10,15,35}
At index 0 the left side is {}
The right side is {10,-80,10,10,15,35}
They both are equal to 0 when added. (Empty arrays are equal to 0 in this
problem)
Index 0 is the place where the left side and right side are equal.

Note: Please remember that in most programming/scripting languages the index of
an array starts at 0.

Input:
An integer array of length 0 < arr < 1000. The numbers in the array can be any
integer positive or negative.

Output:
The lowest index N where the side to the left of N is equal to the side to the
right of N. If you do not find an index that fits these rules, then you will
return -1.

Note:
If you are given an array with multiple answers, return the lowest correct index.

def find_even_index(arr)
  (0...arr.size).each do |index|
    return index if arr[0...index].sum == arr[index.succ...arr.size].sum
  end
  return -1
end

p find_even_index([1,2,3,4,3,2,1]) == 3
p find_even_index([1,100,50,-51,1,1]) == 1
p find_even_index([1,2,3,4,5,6]) == -1
p find_even_index([20,10,30,10,10,15,35]) == 3
p find_even_index([20,10,-80,10,10,15,35]) == 0
p find_even_index([10,-80,10,10,15,35,20]) == 6
p find_even_index(Array(1..100)) == -1
p find_even_index([0,0,0,0,0]) == 0
p find_even_index([-1,-2,-3,-4,-3,-2,-1]) == 3
p find_even_index(Array(-100..-1)) == -1


51. Reverse or rotate?
(https://www.codewars.com/kata/56b5afb4ed1f6d5fb0000991)
6 kyu
Reverse or rotate?
The input is a string str of digits. Cut the string into chunks (a chunk here is
a substring of the initial string) of size sz (ignore the last chunk if its size
is less than sz).

If a chunk represents an integer such as the sum of the cubes of its digits is
divisible by 2, reverse that chunk; otherwise rotate it to the left by one
position. Put together these modified chunks and return the result as a string.

If sz is <= 0 or if str is empty return ""
sz is greater (>) than the length of str it is impossible to take a chunk of
size sz hence return "".
Examples:
revrot("123456987654", 6) --> "234561876549"
revrot("123456987653", 6) --> "234561356789"
revrot("66443875", 4) --> "44668753"
revrot("66443875", 8) --> "64438756"
revrot("664438769", 8) --> "67834466"
revrot("123456779", 8) --> "23456771"
revrot("", 8) --> ""
revrot("123456779", 0) --> ""
revrot("563000655734469485", 4) --> "0365065073456944"

##NOT SOLVED HERE
def revrot(string, size)
  return "" if (size == 0 || string.empty? || size > string.size)
  slices = []
  (0..string.size - size).each do |index|
    slices << string[index, size]
  end
  digit_arrays = slices.map { |slice| slice.chars.map(&:to_i) }
  cubed_sums = digit_arrays.map { |arr| arr.map { |num| num * num * num }.sum }
  cubed_sums.map { |sum| sum %  2 == 0 ? sum.to_s.reverse : sum.to_s[1..-1] + sum.to_s[0] }
end

p revrot("1234", 0) == ""
p revrot("", 0) == ""
p revrot("1234", 5) == ""
p revrot("733049910872815764", 5) == "330479108928157"
p revrot("123456987654", 6) == "234561876549"
p revrot("123456987653", 6) == "234561356789"
p revrot("66443875", 4) == "44668753"
p revrot("66443875", 8) == "64438756"
p revrot("664438769", 8) == "67834466"
p revrot("123456779", 8) == "23456771"
p revrot("", 8) == ""
p revrot("123456779", 0) == ""
p revrot("563000655734469485", 4) == "0365065073456944"


51. Decipher this!
https://www.codewars.com/kata/581e014b55f2c52bb00000f8
Decipher this!
6 kyu
You are given a secret message you need to decipher. Here are the things you
need to know to decipher it:

For each word:

the second and the last letter is switched (e.g. Hello becomes Holle)
the first letter is replaced by its character code (e.g. H becomes 72)
Note: there are no special characters used, only letters and spaces

Examples

decipherThis('72olle 103doo 100ya'); // 'Hello good day'
decipherThis('82yade 115te 103o'); // 'Ready set go'

def decipher_this(string)
  string_nums = ('0'..'9').to_a

  num_split = string.chars.slice_when do |a, b|
    (string_nums.include?(a) && !string_nums.include?(b)) || (string_nums.include?(b) && !string_nums.include?(a))
    end.to_a

  a = num_split.map do |arr|
    if arr.all? {|num| string_nums.include?(num) }
     arr.join.to_i.chr
    else
      arr.join
    end
  end.join

  result = a.split.map do |word|
    if word.size > 2
    #  word[1], word[-1] =
      word[0] + word[-1] + word[2..-2] + word[1]
    else
      word
    end
  end.join(' ')
    p result

end
p decipher_this("65 119esi 111dl 111lw 108dvei 105n 97n 111ka") == "A wise old owl lived in an oak"
p decipher_this("84eh 109ero 104e 115wa 116eh 108sse 104e 115eokp") == "The more he saw the less he spoke"
p decipher_this("84eh 108sse 104e 115eokp 116eh 109ero 104e 104dare") == "The less he spoke the more he heard"
p decipher_this("87yh 99na 119e 110to 97ll 98e 108eki 116tah 119esi 111dl 98dri") == "Why can we not all be like that wise old bird"
p decipher_this("84kanh 121uo 80roti 102ro 97ll 121ruo 104ple") == "Thank you Piotr for all your help"

52. Bouncing Balls
(https://www.codewars.com/kata/5544c7a5cb454edb3c000047)
6 kyu
A child is playing with a ball on the nth floor of a tall building. The height of this floor, h, is known.

He drops the ball out of the window. The ball bounces (for example), to two-thirds of its height (a bounce of 0.66).

His mother looks out of a window 1.5 meters from the ground.

How many times will the mother see the ball pass in front of her window (including when it's falling and bouncing?

Three conditions must be met for a valid experiment:
Float parameter "h" in meters must be greater than 0
Float parameter "bounce" must be greater than 0 and less than 1
Float parameter "window" must be less than h.
If all three conditions above are fulfilled, return a positive integer, otherwise return -1.

Note:
The ball can only be seen if the height of the rebounding ball is strictly greater than the window parameter.

Example:
- h = 3, bounce = 0.66, window = 1.5, result is 3

- h = 3, bounce = 1, window = 1.5, result is -1
(Condition 2) not fulfilled).

p bouncingBall(3, 0.66, 1.5) == 3
p bouncingBall(30, 0.66, 1.5) == 15
p bouncingBall(30, 0.75, 1.5) == 21
p bouncingBall(30, 0.4, 10) == 3
p bouncingBall(40, 1, 10) == -1
p bouncingBall(-5, 0.66, 1.5) == -1
p bouncingBall(1, 0.66, 0.66) == 1
p bouncingBall(1, 0.66, 1) == -1


53. WeIrD StRiNg CaSe
(https://www.codewars.com/kata/52b757663a95b11b3d00062d)
6 kyu
Write a function toWeirdCase (weirdcase in Ruby) that accepts a string, and
returns the same string with all even indexed characters in each word upper
cased, and all odd indexed characters in each word lower cased. The indexing
just explained is zero based, so the zero-ith index is even, therefore that
character should be upper cased.

The passed in string will only consist of alphabetical characters and
spaces(' '). Spaces will only be present if there are multiple words. Words
will be separated by a single space(' ').

def weirdcase(string)
  result = string.split.map do |word|
    word.chars.map.with_index do |el, index|
      index.even? ? el.upcase : el.downcase
    end.join
  end
   result.size > 1 ? result.join : result.join(' ')
end

p weirdcase( "String" ) == "StRiNg"
p weirdcase( "Weird string case" ) #== "WeIrD StRiNg CaSe"

54. Are they the "same"?
(https://www.codewars.com/kata/550498447451fbbd7600041c)
6 kyu
Given two arrays a and b write a function comp(a, b) that checks whether the two
arrays have the "same" elements, with the same multiplicities. "Same" means,
here, that the elements in b are the elements in a squared, regardless of the order.

Examples
Valid arrays
a = [121, 144, 19, 161, 19, 144, 19, 11]
b = [121, 14641, 20736, 361, 25921, 361, 20736, 361]
comp(a, b) returns true because in b 121 is the square of 11, 14641 is the
square of 121, 20736 the square of 144, 361 the square of 19, 25921 the square
of 161, and so on. It gets obvious if we write b's elements in terms of squares:

a = [121, 144, 19, 161, 19, 144, 19, 11]
b = [11*11, 121*121, 144*144, 19*19, 161*161, 19*19, 144*144, 19*19]
Invalid arrays
If we change the first number to something else, comp may not return true anymore:

a = [121, 144, 19, 161, 19, 144, 19, 11]
b = [132, 14641, 20736, 361, 25921, 361, 20736, 361]
comp(a,b) returns false because in b 132 is not the square of any number of a.

a = [121, 144, 19, 161, 19, 144, 19, 11]
b = [121, 14641, 20736, 36100, 25921, 361, 20736, 361]
comp(a,b) returns false because in b 36100 is not the square of any number of a.

Remarks
a or b might be [] (all languages except R, Shell).
a or b might be nil or null or None or nothing (except in Haskell, Elixir, C++, Rust, R, Shell, PureScript).
If a or b are nil (or null or None), the problem doesn't make sense so return false.

Note for C
The two arrays have the same size (> 0) given as parameter in function comp.

def comp(a1, a2)
  return false if a1.nil? || a2.nil? || a1.empty? || a2.empty?
  a1.map {|el| el*el}.sort == a2.sort
end

p comp([121, 144, 19, 161, 19, 144, 19, 11], [121, 14641, 20736, 361, 25921, 361, 20736, 361]) #== true
p comp([121, 144, 19, 161, 19, 144, 19, 11] , [132, 14641, 20736, 361, 25921, 361, 20736, 361]) == false
p comp(nil, [1, 2, 3]) == false
p comp([1, 2], []) == false
p comp([1, 2], [1, 4, 4]) == false

55. Grouping and Counting
(https://www.codewars.com/kata/53a452dd0064085711001205)
6 kyu
Your goal is to write the group_and_count method, which should receive an array
as a unique parameter and return a hash. Empty or nil input must return nil
instead of a hash. This hash returned must contain as keys the unique values of
the array, and as values the counting of each value.

Example usage:

input = [1,1,2,2,2,3]

group_and_count(input)# == {1=>2, 2=>3, 3=>1}
The following methods were disabled:

Array#count
Array#length

def group_and_count(arr)
  return nil if arr.nil? || arr.empty?
  hash = Hash.new(0)
  arr.each { |num| hash[num] += 1 }
  hash
end

p group_and_count([1,1,2,2,2,3]) == {1=>2, 2=>3, 3=>1}
p group_and_count([]) == nil
p group_and_count(nil) == nil
p group_and_count([1, 7, 5, -1]) == {1=>1, 7=>1, 5=>1, -1=>1}

56. Find the Nexus of the Codewars Universe
(https://www.codewars.com/kata/5453dce502949307cf000bff)
6 kyu
Not to brag, but I recently became the nexus of the Codewars universe! My honor
and my rank were the same number. I cried a little.

Complete the method that takes a hash/object/directory/association list of
users, and find the nexus: the user whose rank is the closest is equal to his
honor. Return the rank of this user. For each user, the key is the rank and the
value is the honor.

If nobody has an exact rank/honor match, return the rank of the user who comes
closest. If there are several users who come closest, return the one with the
lowest rank (numeric value). The hash will not necessarily contain consecutive
rank numbers; return the best match from the ranks provided.

Example
         rank    honor
users = {  1  =>  93,
          10  =>  55,
          15  =>  30,
          20  =>  19,    <--- nexus
          23  =>  11,
          30  =>   2 }

def nexus(hash)
  differences = []
  hash.sort_by { |k, v| k }.to_h
  hash.each do |rank, honor|
    differences << (rank - honor).abs
                end
  winner = differences.index(differences.min)
  hash.keys[winner]
end

#codewars solution:
def nexus(users)
  users.min_by{ |rank, honor| [(rank - honor).abs, rank] }[0]
end

p nexus({1 => 3, 5 => 1, 3 => 3}) == 3
p nexus({1 => 10, 2 => 6, 3 => 4, 5 => 1}) == 3
p nexus({1 => 10, 2 => 3, 3 => 4, 5 => 1}) == 2


57. Count letters in string
(https://www.codewars.com/kata/5808ff71c7cfa1c6aa00006d)
6 kyu
In this kata, you've to count lowercase letters in a given string and return the
letter count in a hash with 'letter' as key and count as 'value'. The key must
be 'symbol' instead of string in Ruby and 'char' instead of string in Crystal.

def letter_count(string)
  hash = Hash.new(0)
  string.chars.each do |el|
    hash[el.to_sym] += 1
  end
 p hash
end

p letter_count('arithmetics') ==  {:a=>1, :c=>1, :e=>1, :h=>1, :i=>2, :m=>1, :r=>1, :s=>1, :t=>2}

58. Triple trouble
(https://www.codewars.com/kata/55d5434f269c0c3f1b000058)
6 kyu
Write a function

triple_double(num1, num2)
which takes numbers num1 and num2 and returns 1 if there is a straight triple
of a number at any place in num1 and also a straight double of the same number
in num2.

If this isn't the case, return 0

Examples
triple_double(451999277, 41177722899) == 1
# num1 has straight triple 999s and  num2 has straight double 99s

triple_double(1222345, 12345) == 0
# num1 has straight triple 2s but num2 has only a single 2

P:
write a method that takes 2 input integers and identifies whetehr the first
number contains a digit consecutively repeated three times and the second number
contains that same digit consecutively repeated 2 times. return 1 if true and 0
if false.

rules:
-assume valid input
-method should return one if the same number appears consecutively 3 times in
first number and 2 twice in the second
-return 1 or 0 for true or false

E:
triple_double(12345, 12345) == 0

D:
input: 2 integers
-arrays of slices taken from both input integers
return: integer (1  or 0)

A:
Option 1
-get substrings with length 3 from first number and 2 from second
-select substrings that contain all of the same number
-compare selected subtrings from both input numbers and check if any include the
same number

Option 2
-get slice of input numbers at char place where 2 characters are different
-check array of substrings with length of 3 or 2
-compare str1[0..1] = str2

A:
-convert both input integers to a string and then to an array of characters
-iterate over both number arrays separately
  -take slice of string at each place that char1 is not equal to char2
-perform selection on return slice arrays
  -for arr1, select substrings with a length of 3
  -arr2, select substrings that have a length of 2
-flatten doubles and triples and get unique chars
-iterate over triples and cehck if any element is included in triples

XXX-iterate over arr1
  -for each substring, check if the first 2 chars of any substring are equal to
  a substring in arr2
  -if true, return 1
-if iteration completes, return 0

def triple_double(num1, num2)
  num1_strings = num1.to_s.chars
  num2_strings = num2.to_s.chars
  num1_slices = num1_strings.slice_when {|el1, el2| el1 != el2 }.to_a
  num2_slices = num2_strings.slice_when { |el1, el2| el1 != el2}.to_a
  num1_triples = num1_slices.select { |arr| arr.size == 3 }
  num2_doubles = num2_slices.select { |arr| arr.size == 2 }
  triple_digits = num1_triples.flatten.uniq
  double_digits = num2_doubles.flatten.uniq
  triple_digits.any? { |num| double_digits.include?(num) } ? 1 : 0
end

p triple_double(12345, 12345) == 0
p triple_double(666789, 12345667) == 1

def triple_double(num1, num2)

  num1_slices = num1.to_s.chars.slice_when {|el1, el2| el1 != el2 }.to_a
  num2_slices = num2.to_s.chars.slice_when { |el1, el2| el1 != el2}.to_a

  triples = num1_slices.select { |arr| arr.size == 3 }.flatten.uniq
  doubles = num2_slices.select { |arr| arr.size == 2 }.flatten.uniq

  triples.any? { |num| doubles.include?(num) } ? 1 : 0
end

p triple_double(12345, 12345) == 0
p triple_double(666789, 12345667) == 1

59. Which are in?
(https://www.codewars.com/kata/550554fd08b86f84fe000a58)
6 kyu
Given two arrays of strings a1 and a2 return a sorted array r in lexicographical
order of the strings of a1 which are substrings of strings of a2.

#Example 1: a1 = ["arp", "live", "strong"]

a2 = ["lively", "alive", "harp", "sharp", "armstrong"]

returns ["arp", "live", "strong"]

#Example 2: a1 = ["tarp", "mice", "bull"]

a2 = ["lively", "alive", "harp", "sharp", "armstrong"]

returns []

Notes:
Arrays are written in "general" notation. See "Your Test Cases" for examples in
your language.

In Shell bash a1 and a2 are strings. The return is a string where words are
separated by commas.

Beware: r must be without duplicates.
Don't mutate the inputs.

P:
write a method that takes 2 arrays of strings and returns an array holding the
elements of the first array that are included as elements in the second array

rules:
-select and return elements fromthe first array as a new array
-do not mutate input arrays
-if no elements in first array appear as substrings in the second array, return empty array
-assume input array string only include lowercase letters

###forgot to sort

E:
a1 = ["arp", "live", "strong"]
a2 = ["lively", "alive", "harp", "sharp", "armstrong"]
in_array(a1, a2) == ["arp", "live", "strong"]

a1 = ["tarp", "mice", "bull"]
a2 = ["lively", "alive", "harp", "sharp", "armstrong"]
in_array(a1, a2) == []

D:
input: 2 arrays (of strings)
return: array (empty or seletced strings from arr1)

A:
-iterate over a1, performing selection
  -iterate over a2
    -check if current a1 string is included in any a2 string
-return the array returned by selection

def in_array(a1, a2)
  a1.select do |substring|
    a2.any? { |word| word.include?(substring) }
  end.sort #forgot to sort until I submitted to codewars
end

a1 = ["arp", "live", "strong"]
a2 = ["lively", "alive", "harp", "sharp", "armstrong"]
p in_array(a1, a2) == ["arp", "live", "strong"]

a1 = ["tarp", "mice", "bull"]
p in_array(a1, a2) == []

60. Format a string of names like 'Bart, Lisa & Maggie'.
(https://www.codewars.com/kata/53368a47e38700bd8300030d2)
6 kyu
Given: an array containing hashes of names

Return: a string formatted as a list of names separated by commas except for the
last two names, which should be separated by an ampersand.

Example:

list([ {name: 'Bart'}, {name: 'Lisa'}, {name: 'Maggie'} ])
# returns 'Bart, Lisa & Maggie'

list([ {name: 'Bart'}, {name: 'Lisa'} ])
# returns 'Bart & Lisa'

list([ {name: 'Bart'} ])
# returns 'Bart'

list([])
# returns ''
Note: all the hashes are pre-validated and will only contain A-Z, a-z, '-' and '.'.

P
write a method that takes an array of hashes and  returns the hash values as a
single string joined with correct formatting

rules:
-input array contains hashes as elements
-extract the value from each hash
  -when 1 value, return string
  -when 2 values, return string joined with &
  -when 3 values, join last 2 with & and then join to remaining elements with ,
-strings will only contain a-a, A-Z, - .
-input can be an empty array -> return empty string

E:
list([{name: 'Bart'},{name: 'Lisa'},{name: 'Maggie'},{name: 'Homer'},{name: 'Marge'}]) == 'Bart, Lisa, Maggie, Homer & Marge'

D:
input: array (with hash elements)
-array of string/names
return: string (can be empty)

A:
-iterate over input array, performing transformation
  -access and return the hash value
-set up control flow for name_array
  -if size is 1
    -return first element of name array
  -if size is 2
    -join with ' & ' and return
  -if size 3 >=
    take slice of last 2 elements in array
    -join slice with ' & ' (last_slice)
    -join array from beginning index up to index -3 and concatenate it to last_slice
    -join all elements with ,

### forgot to return '' for empty array
def list(array)
  return '' if array.empty?
  names_array = array.map do |hash|
    hash.map { |_, name| name }
  end.flatten

  case names_array.size
  when 1 then names_array[0]
  when 2 then names_array.join(' & ')
  else
   last_slice = names_array[-2..-1].join(' & ')
   (names_array[0..-3] << last_slice).join(', ')
  end
end

p list([{name: 'Bart'},{name: 'Lisa'},{name: 'Maggie'},{name: 'Homer'},{name: 'Marge'}]) == 'Bart, Lisa, Maggie, Homer & Marge'
#"Must work with many names"
p list([{name: 'Bart'},{name: 'Lisa'}]) == 'Bart & Lisa'
 #"Must work with two names")
p list([{name: 'Bart'}]) == 'Bart' #Wrong output for a single name")

61. Find the missing letter
(https://www.codewars.com/kata/5839edaa6754d6fec10000a2)
6 kyu
#Find the missing letter

Write a method that takes an array of consecutive (increasing) letters as input
and that returns the missing letter in the array.

You will always get an valid array. And it will be always exactly one letter be
missing. The length of the array will always be at least 2.
The array will always contain letters in only one case.

Example:

['a','b','c','d','f'] -> 'e' ['O','Q','R','S'] -> 'P'

["a","b","c","d","f"] -> "e"
["O","Q","R","S"] -> "P"
(Use the English alphabet with 26 letters!)

Have fun coding it and please don't forget to vote and rank this kata! :-)

I have also created other katas. Take a look if you enjoyed this kata!

P:
write a method that takes an array of letters and identify which letter is missing
to make the array consecutive

rules:
-assume valid input (array length will be at least 2 )
-array elements can be uppercase or lowercase
-return missin gletter in correct case

E:
["a","b","c","d","f"] == 'e'

D:
input: array (with individual letters as string elements)
return: string (single letter)

A:
-initialzie result to an empty string
-iterate over indices of input array from 0 to input array size minus 2
  -use index reference to access input array elemnet at current index and at the next index
  -convert both element to ascii values
  -check if current element's value + 1 is equal to next element
  -if not equal, take ascii value of current element + 1, convert to character,
  and push to result string
-return result

def find_missing_letter(array)
  result = ''
  (0..array.size - 2).each do |index|
    if !(array[index].ord + 1 == array[index.succ].ord)
      result << (array[index].ord + 1).chr
    end
  end
  result
end

p find_missing_letter(["a","b","c","d","f"]) == "e"
p find_missing_letter(["O","Q","R","S"]) == "P"
p find_missing_letter(["b","d"]) == "c"
p find_missing_letter(["a","b","d"]) == "c"
p find_missing_letter(["b","d","e"]) == "c"

62. Who likes it?
(https://www.codewars.com/kata/5266876b8f4bf2da9b000362)
6 kyu
You probably know the "like" system from Facebook and other pages. People can
"like" blog posts, pictures or other items. We want to create the text that
should be displayed next to such an item.

Implement a function likes :: [String] -> String, which must take in input
array, containing the names of people who like an item. It must return the
display text as shown in the examples:

likes [] // must be "no one likes this"
likes ["Peter"] // must be "Peter likes this"
likes ["Jacob", "Alex"] // must be "Jacob and Alex like this"
likes ["Max", "John", "Mark"] // must be "Max, John and Mark like this"
likes ["Alex", "Jacob", "Mark", "Max"] // must be "Alex, Jacob and 2 others like this"

P:
write a method that takes an array of strings and returns a single string with
the string elements from the array interpolated

rules:
-input array can be empty or return an unknown number of elements
- if input array is empty, return "no one likes this"
-if input array hash size of 1
  -interpolate name
-if input array has size of 2
  -interpolate names separated by 'and'
if size of 3,
  -join last 2 names with 'and' and join to first separated by comma
-if size if greater than 3
  -join first 2 names with comma
  -find count of remaing names (names_array.size - 2)
  -join count to previous names with 'and' and concatenate to rest of given string

E:
likes ["Alex", "Jacob", "Mark", "Max"] // must be "Alex, Jacob and 2 others like this"
likes ["Max", "John", "Mark"] // must be "Max, John and Mark like this"

D:
input: array (of strings)
return: string

A:
-if input array is empty, return: "no one likes this"
-find size of input string and save as name_count
- initialize control flow structure to determine output based on name_count
  -if 1
    -concatenate first element of the name array to: "likes this"
  -if 2
    -interpolate first and second elements into: "XX and XX like this"
  -if 3
    --interpolate first, second, and third elements into: "XX, XX and XX like this"
  -if 4 or more
    -interpolate first 2 names with comma and array size - 2 int given string

def likes(array)
  return "no one likes this" if array.empty?
  name_count = array.size

  case name_count
  when 1 then "#{array[0]} likes this"
  when 2 then "#{array[0]} and #{array[1]} like this"
  when 3 then "#{array[0]}, #{array[1]} and #{array[2]} like this"
  else
    "#{array[0]}, #{array[1]} and #{array.size - 2} others like this"
  end
end

p likes(["Alex", "Jacob", "Mark", "Max"]) == "Alex, Jacob and 2 others like this"
p likes(["Max", "John", "Mark"]) == "Max, John and Mark like this"

63. Find The Parity Outlier
(https://www.codewars.com/kata/5526fc09a1bbd946250002dc)
6 kyu
You are given an array (which will have a length of at least 3, but could be
very large) containing integers. The array is either entirely comprised of odd
integers or entirely comprised of even integers except for a single integer N.
Write a method that takes the array as an argument and returns this "outlier" N.

Examples
[2, 4, 0, 100, 4, 11, 2602, 36]
Should return: 11 (the only odd number)

[160, 3, 1719, 19, 11, 13, -21]
Should return: 160 (the only even number)


P:
write a method that takes an array of integers and returns the single integer
that is either the only odd or only even number in the array

rules:
-input array will have at least 3 numbers
-all expect 1 number will be even or odd

E:
[2, 4, 0, 100, 4, 11, 2602, 36]
Should return: 11 (the only odd number)

[160, 3, 1719, 19, 11, 13, -21]
Should return: 160 (the only even number)

D:
input; array (of integer)
return: integer (selected from input array)

A:
*-split the input array into 2 smaller arrays (of even and odd numbers) and
  return whichever has a size of 1
-find the count of odd and even numbers; count of 1 indicates whether an even or
  odd number; select and return array element indicated by count

-split input array into 2 smaller arrays holding only even elements or only odd
  -elements
-check one of these array for a size of 1
  -if size is 1, return first element of this array
  -else, return first element of the other array

def find_outlier(array)
  odd_nums, even_nums = array.partition { |num| num.odd? }
  odd_nums.size == 1 ? odd_nums[0] : even_nums[0]
end

p find_outlier([0, 1, 2]) == 1
p find_outlier([1, 2, 3]) == 2


64. Is Integer Array?
(https://www.codewars.com/kata/52a112d9488f506ae7000b95)
6 kyu
Write a function with the signature shown below:

def is_int_array(arr)
  true
end
returns true / True if every element in an array is an integer or a float with no decimals.
returns true / True if array is empty.
returns false / False for every other input.

P:
write a method that takes an array and return true only if all array elements
are integers or floats with 0 in the decimals place

rules:
-input array can be empty and should return true
-array elements can be positive or negative

E:
is_int_array([]) == true
is_int_array([1, 2, nil]) == false
is_int_array(["-1"]) == false
is_int_array([1.0, 2.0, 3.0001]) == false

D:
input: array (of unknown elements)
return: boolean

A:
-return false if input is nil or an ampty array
-iterate over input array
  -compare value of element to that element converted to a string and back to an array
  -return true from the method if all comparisions evaluate to true

def is_int_array(array)
  return false if array.class != Array
  return true if array.empty?
  array.all? { |el| el == el.to_s.to_i }
end

p is_int_array([1, 2, 3, 4]) == true
p is_int_array("") == false
p is_int_array([]) == true
p is_int_array([nil]) == false
p is_int_array([-11, -12, -13, -14]) == true
p is_int_array([1.0, 2.0, 3.0]) == true
p is_int_array([1.0, 2.0, 3.0]) == true
p is_int_array([1, 2, nil]) == false
p is_int_array(nil) == false
p is_int_array([1.0, 2.0, 3.0001]) == false
p is_int_array(["-1"]) == false


65. Reversing and Combining Text
(https://www.codewars.com/kata/56b861671d36bb0aa8000819/train/ruby)

Your task is to Reverse and Combine Words.

Input: String containing different "words" separated by spaces

1. More than one word? Reverse each word and combine first with second, third
with fourth and so on...
  (odd number of words => last one stays alone, but has to be reversed too)
2. Start it again until there's only one word without spaces
3. Return your result…

P:
write a method that taks a string of space-separated word. reverse each word and
combine every 2 words (expect for last in odd-sized arrays). repeat until no
spaces/ only 1 string are left and return string

rules:
-if string has odd number of words, reverse bu do not join final word
-input can contain letters, numbers, spaces
-if input contains no space, return without reversing

E:
p reverse_and_combine_text("abc def") == "cbafed"
["abc", "def"] -> ['cba', 'fed'] -> 'cbafed'
("234hh5453455sdfqwzrtrtteetrthjhjhlllll1244") == "trzwqfdstrteettr45hh4325543544hjhjh21lllll"

D:
input: string
-array of words from string
return: string (with no spaces)

##PAUSED -> return adn return with a loop. Then try refactoring.
A:
-split input string at spaces ->  array of words
-if array size is 1, return input string
-iterate over indices from 0 up to array size, exclusive
    -if current index is even
      -reverse element at current index and next index
      -concatenate and push to new arrays

p reverse_and_combine_text("abc def") == "cbafed"
p reverse_and_combine_text("abc def ghi jkl") == "defabcjklghi"
p reverse_and_combine_text("dfghrtcbafed") == "dfghrtcbafed"
p reverse_and_combine_text("234hh54 53455 sdfqwzrt rtteetrt hjhjh lllll12  44") == "trzwqfdstrteettr45hh4325543544hjhjh21lllll"
p reverse_and_combine_text("sdfsdf wee sdffg 342234 ftt") == "gffds432243fdsfdseewttf"


##retrying anagram difference
Given two words, how many letters do you have to remove from them to make them anagrams?
Example
First word : c od e w ar s (4 letters removed)
Second word : ha c k er r a nk (6 letters removed)
Result : 10
Hints
A word is an anagram of another word if they have the same letters (usually in a different order).
Do not worry about case. All inputs will be lowercase.

P:
write a method that takes 2 strings and returns the count of the characters that
must be removed frmo both strings to turn them into anagrams

rules:
-all input is lowercase
-input can be an emtpy string
-input strings can already be anagrams (return count of 0)
-if strings have no mutual letters, all letters frmo both string will be removed

E:
p anagram_difference('', '') == 0
#already anagrams, nothing is removed

p anagram_difference('ab', 'cd') == 4
#all chars must be removed to form an anagram (anagram is empty string)

p anagram_difference('a', 'aa') == 1
#even is chars are the same, count must also be equal

D:
input: 2 strings (of lowercase letters)
-string to hold removed chars
-2 arrays to hold unique chars from each input string
return: integer (count of removed chars)

A:
-initialize removed_chars to empty string
-convert input strings to arrays of characters and select unique characters
-iterate over first array of uniq characters
  -if count of current character is greater than count of that character
  in second string
    -divide count in the current string by the count in the second string
    -multiply char by count
    -push to removed chars string
-repeat this iteration for the second string array of unique characters
-find and remmoved size of removed chars string

#codewars solution:
def anagram_difference(str1, str2)
  str1.chars.each do |letter|
    if str1.include?(letter) && str2.include?(letter)
      str1.sub!(letter, '')
      str2.sub!(letter, '')
    end
  end
  str1.size + str2.size
end

def get_removed_chars(string1, string2, array)
  string1_chars = string1.chars.uniq
  string1_chars.each do |letter|
    if string1.count(letter) > string2.count(letter)
      abs_difference = string1.count(letter) - string2.count(letter)
      abs_difference.times { |num| array << letter }
    end
  end
  array
end

def anagram_difference(str1, str2)
  return 0 if str1.chars.sort == str2.chars.sort
  removed_chars = []
  removed_chars = get_removed_chars(str1, str2, removed_chars)
  removed_chars = get_removed_chars(str2, str1, removed_chars)
  removed_chars.count
end

p anagram_difference('', '') == 0
p anagram_difference('a', '') == 1
p anagram_difference('', 'a') == 1
p anagram_difference('ab', 'a') == 1
p anagram_difference('ab', 'ba') == 0
p anagram_difference('ab', 'cd') == 4
p anagram_difference('aab', 'a') == 2
p anagram_difference('a', 'aab') == 2
p anagram_difference('codewars', 'hackerrank') == 10


=end

=begin
Problem 4

Write a method group_anagrams that takes an array of strings and groups the anagrams together. Anagrams are words that have the same characters but in a different order.

P:
write a method that takes an array of strings and returns a nested array with the anagrams grouped in the subarrays

rules:
-input array can contain empty string or single character -> should return self
-return array subarrays should be sortd by decreasing size

E:
p group_anagrams(["eat", "tea", "tan", "ate", "nat", "bat"]) == [["eat","tea","ate"],["tan","nat"],["bat"]]

p group_anagrams(["abc", "def", "efg", "cba"]) == [["abc","cba"],["def"],["efg"]]

D:
input: array (of string)
sorted copy of input array
return: array (array of arrays holding the input strings)

A:
-iterate over array, performing transformation
  -slice each word into array of char, sort, join

 -iterate over input array  - tranformation
    -take word, split into array of chars, converted to ascii value, and summed is the same

["eat", "tea", "tan", "ate", "nat", "bat"]
[ 1,      1      2     1       2      3]

initialize result array
-iterate over index positions (index)
  -iterate over values array with index (value, value_index)
    []<<

###from zane
# def group_anagrams(array)
#   values = array.map do |word|
#     word.chars.map { |el| el.ord }.sum
#   end

#   result = []
#   group = []
#   (0...array.size).each do |index|

#     values.each_with_index do |ascii_value, value_index|
#       if ascii_value == values[value_index.next]
#       p group << array[value_index]
#       end

#     end
#     result << group
#   end
#   p result.sort_by { |arr| arr.size }

# end
A: :
-initialize empty hash
-iterate over each word in array
  -convert word to an array of characters and sort; check if sorted word array
  is an existing hash key
    -if yes,
      push unsorted word_string to hash value array
    -else,
      set sorted chars array to hash key and place unsorted word/string in array as new value
-access hash keys and sort by decreasing size

def group_anagrams(array)
  anagram_hash = {}
  array.each do |word|
    if anagram_hash.has_key?(word.chars.sort)
      anagram_hash[word.chars.sort] << word
    else
      anagram_hash[word.chars.sort] = [word]
    end
  end
  anagram_hash.values#.sort_by {|arr| arr.size }.reverse
end


p group_anagrams(["eat", "tea", "tan", "ate", "nat", "bat"]) == [["eat","tea","ate"],["tan","nat"],["bat"]]
p group_anagrams([""]) == [[""]]
p group_anagrams(["a"]) == [["a"]]
p group_anagrams(["abc", "def", "efg", "cba"]) #== [["abc","cba"],["def"],["efg"]]
#p group_anagrams(["bat","eat", "tea", "tan", "ate", "nat" ]) #== [["eat","tea","ate"],["tan","nat"],["bat"]]


=begin
Given a certain array of positive and negative numbers, give the longest increasing or decreasing combination of at least 3 elements of the array.

If our array is a = [a[0], a[1], ....a[n-1]]:

i) For the increasing case: there is a combination: a[i] < a[j] < a[k]..< a[p], such that 0 ≤ i < j < k < ...< p ≤ n - 1

For the decreasing case the combination would be: a[i] > a[j] > a[k]..> a[p], such that 0 ≤ i < j < k < ...< p ≤ n - 1

For that task create a function longest_comb() (Javascript: longestComb() ) that will receive an array, and a command, one of the two kinds of strings: '< <' or '<<' (increasing), '> >' or '>>' (decreasing).

P:
write a method that takes an array of integers and a commend and returns an array of element selected from inupt array based on that command. array with hold either all array elements in increasing order or all elements in decreasing order

rules:
-input array can old posiitve or negative integers
-can take 2 difference input commands
-each command can have 2 forms, with or without space
-order of returns elements should reflect order of appearance in the input array
-find and return the longest set of numbers that meets criteria
-if multiple arrays meet the criteria, return all as a nested array

E:
Let's see some examples:

longest_comb([-1, 3, -34, 18, -55, 60, 118, -64], '< <') == [-1, 3, 18, 60, 118]

longest_comb([-1, 3, -34, 18, -55, 60, 118, -64], '> >') == [[-1, -34, -55, -64], [3, -34, -55, -64]] # outputs a 2D array of two combinations # of same length in the order that they appear in the given array from # left to right
We may have some cases without any possible combination:

longest_comb([-26, 26, -36, 17, 12, 12, -10, -21], "< <") == []
On the other hand we may have cases with many solutions:

longest_comb([-22, 40, -45, -43, -1, 7, 43, -56], "> >") == [[-22, -45, -56], [-22, -43, -56], [40, -45, -56], [40, -43, -56], [40, -1, -56], [40, 7, -56]])

D:
input: array of integer
return: array (can be a nested array)

A:
-get all slices of subarrays with a length of 2 or greater
  -initialize empty slices array
  -begin inner iteration from first_index up to second-to-last index (end_index)
  -take slice from start_index + 1 until array element to last array index
  -return slices array
-initialize control flow based on command input
  -for increasing numbers: (<< or < <)
    -iterate over slices nested array, performing selection
      -begin iteration from index position 1 to index position -2
        -check if all elements in a slice are greater than the previous element
    return selected array as increasing_slices

  -for decreasing numbers: (>> or > >)
    -iterate over indices of input array (start_index)
      -begin inner iteration from first_index up to end of array (end_index)
        -take slice from start_index until array element at end_index is greater than or equal to the array element at end_index -1
        push slice to slice array
-find size of largest array in slice_array
-iterate over slice array, selecting and returning all subarrays iwth that size

def get_subarrays(array)
  slices = []
  (0...array.size - 1).each do |start_index|
    (start_index+1...array.size).each do |end_index|
       slices << array[start_index..end_index]
    end
  end
  slices
end

def get_increasing_numbers(slices)
  increasing_slices = []
  slices.each do |slice|  #[-1, 3]
    selected = slice.select.with_index do |num, index|
      (index != (slice.size - 1)) && (num < slice[index + 1])
    end
    increasing_slices << selected
  end
  increasing_slices
end

#def get_decreasing_numbers(slices)
 # slices.select { |slice| slice.sort.reverse == slice && slice.size > 1 }
#end

def longest_comb(array, command)
  slices = get_subarrays(array)
 # if command == '<<' || command == '< <'
  p  slices = get_increasing_numbers(slices)
  #else
  #p  slices = get_decreasing_numbers(slices)
  #end
  ####
end
arr = [-1, 3, -34, 18, -55, 60, 118, -64]
command = '< <'
longest_comb(arr, command) == [-1, 3, 18, 60, 118]

arr = [-1, 3, -34, 18, -55, 60, 118, -64]
command = '> >'
longest_comb(arr, command) == [[-1, -34, -55, -64], [3, -34, -55, -64]]

arr = [-26, 26, -36, 17, 12, 12, -10, -21]
command = '< <'
longest_comb(arr, command) == []

arr = [-22, 40, -45, -43, -1, 7, 43, -56]
command = '> >'
longest_comb(arr, command) == [[-22, -45, -56],
    [-22, -43, -56], [40, -45, -56], [40, -43, -56], [40, -1, -56],
    [40, 7, -56]]

=end
#review above and try to get working -- maybe a placeholder?

###################
=begin
Given a certain array of positive and negative numbers, give the longest increasing or decreasing combination of at least 3 elements of the array.

If our array is a = [a[0], a[1], ....a[n-1]]:

i) For the increasing case: there is a combination: a[i] < a[j] < a[k]..< a[p], such that 0 ≤ i < j < k < ...< p ≤ n - 1

For the decreasing case the combination would be: a[i] > a[j] > a[k]..> a[p], such that 0 ≤ i < j < k < ...< p ≤ n - 1

For that task create a function longest_comb() (Javascript: longestComb() ) that will receive an array, and a command, one of the two kinds of strings: '< <' or '<<' (increasing), '> >' or '>>' (decreasing).

A:
-get increasing array slices:
initialize empty slices array
  -iterate from 0 up to array size - 2 (start_index)
    -initialize slice array to array element at start_index
    -iterate from start_index + 1 up to array size - 1 (end_index)
      -push element at end_index to slice array if it is greater than the last element in the slice array
  -when inner iteration finishes (in the outer block scope) push slice array to slices array is size is greater than 1
  -return slices array

-get decreasing array slices:
  -same as above, but reverse to <

-if command is '<<' or '< <':
  -invoke get_increasing slices
-else,
  -invoke get_decreasing_slices

-select largest element from slices array and find size
-select and return all elements from the slices array that have the largest size

def get_increasing_slices(array)
  slices = []
  (0...array.size-1).each do |start_index|
    slice = [array[start_index]]
    (start_index + 1...array.size).each do |end_index|
      slice << array[end_index] if array[end_index] > slice[-1]
    end
  slices << slice if slice.size > 1
  end
  slices
end

def get_decreasing_slices(array)
  slices = []
  (0...array.size-1).each do |start_index|
    slice = [array[start_index]]
    (start_index + 1...array.size).each do |end_index|
      slice << array[end_index] if array[end_index] < slice[-1]
    end
  slices << slice if slice.size > 1
  end
  slices
end

def longest_comb(array, command)
  if command == '<<' || command == '< <'
    slices = get_increasing_slices(array)
  else
    slices = get_decreasing_slices(array)
  end
  max_size = slices.max_by {|subarray| subarray.size}.size
  slices.select {|array| array.size == max_size}
end

arr = [-1, 3, -34, 18, -55, 60, 118, -64]
command = '< <'
longest_comb(arr, command) == [-1, 3, 18, 60, 118]

arr = [-1, 3, -34, 18, -55, 60, 118, -64]
command = '> >'
p longest_comb(arr, command) == [[-1, -34, -55, -64], [3, -34, -55, -64]]

arr = [-26, 26, -36, 17, 12, 12, -10, -21]
command = '< <'
p longest_comb(arr, command) #== []

arr = [-22, 40, -45, -43, -1, 7, 43, -56]
command = '> >'
p longest_comb(arr, command) #== [[-22, -45, -56],
   # [-22, -43, -56], [40, -45, -56], [40, -43, -56], [40, -1, -56],
   # [40, 7, -56]]

# slices = []
# array = [-1, 3, -34, 18, -55, 60, 118, -64]

# (0...array.size - 1).each do |first_index|
#    slice = [array[first_index]]
#   (first_index + 1...array.size).each do |second_index|
#      if array[second_index] > slice[-1]
#       slice << array[second_index]
#      end
#   end
#   slices << slice

# end

# p slices

###### finally got the logic right for what I was trying to do! But I read the
#text cases wrong and this doesn't solve the problem


51. Reverse or rotate?
(https://www.codewars.com/kata/56b5afb4ed1f6d5fb0000991)
6 kyu
Reverse or rotate?
The input is a string str of digits. Cut the string into chunks (a chunk here is
a substring of the initial string) of size sz (ignore the last chunk if its size
is less than sz).

If a chunk represents an integer such as the sum of the cubes of its digits is
divisible by 2, reverse that chunk; otherwise rotate it to the left by one
position. Put together these modified chunks and return the result as a string.

If

sz is <= 0 or if str is empty return ""
sz is greater (>) than the length of str it is impossible to take a chunk of
size sz hence return "".

P:
write a method that takes a string and an integer. Cut the string into slices
the size of integer. Cube each digits in a slice and find the sum. If the sum is
divisible by 2, reverse; else rotate. Join and and return the modified slices.

rules
-when taking slices, ignore final slice if size is less than the input integer
-return empty string if:
  1.input string is empty
  2. input integer is larger than strign size
  3. input integer is less than or equal to 0

E:
p revrot("733049910872815764", 5) == "330479108928157"
"73304 99108 72815 [764]"
7 3 3 0 4-> cube of each -> sum
check if: sum % 2 == 0 ? reverse: rotate

D:
input: string (of numbers) and integer
-array of slices taken from input string
return: string of numbers

A:
-return empty string if integer is 0, string is empty, or string size is less than integer

-initialize empty slices array
-iterate over index positions of input string from 0 to array size - 1
  -if current index number is divisible by the input integer
    -take slice of input string from current index with length of input integer
    -push slice to slices array

-iterate over slices array, performing transformation
  -convert string number to array of chars
  -convert each character to an integer
  -cube each number
  -sum all numbers in the array
  -if sum is divisible by the input integer
      reverse
    else
      rotate sum
-join and return transformed array
=end

def revrot(string, int)
  return '' if string.empty? || int <= 0 || string.size < int
  slices = []
  (0...string.size).each do |index|
    if index % int == 0
      slices << string[index, int] if string[index, int].size == int
    end
  end

 result = slices.map do |slice|
          sum = slice.chars.map { |n| n.to_i }.map { |i| i * i * i}.sum
          sum % int == 0 ? slice.reverse : slice.chars.rotate(1).join #math is wrong here -> this is returning 0 when it shouldn't; check cubing
        end
  result.join
end

p revrot("1234", 0) == ""
p revrot("", 0) == ""
p revrot("1234", 5) == ""
p revrot("733049910872815764", 5) == "330479108928157"
p revrot("123456987654", 6) == "234561876549"
p revrot("123456987653", 6) #== "234561356789"
p revrot("66443875", 4) == "44668753"
p revrot("66443875", 8) == "64438756"
p revrot("664438769", 8) == "67834466"
p revrot("123456779", 8) == "23456771"
p revrot("", 8) == ""
p revrot("123456779", 0) == ""
p revrot("563000655734469485", 4) == "0365065073456944"
