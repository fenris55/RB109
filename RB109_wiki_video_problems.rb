=begin
Given a non-empty string, check if it can be constructed by taking a substring of it and appending multiple copies of the substring together. You may assume the given string consists of lowercase English letters only.

Example 1:
 - Input "abab"
 - Output: True
 - Explanation: It's the substring 'ab' twice.

Example 2:
 - Input: "aba"
 - Output: False


P: write a method that takes a string and returns a boolean indicating whether the string can be constructed by multiplying one of the substrings

rules:
-input string will not be empty
-assume lowercase input?
-size of substring/how many substrings are irrelevant
  -just identify if any substring meets criteria

E:
p repeated_substring('abab') == true ('ab' * 2)
p repeated_substring('aba') == false (
p repeated_substring('aabaaba') == false
p repeated_substring('abaababaab') == true ('abaab' * 2)
p repeated_substring('abcabcabcabc') == true ('abc' *4)
p repeated_substring('aaaaa') == true ('a')

D:
-input: String
-array of all substrings
-size variable to store input string size
-return: boolean

A:
-initialize empty substrings array
-save size of input string as size
-iterate over input string from index 0 to size, exclusive
  -begin inner iteration from current outer iteration index up to size, exclusive
    -take slice of input string ranging from outer index to inner index and push to substrings Array

iterate over array of substrings
  -for each substring:
    - divide input string size by size of current substring (save as multipler)
    -multiply substring by multiplier and compare to input string for equality
    -if any multiplied substring is equal to input string, return true

def repeated_substring(string)
  substrings = []
  size = string.size

  (0...size).each do |start_index|
    (start_index...size - 1).each do |end_index|
     substrings << string[start_index..end_index]
    end
  end

  substrings.any? do |substring|
    multipler = size / substring.size
    substring * multipler == string
  end

end

p repeated_substring('abab') == true
p repeated_substring('aba') == false
p repeated_substring('aabaaba') == false
p repeated_substring('abaababaab') == true
p repeated_substring('abcabcabcabc') == true
p repeated_substring('aaaaa') == true


=begin
Given an array of strings made only from lowercase letters, return an array of all characters that show up in all strings within the given array (including duplicates). For example, if a character occurs 3 times in all strings but not 4 times, you need to include that character three times in the final answer.

P:
write a method that takes an array of strings and returns an array of each character that appears in all  strings


rules:
-all characters will be lowercase letter
-if a character appears multiple times in each word, it should appear multiple times in return array
-if no character occurs in all words, return empty array
-should letters in the return array be sorted alphabetically (or mirror occurence in first input array element)?

E:
p common_chars(['bella', 'label', 'roller']) == ['e', 'l', 'l']


p common_chars(['cool', 'lock', 'cook']) == ['c', 'o']

p common_chars(['aabbaa', 'cccdddd', 'eeffee', 'ggrrrr']) == []

D:
-input: array (of strings)
-array of all characters in the first word in the input array
-return: array (of strings -> selected chars)

A:
-use index reference to accessthe first word in the input array as the input
array and convert to an array of characters (save as test_letters)
-iterate over each character in test_letters, performing selection
  -if all elements in the input array include that letter
    - transform the input array by subbing that letter in each word with an empty
    space
    -return letter for selection
-return array of selected letters

Notes:
--need make make sure that a letter is selected the correct number of times
-simply checking if a letter is selected ina ll words does not track count occurence
options:
  -if all words contain letter, sub that letter in each word with an empty space

  -iterate over array of unique letters from first word; if a letter is included
  in all words, check count of that letter in each word; select letter number of
  times of the smallest count -> out will not be sorted correctly

def common_chars(array)
 test_letters = array[0].chars
 test_letters.select do |letter|
  if array.all? {|word| word.include?(letter)}
  array.map { |word| word.sub!(letter, '') }
  letter
 end
 end
end

p common_chars(['bella', 'label', 'roller']) == ['e', 'l', 'l']
p common_chars(['cool', 'lock', 'cook']) == ['c', 'o']
p common_chars(['aabbaa', 'cccdddd', 'eeffee', 'ggrrrr']) == []

def solve s
  upper = ('A'..'Z').map { |letter| s.count(letter)}.count { |el| el > 0 }
  lower = ('a'..'z').map { |letter| s.count(letter)}.count { |el| el > 0 }

  if upper > lower
    s.chars.map {|letter| ('a'..'z').include?(letter) ? letter.upcase! : letter }.join
  else
    s.chars.map {|letter| ('A'..'Z').include?(letter) ? letter.downcase! : letter}.join
  end
end

p solve("code") == "code"
p solve("CODe") == "CODE"
p solve("COde") == "code"
p solve("Code") == "code"


=begin
You have to create a method that takes a positive integer number and returns the next bigger number formed by the same digits:

12 ==> 21
513 ==> 531
2017 ==> 2071
If no bigger number can be composed using those digits, return -1:
9 ==> -1
111 ==> -1
531 ==> -1

P:
write a method that takes an integer and returns the next greater integer that can be formed using those numbers

rules:
-if no larger number can be formed with the integers, return -1
-if multiple larger numbers can be formed, return the one closest to the input integer
-any 1-digit number will return -1

E:
p next_bigger_num(9) == -1

p next_bigger_num(12) == 21

p next_bigger_num(513) == 531

p next_bigger_num(2017) == 2071

D:
input: Integer
-array holding all digits from input integer
-array holding all permutations of digits
return: integer (either containing all numbers for input integer or -1)

A:
-split input integer into array of digits
-get all permutations of digits in the array
-iterate over array of permutations, perfomring transformation
  -join each permutation to a string and convert to integer
-iterate over the integer array performing selection
  -select all integer greater than input Integer

if array of selected integers is empty, return -1; else return smallest integer from selected array

def next_bigger_num(int)
all_perms = int.digits.reverse.permutation.to_a
nums = all_perms.map { |array| array.join.to_i }
result = nums.select { |num| num > int }

result.empty? ? -1 : result.min
end

def next_bigger_num(int)
  return -1 if int.to_s.size == 1
  return -1 if int.to_s.chars.sort.reverse == int.to_s.chars
  count = int
  loop do
    break if count.to_s.chars.sort == int.to_s.chars.sort && count > int
    count += 1
  end
  count
end

p next_bigger_num(9) == -1
p next_bigger_num(12) == 21
p next_bigger_num(513) == 531
p next_bigger_num(2017) == 2071
p next_bigger_num(111) == -1
p next_bigger_num(531) == -1
p next_bigger_num(123456789) == 123456798

############not passing 1 codewars test

def sumDigProd(*a)
  p a
  arr = [a]
  p arr
  p arr.size
  loop do
    break if arr.size == 1
  p  arr = arr.sum.digits
  end
 # arr[0]
end

def sumDigProd(*a)
  p a
  arr = [a]
  p arr
  p arr.size
  loop do
    break if arr.size == 1
  p  arr = arr.sum.digits
  end
 # arr[0]
end

p sumDigProd(16, 28) == 6
# // 16 + 28 = 44
# // 4 * 4 =  16
# // 1 * 6 = 6

p sumDigProd(0) == 0

p sumDigProd(1, 2, 3, 4, 5, 6) #== 2


=end
=begin

Your task is to Reverse and Combine Words. It's not too difficult, but there are some things you have to consider...

So what to do?

Input: String containing different "words" separated by spaces

1. More than one word? Reverse each word and combine first with second, third with fourth and so on...
   (odd number of words => last one stays alone, but has to be reversed too)
2. Start it again until there's only one word without spaces
3. Return your result...

Some easy examples:

Input:  "abc def"
Output: "cbafed"

Input:  "abc def ghi 123"
Output: "defabc123ghi"

Input:  "abc def gh34 434ff 55_eri 123 343"
Output: "43hgff434cbafed343ire_55321"

P:
write a method that takes a string of space-separated words. reverse each 'word' and join together every 2 words until there are no spaces left

rules:
-if there's an odd number of words, reverse but do not join the last word
-if there are no spaces, return the input string

E:
p reverse_and_combine_text("abc def") == "cbafed"

p reverse_and_combine_text("dfghrtcbafed") == "dfghrtcbafed"

p reverse_and_combine_text("sdfsdf wee sdffg 342234 ftt") == "gffds432243fdsfdseewttf"

D:
input: string
return: string

-array of words from string

A:

-split the input string into an array of words at the spaces
-initialize empty array

-intialize Loop
-set break condition to break when array has size of 1
-iterate over array of words and reverse each word
  -iterate indices of array up to 2 less than array size
    -if index is even, join current element to element at next index position and push slice to array
    -if array size is odd, push last element

-return array element at index zero


def reverse_and_combine_text(string)
  words = string.split
  result = []

  loop do
    break if words.size == 1  #changed frmo result to words

    words.map! { |word| word.chars.reverse.join }

    (0..words.size - 2).each do |index|
      if index.even?
      result << words[index] + words[index + 1]
      end
    end

    if words.size.odd? && words.size > 1 #added
      result << words.last
    end

    words = result #added
    result = [] #added

  end
   words[0]
end

# def reverse_and_combine_text(str)
#   words = str.split
#   loop do
#     return words.join if words.size == 1
#     words = words.map(&:reverse).each_slice(2).map(&:join)
#   end
# end

p reverse_and_combine_text("abc def") == "cbafed"
p reverse_and_combine_text("abc def ghi jkl") == "defabcjklghi"
p reverse_and_combine_text("dfghrtcbafed") == "dfghrtcbafed"
p reverse_and_combine_text("234hh54 53455 sdfqwzrt rtteetrt hjhjh lllll12 44") == "trzwqfdstrteettr45hh4325543544hjhjh21lllll"
p reverse_and_combine_text("sdfsdf wee sdffg 342234 ftt") == "gffds432243fdsfdseewttf"


=begin
Extracting Words with "-ing" Inflection - from Edabit

Write a function that takes a string as an argument and returns a list of all the words inflected by "-ing". Your function should also exclude all the mono-syllabic words ending in "-ing" (e.g. bing, sing, sling, ...). Although these words end in "-ing", the "-ing" is not an inflection affix.

Notes
Mono-syllabic means a word containing just one syllable.
It's probably best to use RegEx for this challenge.

P:
write a method that takes a string and returns an array of all the words ending in '-ing' except for -ing words with oly one syllable

rules:
-monosyllabic words can have multiple characters before the -ing
-if no multisyllabic words end in -ing, return an emtpy array

Examples
ing_extractor("coming bringing Letting sing") ➞ ["coming", "bringing", "Letting"]

ing_extractor("going Ping, king sHrink dOing") ➞ ["going", "dOing"]

ing_extractor("zing went ring, ding wing SINk") ➞ []

D:
input: string
return: array

-array of words from input string
A:
-downcase string, split to array of chars, check that all chars are inlcuded in the range a-z; if not:
  -clean input string by substituting all non-letters character with an empty space

-initialize vowels array to lower case vowels
-initialize words to array of words from input string

-iterate over words array, performing selection
  -select word if the slice of the final 3 index positions equals 'ing'

-iterate over ing_words array, performing selection
  -take slice from index position from index 0 up to third-to-last
  -check if any letter in downcased slice includes a vowel (convert downcased slice to array of chars and check if any character is included in vowels array)
-return result array

def ing_extractor(string)
   unless string.gsub(' ', '').downcase.chars.all? { |el| ('a'..'z').include?(el)}
    string.gsub!(/[^a-z' ']/i, '')
   end

  vowel = %w(a e i o u )
  words = string.split

  ing_words = words.select do |word|
                word[-3..-1].downcase == 'ing'
              end

  result = ing_words.select do |word|
   slice = word[0...-3]
   slice.downcase.chars.any? { |el| vowel.include?(el)}
 end

  result
end

p ing_extractor("coming bringing Letting sing") == ["coming", "bringing", "Letting"]

p ing_extractor("going Ping, king sHrink dOing") == ["going", "dOing"]

p ing_extractor("zing went ring, ding wing SINk") == []

=begin
Nearest Vowel
Given a letter, created a function which returns the nearest vowel to the letter. If two vowels are equidistant to the given letter, return the earlier vowel.

Notes
All letters will be given in lowercase.
There will be no alphabet wrapping involved, meaning the closest vowel to "z" should return "u", not "a".

P:
write a method that takes a string letter and returns the closest vowel

rules:
-if two vowels are equally distant, return the proceeding one
-test cases only handle lowercase letters
-if input is a vowel, return self

Examples
nearest_vowel("b") ➞ "a"

nearest_vowel("s") ➞ "u"

nearest_vowel("c") ➞ "a"

nearest_vowel("i") ➞ "i"

D:
input: string
return: string

array of vowels
alphabet array

A:
-initialize array of lowercase vowels
-return input string if included in vowels array

-initialize alphabet array to a-z
-find index position of input letter in alphabet array (1 -> 'b')

-itialize empty hash
  -iterate over vowels array
    -find index of current vowel in alphabet array
      -find absolute difference current vowel index and the input character index

      -save to hash with difference as key and vowel as value placed in array

-sort hash and retrieve key/value pair with smallest key (smallest index)

-sort; first element will index; return second element

def nearest_vowel(letter)
  vowels = %w(a e i o u )
  alphabet = ('a'..'z').to_a
  return letter if vowels.include?(letter)
  input_index = alphabet.index(letter)

vowel_and_distance = {}
 vowels.each do |vowel|
  vowel_index = alphabet.index(vowel)
  distance = (input_index - vowel_index).abs

  if vowel_and_distance.has_key?(distance)
    vowel_and_distance[distance] << vowel
  else
    vowel_and_distance[distance] = [vowel]
  end

end

  result = vowel_and_distance.min_by { |k, v| k }
  result = result[1]
 result.sort.first
end


# p nearest_vowel("b") == "a"

# p nearest_vowel("s") == "u"

p nearest_vowel("c") == "a"

# p nearest_vowel("i") == "i"


=begin
https://fine-ocean-68c.notion.site/Copy-of-Problem-List-da904f4438be4366862fc4ba36a84dab#2a817b2b7c3c4ee49019e7f5041ac760


Track the Robot (Part 2)
This robot roams around a 2D grid. It starts at (0, 0) facing North. After each time it moves, the robot rotates 90 degrees clockwise. Given the amount the robot has moved each time, you have to calculate the robot's final position.

To illustrate, if the robot is given the movements 20, 30, 10, 40 then it will move:

20 steps North, now at (0, 20)
30 steps East, now at (30, 20)
10 steps South. now at (30, 10)
40 steps West, now at (-10, 10)
...and will end up at coordinates (-10, 10).

P:
write a method that takes an unknown number of integers representing movements. the method should start at coordinates 0, 0 return an array of the final coordinates

rules:
-unknown number of input integers
-for every integer, direction changes by 90 degrees clockwise
-if there is no input or input is 0, return starting coordinates
-first movement is north
-input integers can be negative (indicates reverse direction)

Examples
trackRobot(20, 30, 10, 40) ➞ [-10, 10]

trackRobot() ➞ [0, 0]
// No movement means the robot stays at (0, 0).

trackRobot(-10, 20, 10) ➞ [20, -20]
// The amount to move can be negative.
Notes
Each movement is an integer (whole number).

D:
-input: integers (unknown amount)
-return: array (holding 2 integers)

-2 variables to track n/s and e/w count

A:
-initiaize starting_coordinates to array [0, 0]
- return starting_coordinates if input is 0
-initialize north-south count to 0
-initialize east-west count to 0

-place input integers into an array (directions)
-iterate over directions
  -if index is even
    -if index + 2 is divisible by 4, subtract current element from north_south
    else
    increment north_south by current element
  -else (index is odd)
      -if index + 1 is divisible by 4
        -decrement east_west by current element
      -else
        -increment by east_west by current element
-place 2 count variables into array and return
=end
def trackRobot(*directions)
  starting_coordinates = [0, 0]
  return starting_coordinates if directions == 0 #|| directions == []

  north_south = 0
  east_west = 0

  directions.each_with_index do |direction, index|
    if index.even?
     (index + 2) % 4 == 0 ? north_south -= direction : north_south += direction
    else
     (index + 1) % 4 == 0 ? east_west -= direction : east_west += direction
    end

  end
  [east_west, north_south]

end

# p trackRobot(20, 30, 10, 40) == [-10, 10]

p trackRobot() == [0, 0]
# // No movement means the robot stays at (0, 0).

# p trackRobot(-10, 20, 10) == [20, -20]
=end