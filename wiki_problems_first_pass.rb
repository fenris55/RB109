=begin
substrings = []
  (0...string.length).each do |ind| #3
    (ind...string.length).each do |length|
     substrings << string[ind..length]
      end
  end

other substring approach from ester
# Codewars problems frm teh Larwood list
#listing here since some are retired -- can't save solution online

1.Count letters in string
problem:
count the letters in the string using a hash

input: string (of letters in a string)
return: hash (with letters as key and count as value)

rules:
-count the letters in an input string
-convert use letter to a hash key and count as the corresponding value
-hash keys must symbols, not strings
-assume all input contains lowercase letters only

data:
hsh to hold counts
-iterative structure to iterate over input string

example:
letter_count('arithmetics') #=> {:a=>1, :c=>1, :e=>1, :h=>1, :i=>2, :m=>1, :r=>1, :s=>1, :t=>2}

algorithm:
-initialize hash with defauls values of 0
-convert input string to array of individual characters
-iterate over each array element
-use hash reference
  -convert element to symbol
  - increment value
-return hash

option 2:
-steps 1-2 above
-iterate over a copy of the unique elements of input array
-for each element
  -use hash reference with el convert to symbol, and set equal to count of current el

def letter_count(string)
  result = Hash.new(0)
  string.chars.uniq.each { |el| result[el.to_sym] = string.count(el) }
  result
end

#refactoring below -- saw Ennumerable#tally used in a spot session
#weird - saw this used in a spot session. docs say with no argument, calling
on an array of strings should return a new hash (with keys as strings)
-getting an undefined method error - says it
OK it came out in 2.7 and I am running 2.6 - inquire about updating
- coderpad is currently down - it would probably work on there


#not working -- #tally won't run on this version
def letter_count(string)
  result = Hash.new(0)
  string.chars.tally(result)
end

p letter_count('codewars') #== {:a=>1, :c=>1, :d=>1, :e=>1, :o=>1, :r=>1, :s=>1, :w=>1}
p letter_count('activity') == {:a=>1, :c=>1, :i=>2, :t=>2, :v=>1, :y=>1}
p letter_count('arithmetics') == {:a=>1, :c=>1, :e=>1, :h=>1, :i=>2, :m=>1, :r=>1, :s=>1, :t=>2}


2.Find all pairs

problem:
-write a method that takes an array of integers and returns on integer representing
the number of pair in array. Pairs are 2 of the same number.

input: array of integers (t be searched for pairs)
return: integer (representing number of pairs in input array)

rules:
-if array is empty, hash 1 el, or has no pairs, return 0
-a pair is only 2 numbers:
  ex [0,0,0,0] => 2
  ex [0,0,0] => 1
-(for random tests, max arr length is 1000 and range of values in array is 1..1000)

examples:
[1, 2, 5, 6, 5, 2] == 2
[1, 2, 2, 20, 6, 20, 2, 6, 2] == 4

data:
iterative structure to iterative over input array and count pairs

algorithm:
-initialize variable to 0 to hold count
-sort input array
  (now pairs are grousp next to next other)
-break input array input 2-character sub-arrays (.each_cons(2))
-iterate over array of subarray (each iteration passes a subarry into block)
  -on each iteration, if the first and second subarray elements are the same,
    -incremeent count by 1
-return count variable
-possible edge cases -- may need to return 0 if array length is less than 2

OOPS major logic issue here. splitting into 2-chars chars ends up dividing some pairs.

new idea:
-iterate over an array of uniq integers
  - only each iteration, check original array count for current element
  -save counts to new array
-iterate over array of counts
  -select if el % 2 == 0 (meaning there are an )
  UGG nope this wont work either: eg, 3 will be omitted, but 3 indicated 1 pair

ok trying again, think this out.

need to find the number of pairs in an array of integers
-iterate over unique array and take count of each integer
SOLVED - but that was rough and don't like the if--else below.
cannot see codewars solutions

def pairs(arr)
 int_count = arr.uniq.map { |int| arr.count(int) } #returns count of each int
 pair_counts = int_count.map do |count|
    if count <= 0
      0
    elsif count.even?
      count / 2
    else
      (count - 1) / 2
    end
  end
  pair_counts.sum
end

p pairs([1, 2, 5, 6, 5, 2]) == 2
p pairs([1, 2, 2, 20, 6, 20, 2, 6, 2]) == 4
p pairs([0, 0, 0, 0, 0, 0, 0]) == 3
p pairs([1000, 1000]) == 1
p pairs([]) == 0
p pairs([54]) == 0


3. Return substring instance count

problem:
-write a method that takes 2 strings, a full text and a search text. Return an integer
representing the number of times the search text appears in the full text

input: 2 strings (string to search in and string to search for)
ouput: integer (representing number of times seconds string arg appears in first)

examples:
solution('aa_bb_cc_dd_bb_e', 'bb') # should return 2 since bb shows up twice
solution('aaabbbcccc', 'bbb') # should return 1

data:
-iterative structure countign occurences of str 1 in str 2

algorithm
initialize count to 0
-string str1 into array of consecutive chars with the same length of str2
-iterate over subarray
-check if each subarray is eqaul to str 1
if yes, increment count
return count


def solution(str1, str2)
  subarrays = []
  count = 0

  str1.chars.each_cons(str2.length) { |ss| subarrays << ss }

  subarrays.each do |sub_array|
    count += 1 if sub_array.join == str2
  end
  count
end

p solution('abcdeb','b') == 2
p solution('abcdeb', 'a') == 1
p solution('abbc', 'bb') == 1


4.Alphabet symmetry

problem:
write a method that takes an array of words and returns an array of integers
representing how many letters in each element have the same numeric position in
the word as they have in the alphabet

input: array of strings
return: array of integers

rules:
-method will take a string of words and return an array of integers
-the integers in the return array are a count for each corresponing string in the
input array
-for each word, identify count for how many chars occupy the same position in
the string and in the alphabet


-alphabet position == index + 1
 -- will need a hash to utilize this
-or can use #use to access access ascii value
 -- 'a' == 97 ### maybe not

ok yes -- downcase input to check.
 iterate from 97 (ascii for lower 'a') to 122 (ascii val for lowercase 'z')
 simultaneously iterate over string, checking each char

-thoughts - initial idea here was to initialize an area of string a -z and then
compare against the index of each letter in a string. This way, if the indexes
align, that means the letter in the string is in the same position it would be
in the alphabet.

problems: i used #index to access the index of the string character during each
iteration. the problem is that this returns the index of the first instance of
that character in the string. so if a string has repeating characters, the second
time index is calld on the repeated character, the method returns the of the
first character

tried to solve this issue by instead iterating with #each_with_index, so the
correct index is passed into the block on each iteration. However, since I'm no
longer iteraing with #map, the booleans returned are not being return in subarray
unique to each word. Instead, it is a 1-d array of booleans. Tried placing the
return into an array but that simply nexts each boolean individually, instead of
nesting them so that all booleans for a given word are group into one subarray

have made a thorough mess of this. learning til tomorrow

LETTERS = ('a'..'z').to_a
ASCII_VALS = ('a'.ord...'z'.ord).to_a

def solve(arr)       # ["apple", "banana"]
#boolean_arr = []
 boolean_letter_count =  arr.map do |str| #"apple"
                          str.downcase.chars.select do |letter| #["a", "p", "p", "l", "e"]
                        #  p letter.ord == ASCII_VALS[letter].index#.index(letter.downcase) #== LETTERS.index(letter.downcase)
                          #p str.rindex(letter) #== LETTERS.index(letter)
                           p letter
                            end
                          end
  #boolean_letter_count.map {|sub_arr| sub_arr.count(true )}
  boolean_letter_count
 # p ASCII_VALS

end

#p solve(['apple', 'banana'])
#p solve(["abode","ABc","xyzD"]) == [4, 3, 1]
#p solve(["abode","ABc","xyzD"]) == [4,3,1]
#p solve(["abide","ABc","xyz"]) == [4,3,0]
        #a-1b-2c-3d-4e-5f-6g-7h-8i-9j-10k-11l-12m-13n-14
        #"I-1 A-2 M-3 D-4 E-5 F-6 A-7 N-8 D-9 J-10 K-11 L-12"
p solve(["IAMDEFANDJKL","thedefgh","xyzDEFghijabc"]) #== [6,5,7] # so this was taking the index of the 1st D and not the second
# trying to solves by manurlaly passing in the index, but since map is gone now, this is not returnin the  array of booeals in the correct
#nested format
#p solve(["encode","abc","xyzD","ABmD"]) == [1, 3, 1, 3]


5.Longest vowel chain

problem:
write a method that takes a string and returns the length of the longest vowel
substring

input: string
return: integer (representing longest vowel substring)

rules:
-find length of longest substring of vowels in input string
-string will be lowest letters only (no spaces)
-vowels are only aeiou (no y)

examples:
p solve("codewarriors") == 2 (longest substring is "io", which has a length of 2 chars)
p solve("suoidea") == 3 (longest vowel substring is uoi, which has a length of 3)

data:
-array of chars of input word
-iterative structure to iterate over chars array

algorithm

option1:
create all substrings
create array of vowels
itetate over all substring
if all chars are included in the vowel array, add to new array
find size of new array


VOWELS = %w(a e i o u)

def solve(string)
  all_substrings = []
  (0...string.length).each do |index|
    (index...string.length).each do |length|
      all_substrings << string[index..length]
    end
  end

 vowels = all_substrings.select do |ss|
            ss.chars.all? { |el| %w(a e i o u).include?(el) }
          end
  vowels.max_by { |s| s.length }.length

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

problem:
write a method that takes a string of integers and returns the number of odd
substrings that can be formed

input: string (of integers)
return: integer (representing the number of off-numbered substrings that can be
formed with input string)

rules:
-find number of odd-numbered substrings that can be formed from input string
-substrings can range in length from 1 to size of input string

example:
"1341" => 1, 1, 3, 13, 41, 341, 1341 => returns 7

data:
-array to hold all possible substrings
-iterative structure to get all substrings
-second iterative structure to check whether each substring has an off value
if converted to a string

algorithm:
-get all possible substrings from input string and save in substring array
- iterate over substring array, performing selection
  - if the substring converted to an integer has an odd value, select it
- get the count of how many substring are in the selected off substrings

def solve(string)
  substrings = []
  (0...string.size).each do |index|
    (index...string.size).each do |length|
      substrings << string[index..length]
    end
  end
  odd_substrings = substrings.select do |substring|
    substring.to_i.odd?
  end
  odd_substrings.size
end


p solve("1341") == 7
p solve("1357") == 10
p solve("13471") == 12
p solve("134721") == 13
p solve("1347231") == 20
p solve("13472315") == 28


** not from wiki:

problem: write a method that takes a string a returns an array containing a
one-character string and an integer: string represents letter with the longest
consecutive substring and int represents number of elements in that substring

input: string
output: array (holding one-letter string and an integer)

rules:
-find single letter that repeats the most
-return letter and count of most consecutive ccurrences in array
-empty string shold return empty string and 0 in array
-when mulitples have the same occurences, return the first instance

algorithm:
-create array of all possibe substrings
-delete all substrings that contain more than one letter
  -iterate over arr of substrings
    -split into chars
   - check if all chars are the same
-sort (#max_by with block) by largest
-add single letter and length of substrign to array

def longest_repetition(chars)
  return ['', 0] if chars.empty?

  all_substrings = []
  (0...chars.length).each do |index|
    (index...chars.length).each do |length|
      all_substrings << chars[index..length]
      end
    end

 longest_substring = all_substrings.select do |ss|
                               first = ss[0]
                               ss.chars.all?(first)
                             end.max_by { |ss| ss.length}

  result = []
  result << longest_substring[0]
  result << longest_substring.length
  result
end


p longest_repetition("aaaabb") == ['a', 4]
p longest_repetition("bbbaaabaaaa") == ['a', 4]
p longest_repetition("cbdeuuu900") == ['u', 3]
p longest_repetition("abbbbb") == ['b', 5]
p longest_repetition("aabb") == ['a', 2]
p longest_repetition("ba") == ['b', 1]
p longest_repetition("") == ['', 0]
p longest_repetition("aaabbcccddd") == ['a', 3]

def solve(s)
  return 0 if (s == nil || s == false)
  s = s.downcase.tr(' ', '')
  substrings = []
 (0...s.length).each do |index|
   (index...s.length).each do |length|
     substrings << s[index..length]
     end
   end

  vowels = substrings.select do |ss|
    ss.chars.all? {|letter| %w(a e i o u).include?(letter)}
    end

  return 0 if vowels.empty?
  p vowels.sort_by {|el|el.size}.reverse.first.length

  #vowels.max_by {|el| el.length}.length

end

p solve(nil) #== 2
#p solve("suoidea") == 3
#p solve("iuuvgheaae") == 4
#p solve("ultrarevolutionariees") == 3
#p solve("strengthlessnesses") == 1
#p solve("cuboideonavicuare") == 2
#p solve("chrononhotonthuooaos") == 5
#p solve("iiihoovaeaaaoougjyaw") == 8

#returning to Simple Pig Latin -- debugging punctuation issue
#resolved by called chars within the ifelse statement rather than first
#also had to flatten the constant array
LETTERS = (('A'..'Z').to_a << ('a'..'z').to_a)#.flatten

def pig_it(text)
   text.split.map do |word|
     if word.chars.all? { |el| LETTERS.include?(el) }
      word.chars.rotate(1).join << 'ay'
     else
      word
     end
   end.join(' ')
end

p pig_it ('Pig latin is cool !') #=='igPay atinlay siay oolcay'
#p pig_it('This is my string') =='hisTay siay ymay tringsay')

7 Substring Fun - redoing

problem:
write a method that take an array of words and returns a new word (string)
-the new word should be made by compiling the letter from each input word that
corresponds with its array index position

input: array (of strings)
return: string (made of letters from input array elements)

rules:
-take an array of strings and create a new word
-each letter in new word should be taken from a word in the input array
-take the letter whose position corresponding with the word's position in the array
-assume valid input
  - all aray will have enough words with enough letters
  - array can be empty
-empty array should return an empty string
-one-one input array shoul return a single letter

data:
-string to hold return value
-iterative structure

algorithm:
- intialize empty result string
-iterate over a range of integers starting 0 up to (but not including) the
  length of input array
-on each iteration, use index reference to access the array element at index
  position corresponding to current integer
  -double the index reference to then access the string index of the letter that
  corresponds to the current integer
  -using this index reference, add current letter to result string
-return result string

def nth_char(arr)
  result = ''
  (0...arr.length).each { |idx| result << arr[idx][idx] }
  result
end

p nth_char(['yoda', 'best', 'has']) == 'yes'
p nth_char([]) == ''
p nth_char(['X-ray']) == 'X'
p nth_char(['No','No']) == 'No'
p nth_char(['Chad','Morocco','India','Algeria','Botswana','Bahamas','Ecuador','Micronesia']) == 'Codewars'

8. Repeated Substring

problem:
write a method that takes a string and idenitfies the smallest substring and the
number of repetitions needed to create the string. The method should return an
array holding the smallest substring as the first element and the integer
representing number of repetitions as the second element

input: string
return: array (hold smallest repeated substring of input string and integer
indicating number of repeats)

rules:
-assume value input
-all input will be lowercase letters
-if there are no substrings that can be repeated to form the string, return
array should hold the string and 1

notes:
-when input string has an even size, the substring length will be:
 -1. even
 -2. equal to or less than the length of of the input string
eg:
"ababab" == ["ab", 3]
=> substring legnth must be a multiple of
substring.length == 6 (max)
possible substring lengths: 6, 3, 2, 1,

if iterating over possible lengths
  skip if substring .length % num ! =


examples:
f("ababab") == ["ab", 3]
f("abcde") == ["abcde", 1]

data:

algorithm:
-initialize result array
-create an array of all substrings beginning at index 0
  (a, ab, aba, abab, ababa, ababab)
-reverse array, so largest substring is first
-iterate over array of substrings
  take length of the string (6) and substract the length of the current substring (6) => 0
  (if difference is 0, difference == 1)
  multiply subtring by difference
  -check if result is equal to input string
    -if yes, add substring to result array
    -and add substring length to result array
    - no, move to next iteration
-return the result array

#this works - refactoring below
def f(string)
  result = []
  substrings = []

  (0...string.length).each do |idx|
    ss = string[0..idx]
    substrings << ss if (string.length % ss.length) == 0
  end

  substrings.each do |ss|
    multiplier = string.length / ss.length
    if ss * multiplier == string
      result << ss
      result << multiplier
      return result
    end
  end
end

def f(string)
  result = []
  substrings = (0...string.length).map { |idx| string[0..idx] }

  solutions = substrings.select { |ss| ss * (string.length / ss.length) == string }

  result << solutions.min_by {|ss| ss.size}
  result << result[0].size
end


9.Typoglycemia Generator

problem:
write a method that takes a string and alphabetically sorts each word, leaving
the first, last, and any speical characters in place

input: string (can be empty, single word, or multiple words separated by spaces)
return: string (assuming new string)

rules:
-string input can contain one word, multiple words separated by spaces, or be empty
-assume all letters are lower case
-case-insensitive (says to ignore capitalization)
-for each word, leave the first and last letter in place
-leave any special characters in place
-only special characters will be [- . , ']
-empty string and  words with 1, 2, or 3 chars will return same

data structures
-array to hold special characters
-array to hold all characters of a string
  -may need some control flow with addition level of iteration if the string holds
  more than one element/word
-variables to hold first and last char? (or maybe oculd just skip those on iteration)
-iterative struture to perform sorting
-string to hold return value

examples: see below

algorithm:
-initialize constant to hld 4 special chars [',. -]
-split input string (this is either give an array of words or an aray of letters)
-if input string include a space
  split chars again (this will further split words into letters)
  - see sorting steps below
-elseif input string does not include a space
  -iterate over index range from 1 to 2 less than length of the string
  -each iteration will pass in an index
  -sort the letters unless the current element is included in the special characters array
    -can sort using sort/sort_by or manually
    -manual: if arr[idx] > arr [idx - 1]
                arr[idx] > arr [idx - 1] = arr[idx + 1], arr[idx]
-this should destructively sort the string? return input string?

not sure about splitting - trying with chars and seeing if we can just skip over
spaces while sorting - tried to add a space to special chars constant but didn't work

# other option - could iterate over all indices (0..string,length)using map, and
# return the medificaitons as the block return value. use an if/else to control flow --
# return char if first, last, or included in special char array; else sort

#nope -- just pass in each with index so element is directly availabe for sorting
SPECIAL_CHARS = %w(- , . ')

def scramble_words(string)
  first = string[0]
  last = string[-1]
  middle = string[1..-2]
  middle = middle.chars.sort #do |el1, el2|
    #el1 <=> el2
    #p el1
    #p el2
   # next if (SPECIAL_CHARS.include?(el1) || SPECIAL_CHARS.include?(el2))
  #end
  #string.chars.sort do |el1, el2|
  #  next if SPECIAL_CHARS.include?(el1)
   # next if el1 == string[1]
    #next if el2 == string[-1]
    #letters_arr[]
  #end
   first + middle.join + last
end


p scramble_words('professionals') == 'paefilnoorsss'
p scramble_words('i') #== 'i'
p scramble_words('') == ''
p scramble_words('me') == 'me'
p scramble_words('you') == 'you'
#p scramble_words('card-carrying') == 'caac-dinrrryg'
#p scramble_words("shan't") == "sahn't"
#p scramble_words('-dcba') == '-dbca'
#p scramble_words('dcba.') == 'dbca.'
#p scramble_words("you've gotta dance like there's nobody watching, love like
#you'll never be hurt, sing like there's nobody listening, and live like it's
#heaven on earth.") #== "you've gotta dacne like teehr's nbdooy wachintg, love
#like ylo'ul neevr be hrut, sing like teehr's nbdooy leiinnstg, and live like it's haeevn on earth."

=end
#commetning out for now
#got too complicated -- first handling only single-word strings
=begin
SPECIAL_CHARS = %w(- , . ' )

def scramble_words(string)
  if string.include?(' ')
  letters = string.split.map do |word|
          word.chars
          end
          (1...string.length - 1).sort_by do |idx|
          unless SPECIAL_CHARS.include?()
          if letters
  end
end

def top_3_words(string)
  string.split.max_by { |word| word.size }
end

p top_3_words("e e e e DDD ddd DdD: ddd ddd aa aA Aa, bb cc cC e e e")
# => ["e", "ddd", "aa"]


def add_length(string)
  string.split.map { |word| word + " " + word.size.to_s }
end


p add_length('apple ban') #== ["apple 5", "ban 3"])
p add_length('you will win') == ["you 3", "will 4", "win 3"]
p add_length('you') == ["you 3"]
p add_length('y') == ["y 1"]


def alias_gen(first_name, surname)
  first_initial = first_name[0]
  surname_initial = surname[0]

  FIRST_NAME.include?(first_initial) ? first_initial : return "Your name must start with a letter from A - Z."
  SURNAME.include?(surname_initial) ? surname_initial : return "Your name must start with a letter from A - Z."

  "#{FIRST_NAME[first_name[0].upcase]} #{SURNAME[surname[0].upcase]}"
  if !FIRST_NAME.keys.include?(first_name[0].upcase) || !SURNAME.keys.include?(surname[0].upcase)
    return "Your name must start with a letter from A - Z."
  else
    "#{FIRST_NAME[first_name[0].upcase]} #{SURNAME[surname[0].upcase]}"
  end

end


9.Typoglycemia Generator - retrying

problem: take a string and return a new string with first char, last character, and
any special character in original positions, and all other letters sorted.

input: string (of one or multiple words, or empty)
output: (new) string (with inner letter of each word sorted)

rules:
-string input can contain one or multiple words
-string input can be empty
-for each word in the input string, first, last, and special character must keep
original index position
-all other character should be sorted
- words in return string must retain original position
-ignore capitalization (here, assume all letters are lower case)
-string may only contain 4 special characters [ - , . ']
- when input string is: empty or has only 1, 2, 3 chars, return string will
  mirror input string

examples:
p scramble_words('professionals') == 'paefilnoorsss'
p scramble_words('i') == 'i'
p scramble_words('') == ''
p scramble_words('me') == 'me'
p scramble_words('you') == 'you'
p scramble_words('card-carrying') == 'caac-dinrrryg'
p scramble_words("shan't") == "sahn't"
p scramble_words('-dcba') == '-dbca'
p scramble_words('dcba.') == 'dbca.'

data structure:
-array to special characters
-array to hold the characters input string
-

algorithm:
-initialize array of special chars
-split input string into an array
  #-if input string does not include " " (must be a single-word string, and splitting returns letters)
    -iterate over array elements with indices
      if index == 0 || index == -1 || el is included in special chars array
      return element (continue)
      else sort
#  elsif if input string contains " " (must be multi-word string, and splitting returns array of words)
  #  -iterate over array of words, transforming (#map)
#      -convert each word to an an array chars (create nested array)
 #     -call nested array letters
#    iterate over nested array (passes subarray into block)
  #  iterate over each subarray (passses letter into block)
    - perform sorting stes listed above (use a helper method)
    -rejoin sorted arrays


def scramble_words(string)
  special_chars = %w(- , . ')

  letters = string.split
  # add if statement here
  sorted =[]
  (0...letters.size).map do |idx|
    if index(letters[idx]).zero? || index(letters[idx]) + 1.nil? || special_chars.include?(letters[idx])
      sorted << char
   # else
    #  sorted << (char[idx] <=> char[idx + 1])
    end
  end
end

p scramble_words('professionals') #== 'paefilnoorsss'
#p scramble_words('i') == 'i'
#p scramble_words('') == ''
#p scramble_words('me') == 'me'
#p scramble_words('you') == 'you'
#p scramble_words('card-carrying') == 'caac-dinrrryg'
#p scramble_words("shan't") == "sahn't"
#p scramble_words('-dcba') == '-dbca'
#p scramble_words('dcba.') == 'dbca.'
#p scramble_words("you've gotta dance like there's nobody watching, love like
#you'll never be hurt, sing like there's nobody listening, and live like it's
#heaven on earth.") == "you've gotta dacne like teehr's nbdooy wachintg, love
#like ylo'ul neevr be hrut, sing like teehr's nbdooy leiinnstg, and live like
#it's haeevn on earth."


11.Extract the domain name from a URL
5 kyu
=begin
Write a function that when given a URL as a string, parses out just the domain name and returns it as a string. For example:

domain_name("http://github.com/carbonfive/raygun") == "github"
domain_name("http://www.zombie-bites.com") == "zombie-bites"
domain_name("https://www.cnet.com") == "cnet"


problem: take a string representing a website url and return just the name
of the webiste as a string (the part before .com)

input: string
output: string (new string)

rules:
-return just the doamin name take from the input string
-domain name will be the substring that comes before the substring ".com"
-before the domain name, substring can vary
  -www.
  -http://
-locate and return the substring between "www." || "http://" and ".com"

data:
-control flow for initial substring
  -if url includes "www." (4 element substring)
  -else "http://"

algorithm:
- if input string includes "www."
  -  take a slice input string start at character after "www." and up to
  -substring ".com"
-elsif input string includes "https://"
 -take a slice input string starting at character after "https://" and up to
  substring ".com"

-actually, rethinking
-some inputs have both www and http and http
-initialize array of possible url beginnings (www, http, https)
 - is url includes beginning, delete
- return remaining string from index 0 up to substring ".com"

ok. that was totally hack and slash. Description:

-replace all non-letter character with a space
  - this leaves space-separated letter groups
  - first is the www/https letter, then domain name, then additional substrings
  -split into array of words separated at spaces
  -return second element of array

#NOPE - only passed about 1/2 the test cases
def domain_name(url)
  url.gsub(/[^a-z]/i, " ").split.at(1)
end

p domain_name("http://google.com")# == "google"
p domain_name("http://google.co.jp") #== "google"
p domain_name("www.xakep.ru") #== "xakep"
p domain_name("https://youtube.com") #== "youtube"


12. Detect Pangram

problem:
write a method that determines if the string input contains each leter of the alphabet at least once

input: string
output: boolean

rules:
-assuming all string input will be a sentence (multiple words)
-string input can include spaces and punctuation
- case-insensitive
-check if string input includes each letter of the alphabet at least once
-ignore punctuation
-return a boolean value
  -true if input string in a pangram
  -false if not

data:
-array of all letters on the alphabet
-array of all indidivual characters from input string minus punctuation (gsub fill handle spaces along eith punctuation)
-iterative strucure to check each string character against the alphabet array

algorithm:
-initialize alphabet array
  -set range from 'a'..'z' and convert to array
-downcase input string and convert into an array of characters (#chars)
-iterate over the array of characters
  -substitute all characters that are not letters with ''
  -(#gsub - this will remove all punctuation and extra spaces)
-iterate over alphabet array
  -one each iteration, check if the current letter is included in the array holding
    chars from string input (#all?)
  -if all iterations return true, the entire alphabet is included in the string input
-return boolean produce by the above iteration


def panagram?(string)
  alphabet = ('a'..'z').to_a

  input_arr = string.downcase.gsub(/[^a-z]/, '').chars

  alphabet.all? { |letter| input_arr.include?(letter) }
end

p panagram?("The quick brown fox jumps over the lazy dog.") == true
p panagram?("This is not a pangram.") == false

9.Typoglycemia Generator - trying again after study session with Alex


1) words are seperated by single spaces
2) only spaces separate words, special characters do not, for example: tik-tak -> tai-ktk
3) special characters do not take the position of the non special characters, for example: -dcba -> -dbca
4) for this kata puctuation is limited to 4 characters: hyphen(-), apostrophe('), comma(,) and period(.)
5) ignore capitalisation

problem:
-write a method that returns a string with the first, last, and special chars
left in place and all other letters sorted

input: string
output: string (new?)

rules:
-keep first, last, and special chars at original index position
-sort all other chars
-assume all input is either lower case letters or four special chars
-included special chars are: (, . ' -)
-empty string should return empty string
-string input with length of 3 or less should return itself
-special chars can be at beginning or end of array, and don't count as the
first and last letter

algorithm:
-return input string if empty or if size is <= 3
-initialize special_chars array (for comparison)
-initialize empty array for selected_chars
-convert input string to chars
-iterate over array chars with index numbers (#each_with_index)
-on each iteration
  -if current element is included in the special chars array
    -add both element and its index to the selected_chars array as a subarray
-rejoin chars array to a string clean_string (#join)
-remove special characters from chars array (#gsub)
-remove and save idx 0 as first
-remove and save idx -1 as last
-sort clean_string (now only has middle letters)
-rejoin first and last
-iterate over special_char array
  -each iteration will [pass in a subarr with char and inx]
  -insert char (idx 0 of subarry) at paired indx (inx 1 of subarry) into clean_string (does this need ot be an array?)
-return clean string

####solved this except for the final test case (sentence instead of a single word)
-tried solving by extracting to helper methods. now it's really long and still not working

SPECIAL_CHARS = %w(- , . ')

def get_special_chars(string) #help method to collect special characters
  chars_from_string = []
  string.chars.each_with_index do |letter, idx|
    if SPECIAL_CHARS.include?(letter)
      chars_from_string << [letter, idx]
    end
  end
  chars_from_string
end

def remove_special_chars!(string)
   string.chars.select {|letter| !SPECIAL_CHARS.include?(letter) }.join
end

def string_sorter!(string, first, last)
  if !string.include?(' ')
    first + string.chars.sort.join + last
  else
   first + string.split.map {|word| word.chars.sort.join}.join(' ') + last
  end
end

def create_new_string!(array, string)
  array.each do |subarr|
    string.insert(subarr[1], subarr[0])
  end
  p string
end

def scramble_words(string)
  return string if string.empty? || string.size <= 3

  chars_from_string = get_special_chars(string)

  clean_string = remove_special_chars!(string)

  first = clean_string.chars.shift
  last = clean_string.chars.pop

  new_string = string_sorter!(clean_string, first, last)


  create_new_string!(chars_from_string, new_string)

end

#p scramble_words('professionals') == 'paefilnoorsss'
#p scramble_words('i') == 'i'
#p scramble_words('') == ''
#p scramble_words('me') == 'me'
#p scramble_words('you') == 'you'
p scramble_words('card-carrying')  == 'caac-dinrrryg'
#p scramble_words("shan't") #== "sahn't"
#p scramble_words('-dcba') == '-dbca'
p scramble_words('dcba.') == 'dbca.'

p scramble_words("you've gotta dance like there's nobody watching, love like
you'll never be hurt, sing like there's nobody listening, and live like it's
heaven on earth.") == "you've gotta dacne like teehr's nbdooy wachintg, love
#like ylo'ul neevr be hrut, sing like teehr's nbdooy leiinnstg, and live like
#it's haeevn on earth."

13. Kebabize
Modify the kebabize function so that it converts a camel case string into a kebab case.

kebabize('camelsHaveThreeHumps') // camels-have-three-humps
kebabize('camelsHave3Humps') // camels-have-humps
Notes:
the returned string should only contain lowercase letters

problem write a method that takes a string in camel case and convert to kebab case
(words separated by - with all letters lowercase)

input; string (in camel case - no spaces and each new word capitalized)
return: string (in kebab case - words separated by dashes and all letters lower case)

rules:
-returned string should only contain lowercase
-for each capital letter, insert a space at index before
-remove any non-letter chars
  -3 is removed from test case
  -test cases do not include punctuation

examples:
p kebabize('myCamelCasedString') == 'my-camel-cased-string'
p kebabize('myCamelHas3Humps') == 'my-camel-has-humps'

data:
array holding all chars from input string
iterative structure to check for new words (indicated by a capital letter)
  and insert a dash at the index before the capital letter)

algorithm
-initialize array of capital letter alphabet
-convert input string to array of chars
-iterate over array of chars with index, performing transformation
  -if current element is included in the capital letters array
  OPTIONS:
    -insert - at index 0 of chars array (this works if manurally adding to new return object)
    -insert - at index 0 of current word (this works if using an iterative method like map)
  else
  return element unmodified from the block
-join and downcase returned array

NOTES: this worked smoothly. Forgot to remove non-letter chars. Initially 3 was
included in return from 2nd test case

def kebabize(string)
  capitals = ('A'..'Z').to_a

  string.gsub(/[^a-z]/i, '').chars.map do |el|
    capitals.include?(el) ? el.insert(0, '-') : el
    end.join.downcase

end
#failing final test case - input seem to begin with a capital, which is adding
a - to the start of the return string

def kebabize(str)
  capitals = ('A'..'Z').to_a

 result =  str.gsub(/[^a-z]/i, '').chars.map do |el|
    (capitals.include?(el) && str.index(el) != 0) ? el.insert(0, '-') : el
    end.join.downcase

  result.delete('-') if result[0] == '-'
end

user solution below:

def kebabize(s)
  s.gsub(/[^a-z]/i, '').split(/(?=[A-Z])/).join('-').downcase
end

p kebabize("Idfxa") == "idfxa"
p kebabize('myCamelCasedString') == 'my-camel-cased-string'
p kebabize('myCamelHas3Humps') == 'my-camel-has-humps'


16. Stop gninnipS My sdroW!

problem:
write a method that take a string of one or more words and returns the SAME
string with all words with a length >= 5 reversed

input: string (of one or multiple words)
output: string (SAME string, mutated; all words >= 5 reversed)

rules:
-input will be letters and spaces only
-return same string
-no changes if all words in string have a length less than 5
-don't worry about empty strings? (important - #length will return nil on empty string)

examples:
p spinWords("Hey fellow warriors") == "Hey wollef sroirraw"
p spinWords("This is a test") == "This is a test"
p spinWords("This is another test") == "This is rehtona test"
P spinWords(‘test’) == ‘test’

data:
-mutating iterative structure

thoughts:
-can't convert to array or original string won't be returned
-maybe can iterate over a copy and then mutate original

algorithm:
-split string into array of words ## consider how to handle 1-word string (splut at spaces)
-iterate over with index
-on each iteration, check if length of word is >= 5
  -if yes, use index reference to reverse current word in original string
  if no, do nothing
-return string
(-check that object id is same being and after)

def spin_words(string)
  word_arr = string.split(' ')
  word_arr.each do |word|
   string.gsub!(word, word.reverse) if word.length >= 5
 end
 string
end

text = "Hey fellow warriors"
p text.object_id
p spin_words(text) == "Hey wollef sroirraw"
p text.object_id

p spin_words("This is a test") == "This is a test"
p spin_words("This is another test") == "This is rehtona test"
p spin_words("test") == "test"

17. Write Number in Expanded Form

problem:
write a method that takes an integer and returns it in expended form as a string

input: integer (whole number greater than 0)
return: string (expanded form -- each digit in order joined by a + and separated
by spaces)

rules:
assume input is > 0
assume integer numbers are integer
-zeros will not be accounted for
  ((70304) == '70000 + 300 + 4')

examples:
p expanded_form(12) == '10 + 2'
p expanded_form(42) == '40 + 2'
p expanded_form(70304) == '70000 + 300 + 4'

thoughts:
-once converted to an array of integers, the array size will give total number of places
-once converted to a string, multiplying by 0 can give the correct number of zeros
-somehting like num + ('0' * idx) (if arr is reversed?)


def expanded_form(int)
 num_strings = int.digits.map(&:to_s)
 expanded = num_strings.map.with_index do |num, idx|
  num == '0' ? num : num + ('0' * idx)
end
expanded.reverse.select {|num| num.to_i > 0 }.join( ' + ')
end

p expanded_form(12) == '10 + 2'
p expanded_form(42) == '40 + 2'
p expanded_form(70304) == '70000 + 300 + 4'


19. Title Case
problem: write a method that returns the first input string in title case (each
word capitalized). Method can take an optional 2nd argument of word that should
be kept lowercase.

input: 2 string: 1 required, 1 optional
  -first strinh in the text to convert to title case
  -second string is a list of word to leave lowercase
return: string (1st arg in title case with indicated words left lowercase)

rules:
-take the first input string and convert to all capitalized words
-if 2nd argument is given, any words included in the 2nd argument should be
  lowercased in the returned string
-will need to set default second arg to an empty string
-will need to convert 2nd argument to lower (can be entered in any case)

data:
-array to hold words in the second argument string
-iterative structure to check if each word in the first arguemnt
is included in the second argument

algorithm:
-define method with a default parameter of '' for 2nd argument
-check if 2nd argument is empty
-if empty
  -continue to iteration
-if not empty,
  -downcase second arg
  -convert to array of words(#split(' '))
-convert 1st argument to an array of words
-iterate over, performing transformation
  -for each word, check if included in the excluded words array
    -if included, return word
    -else, capitalize word
-join return array into a string spearated by spaces


def title_case(title, ex_words = '')
  excluded_words = []
  if !ex_words.empty?
   excluded_words = ex_words.downcase.split(' ')
 end

result_arr = title.split(' ').map { |word| excluded_words.include?(word.downcase) ? word.downcase : word.capitalize }
result_arr[0].capitalize!
result_arr.join(' ')

end

p title_case('a clash of KINGS', 'a an the of') #== 'A Clash of Kings'
p title_case('THE WIND IN THE WILLOWS', 'The In') #== 'The Wind in the Willows'
p title_case('the quick brown fox') #== 'The Quick Brown Fox'

#from esther
def get_words(hash)
  hash.each_with_object(string = '') do |key, value, str|
    p key
    p value
    p str
    #string << (value * key).join#(pair[-1] * pair[0]).join
  end

  string.chars.permutation.map(&:join).uniq
end

p get_words({1=>["a", "b", "c"]}) #==  ["abc", "acb", "bac", "bca", "cab", "cba"]
p get_words({2=>["a"], 1=>["b", "c"]}) == ["aabc", "aacb", "abac", "abca", "acab","acba", "baac", "baca", "bcaa", "caab", "caba", "cbaa"]


20. Count and Group Character Occurrences in a String
Write a method that takes a string as an argument and groups the number of
times each character appears in the string as a hash sorted by the highest
number of occurrences.

The characters should be sorted alphabetically e.g:

get_char_count("cba") => {1=>["a", "b", "c"]}
You should ignore spaces, special characters and count uppercase letters as lowercase ones.

P:
write to method that takes a string argument and returns a hash in which keys
are integers representing number of occurences of each letter OR NUMBER in the input string
and values are arrays holding the letters in alphabetical order) that coincide
with that count

input: string
return: hash

rules:
-count occurence of each letter or number in the input string
-convert count to a hash key
-add each letter to the hash value array
-hash value array should be sorted alphabetically
-counter uppercase letters as lowercase (only lower letters in the hash)
-ignore spaces and special characters
-keys should be arranged descending

E:
p get_char_count("Mississippi") == {4=>["i", "s"], 2=>["p"], 1=>["m"]}
p get_char_count("Hello. Hello? HELLO!!") == {6=>["l"], 3=>["e", "h", "o"]}
p get_char_count("aaa...bb...c!") == {3=>["a"], 2=>["b"], 1=>["c"]}
p get_char_count("aaabbbccc") == {3=>["a", "b", "c"]}
p get_char_count("abc123") == {1=>["1", "2", "3", "a", "b", "c"]}

D:
-array holding accepted chars (letters and numbers)
-hash to hold return value
-iterative struture to loop over input string, count chars, and add to hash

A:
-initializing a range of all lowercase letters and numbers 0-9
-downcase input string
-convert string to array of chars
-iterate over chars array removing all non-letter or number characters
  (#gsub -> '' unless char is inlcuded in included chars array)
  (peform selection #select to return new array of chars included in included chars array)
(selected chars array now hold only lowercase letters and numbers)
-sort selected chars arr starting with highest occurrence
  (selected_chars.sort_by { |el| -a.count(el)})
-iterate over sorted selected chars array (#each_with_object)
  -if count of current in selected chars array is a hash key,
    - add current el to value array for that count
  -else,
    - create a new key-value pair with the count of the current elements as the
    key and an array holding the current element as the value
-once iteration is complete, iterate over result hash values
  -on each iteration, sort value/array elements to be in alph/numerical order
return sorted hash

def get_char_count(string)

  included_chars = (('a'..'z').to_a << ('0'..'9').to_a).flatten

  selected_chars = string.downcase.chars.select { |el| included_chars.include?(el) }

  sort_chars = selected_chars.sort_by { |el| -selected_chars.count(el) }

  result = sort_chars.uniq.each_with_object({}) do |el, hash|
    if hash.has_key?(sort_chars.count(el))
      hash[sort_chars.count(el)] << el
    else
      hash[sort_chars.count(el)] = [el]
    end
  end

   result.values.map { |sub_array| sub_array.sort! }
   result
end

p get_char_count("Mississippi") #== {4=>["i", "s"], 2=>["p"], 1=>["m"]}
p get_char_count("Hello. Hello? HELLO!!") == {6=>["l"], 3=>["e", "h", "o"]}
p get_char_count("aaa...bb...c!") == {3=>["a"], 2=>["b"], 1=>["c"]}
p get_char_count("aaabbbccc") == {3=>["a", "b", "c"]}
p get_char_count("abc123") == {1=>["1", "2", "3", "a", "b", "c"]}


21. Find the Mine!

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
write a method that takes a nested array holding only multiple 0s and one 1.
Return an array with 2 integer elements representing the index position of the 1
in the input array

input: nested (2D, square) array (elements are 1 1 and multiple 0s)
output: 2-element array holding the index of the subarray holding the 1 as the
first element and the index position within that subarray of the 1 for the
second element

rules:
-all input arrays will be square
  (number of subarrays and number of subarray elements will always be the same)
-there will only be 1 1
-all other array elements will be 0

E:
p mineLocation( [ [1, 0, 0], [0, 0, 0], [0, 0, 0] ] ) == [0, 0]
p mineLocation( [ [0, 0, 0], [0, 1, 0], [0, 0, 0] ] ) == [1, 1]
p mineLocation( [ [0, 0, 0], [0, 0, 0], [0, 1, 0] ] ) == [2, 1]
p mineLocation([ [1, 0], [0, 0] ]) == [0, 0]
p mineLocation([ [1, 0, 0], [0, 0, 0], [0, 0, 0] ]) == [0, 0]
p mineLocation([ [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 1, 0], [0, 0, 0, 0] ]) == [2, 2]

D:
- iterative stucture to loop over each subarray
-array to hold return values

A:
initialize empty result array
-iterate over input array
-on each iteration, check if all elements of current subarray are 0
  (loop with index - #each_with_index)
- if all elements are not 0
  - add current index to result array
  -initialize inner iteration with index (alternative - iterate over indexes)
    -(this will pass each subarray element into the block)
    -if current subarray element is not zero,
      -add to result array
-return result array

def mineLocation(arr)
  result = []

  arr.each_with_index do |subarr, idx|
    if !subarr.all?(0)
      result << idx
      subarr.each_with_index do |el, idx|
        if el == 1
          result << idx
        end
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

P:
write a method that takes two string arguments and returns a boolean: true if
the letter in the frist string can be rearrange to create the second string,
false if not

input: 2 string
return: booelean

rules:
-letters in the first string can be rearranged to create second string
-don't repeated letters
  (each letter can only be used the number of time it appears in the first string)
-no special characters or numbers
-all letters will be lowercase
-return boolean

E:
p scramble('rkqodlw', 'world') == true
p scramble('cedewaraaossoqqyt', 'codewars') == true
p scramble('katas', 'steak') == false
p scramble('scriptjava','javascript') == true

D:
-array to sort both string elements (and then convert back to string)

A:
-convert both input to an array chars
-sort array
-rejoin array back to string
-check if the sorted secon string argument is included in the first

THINGS I FAILED TO CONSIDER
1. - need to delete all chars not included in str2 (otherwise they mess up equality)
2. - need to delete included chars that repeat more times than in str2

Ok, so I failed to really think through how the comparison logic would play out
(specifically the presence of extra and additional characters)

# noticed that I call #chars multiple times and never need ot convert back to string - refctoring below
def scramble(str1, str2)
  str1 = str1.chars.sort.join
  str2 = str2.chars.sort.join

  str1 = str1.chars.delete_if { |el| !str2.include?(el) }.join

  str1.chars.all? do |el|
    str1.count(el) >= str2.chars.count(el) && str2.chars.all? {|el| str1.include?(el) }
  end
end

#failing performance test with super long string
def scramble(str1, str2)
  #str1 = str1.chars.sort
  str2 = str2.chars#.sort

  str1 = str1.chars.delete_if { |el| !str2.include?(el) }

  str1.all? do |el|
    str1.count(el) >= str2.count(el) && str2.all? {|el| str1.include?(el) }
  end
end

# retry - not passing final codewars test case with super long input strings
def scramble(s1, s2)
  s2.chars.all? { |el| s1.include?(el) && s1.count(el) >= s2.count(el) }
end

p scramble('rkqodlw', 'world') == true
   #dkloqrw, dlorw
p scramble('katas', 'steak') == false
p scramble('cedewaraaossoqqyt','codewars') == true
p scramble('scriptjava','javascript') == true

23. Longest alphabetical substring

6 kyu
Find the longest substring in alphabetical order.

Example: the longest alphabetical substring in "asdfaaaabbbbcttavvfffffdf" is
"aaaabbbbctt".

There are tests with strings up to 10 000 characters long so your code will need
to be efficient.

The input will only consist of lowercase characters and will be at least one
letter long.

If there are multiple solutions, return the one that appears first.

problem: write a method that takes one string as input and return the longest
substring whose characters appear in alphabetical order

input: string
output: string (new string?)

rules:
-find longest substring with all characters in alphabetical order
-if there is more than one substring in alphabetical order with greatest length,
return the first in the string
-input string will only contain lowercase letters
-input strign will not be empty
-long test cases - method must be efficient
  (finding all sibstrings, etc will not work)
-letters do not need to be consecutive, just in order
-single letter will return self (does new string matter?)

E:
p longest('asd') == 'as'
p longest('nab') == 'ab'
p longest('abcdeapbcdef') == 'abcde'
p longest('asdfaaaabbbbcttavvfffffdf') == 'aaaabbbbctt'
p longest('asdfbyfgiklag') =='fgikl'
p longest('z') == 'z'

D:
range of lowercase letters
(alternatively, compare ascii values)
-iterative structure to loop over the input string and find longest ordered
substring

A:
-thoughts:
  #ord will find ascii value
  a substring meets the problem requirements if string[ind] <= string[ind + 1]
    (be careful with final iteration using that comparison)

-initialize empty placeholder string
-initialize result string
-split string into array of chars
-iterate over array with index numbers (#each_with_index)
  -check if array[idx].ord < array[idx + 1].ord
    if yes,
    -add el to placeholder string
    if no,
    reassign placeholder string to result string if placeholder string length
    is greater than length of result string
    -reassign placeholder string to current el
-once iteration is complete
    -check if placeholder string length > result string length
      if yes, reassign result to placeholder
      if no, return result string
edge case - final char iteration

def longest(string)
  result = ''
  placeholder = string[0]

  (1...string.length).each do |idx|
    if string[idx].ord >= placeholder[-1].ord
      placeholder << string[idx]
    else
        result = placeholder if placeholder.length > result.length
        placeholder = string[idx]
    end
  end

  result = placeholder if placeholder.length > result.length
  result
end


p longest('asd') == 'as'
p longest('nab') == 'ab'
p longest('abcdeapbcdef') == 'abcde'
p longest('asdfaaaabbbbcttavvfffffdf') == 'aaaabbbbctt'
p longest('asdfbyfgiklag') =='fgikl'
p longest('z') == 'z'
p longest('zyba') == 'z'


24. The Hashtag Generator
(https://www.codewars.com/kata/52449b062fb80683ec000024)
5 kyu
The marketing team is spending way too much time typing in hashtags.
Let's help them with our own Hashtag Generator!

Here's the deal:

It must start with a hashtag (#).
All words must have their first letter capitalized.
If the final result is longer than 140 chars it must return false.
If the input or the result is an empty string it must return false.
Examples
" Hello there thanks for trying my Kata"  =>  "#HelloThereThanksForTryingMyKata"
"    Hello     World   "                  =>  "#HelloWorld"
""                                        =>  false

P
write a method that takes a string an returns it as a hashtag: string
beginning with #, each word capitalized, no spaces

input: string
output: string converted to hashtag form

rules:
-return false if string is empty or RESULT (not input) is longer than 140 chars
-return string must begin with #
-remove all spaces from input string
-capitalize each word fomr input string

notes:
-input can contain + and *
-empty string and accompanying math is automatically ignored
-if math is incuded, perform multiplication and return + portion
--if multiplication leads to a retun longer than 140 chars, return false
-is math leads to a result less than 140 chars:
  -return hashtage
  -add math to return

E:
" Hello there thanks for trying my Kata"  =>  "#HelloThereThanksForTryingMyKata"
"    Hello     World   "                  =>  "#HelloWorld"
""      =>  false

D:
-need to split input string into an array of words
-iterative structure to capitalize and join input string

A:
-split input string into array of words
-iterate over array, capitalizing each word
-rejoin array with no spaces
-append # to start of string
-check that result is not and empty string adn is not greater than 140 chars

NOTES: failed to consider that adding '#' means no string is empty
(easy solve - check for string == '#' instead of empty)


def generateHashtag(string)
  #result = string.split.map { |word| word.capitalize}.join.insert(0, '#')
  result = string.split.map(&:capitalize!).join.insert(0, '#')
  result == '#' || result.size > 140 ? false : result
end

p generateHashtag("") == false
p generateHashtag(" " * 200) == false
p generateHashtag("Do We have A Hashtag") == "#DoWeHaveAHashtag"
p generateHashtag("Codewars") == "#Codewars"
p generateHashtag("Codewars Is Nice") ==  "#CodewarsIsNice"


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

P:
write a method that takes two hash arguments, which recipe 1. a recipe and 2.
the available ingredients. Return an integer that represents how many times
the recipe can be made given the available ingredients

input: 2 hashes
return: integer

rules:
-no measurments
-if a recipe cannot be made with available ingredients, return 0
-ingredient has can be empty
-unsure if recipe hash can be empty
-

E:
p cakes({"eggs"=>4, "flour"=>400},{}) == 0

D:
iterative struture
  -iterate over recipe hash
  -divide current recipe by number of ingredients
  -integer division

A:
-edge case: empty hash
    - return 0 if either hash is empty
-iterate over recipe hash (#each_with_object)
(a key-value pair will pass into the block on each iteration)
  -use key to access corresponding in the ingredients hash
  -divide ingredient hash value by recipe hash value
-collect numbers in array
-return smallest number

-consider -- when ingredients hash doesn't have an ingredient, attempting to
access will return nil?

def cakes(recipe, ingredients)
  #return 0 if recipe.empty? or ingredients.empty?
  int_array = []
  recipe.each do |ingredient, amount|
    if ingredients.keys.include?(ingredient)
      int_array << ingredients[ingredient] / amount
    else
      return 0
    end
end
  int_array.min
end

#refactoring below

def cakes(recipe, ingredients)
  int_array = []
  recipe.each do |ingredient, amount|
    if ingredients.keys.include?(ingredient)
      int_array << ingredients[ingredient] / amount
    else
      return 0
    end
end
  int_array.min
end

p cakes({"flour"=>500, "sugar"=>200, "eggs"=>1},{"flour"=>1200, "sugar"=>1200, "eggs"=>5, "milk"=>200}) == 2
p cakes({"cream"=>200, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>1700, "flour"=>20000, "milk"=>20000, "oil"=>30000, "cream"=>5000}) == 11
p cakes({"apples"=>3, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>500, "flour"=>2000, "milk"=>2000})== 0
p cakes({"apples"=>3, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>500, "flour"=>2000, "milk"=>2000, "apples"=>15, "oil"=>20}) == 0
p cakes({"eggs"=>4, "flour"=>400},{}) == 0
p cakes({"cream"=>1, "flour"=>3, "sugar"=>1, "milk"=>1, "oil"=>1, "eggs"=>1},{"sugar"=>1, "eggs"=>1, "flour"=>3, "cream"=>1, "oil"=>1, "milk"=>1}) == 1

Get All Possible Anagrams from a Hash

Given a hash of letters and the number of times they occur, recreate all of the
possible anagram combinations that could be created using all of the letters,
sorted alphabetically.

The inputs will never include numbers, spaces or any special characters, only
lowercase letters a-z.

E.g. get_words({2=>["a"], 1=>["b", "c"]}) => ["aabc", "aacb", "abac", "abca", "acab", "acba", "baac", "baca", "bcaa", "caab", "caba", "cbaa"]

P:
write a method that takes a hash with count occurence as key and array holding
associated characters as value and return an array holding all possible substrings
that can be created with the hash contents

input: hash (count /integer as key, array holding individual chars as values)
return: array of string (all possible substring that can be formed from the hash)

rules:
-all chars will be lowercase letters
-no spaces
-substrings in return array must be sorted alphabetically

E:
get_words({1=>["a", "b", "c"]}) == ["abc", "acb", "bac", "bca", "cab", "cba"]
get_words({2=>["a"], 1=>["b", "c"]}) == ["aabc", "aacb", "abac", "abca", "acab", "acba", "baac", "baca", "bcaa", "caab", "caba", "cbaa"]

D:
array to hold all available letters
-iterative strucutre to loop over the letters and create substrings
-return array

A:
-initialize letter array
-loop over hash (pass in integer and subarray) (each)
  -loop over the values / subarray
    -multiply each letter by the hash key
    -add to letter array

-iterate over letters array idices (0..array.size)
  on each iteration, iterate over
  -012
  -021
  0123
  0132
  0213
  0231

def get_words(hash)
  letters = ''
  hash.each do |count, letter_subarr|
    letter_subarr.each do |letter|
      letters << letter * count
    end
  end
=begin
  (0...letters.size).each do |idx|
    (0...letters.size).each do |inner_idx|
   p  letters[idx] + letters.delete(letters[idx])
  end
end


p letters.chars.zip

end
p get_words({1=>["a", "b", "c"]}) #== ["abc", "acb", "bac", "bca", "cab", "cba"]
#get_words({2=>["a"], 1=>["b", "c"]}) #== ["aabc", "aacb", "abac", "abca", "acab", "acba", "baac", "baca", "bcaa", "caab", "caba", "cbaa"]


def to_camel_case(str)
  return str if str.empty?

  word_arr = str.gsub(/[^a-z]/i, ' ').split
  first_word = word_arr[0]
  upcased_words = []

  (1...word_arr.length).each do |idx|
    upcased_words << word_arr[idx].capitalize
    end

  new_str = upcased_words.join

  if ('a'..'z').include?(first_word[0])
    new_str.insert(0, first_word)
  else
    new_str.insert(0, first_word.capitalize)
  end

end

p to_camel_case('') == ''
p to_camel_case("the_stealth_warrior") == "theStealthWarrior"
p to_camel_case("The-Stealth-Warrior") == "TheStealthWarrior"
p to_camel_case("A-B-C") == "ABC"


26. Mean Square Error
(https://www.codewars.com/kata/51edd51599a189fe7f000015/train/ruby)
Complete the function that

accepts two integer arrays of equal length
compares the value each member in one array to the corresponding member in the other
squares the absolute value difference between those two values
and returns the average of those squared absolute value difference between each member pair.

P:
write a method that takes two arrays of the same length, finds the absolute
value difference between the numbers at corresspnoding indices, finds sqare of that differece,
and return the
average of those differences

input: 2 array of integers (of equal length)
output: integer

rules:
-find absolute difference of numbers at each array incides
-find square of each difference
-find and return average of absolute value squares
-array will always be equal length
-remembers to find ABSOLUTE difference

E:
Examples
[1, 2, 3], [4, 5, 6]              -->   9   because (9 + 9 + 9) / 3
[10, 20, 10, 2], [10, 25, 5, -2]  -->  16.5 because (0 + 25 + 25 + 16) / 4
[-1, 0], [0, -1]                  -->   1   because (1 + 1) / 2

D:
-iterative structure to loop over first array element and index, comparing
to element at corresponding index of second array
-with block, find abolsute difference and square
-new array to hold the squares

A:
-iterate over new array with index numbers (#map.with_index)
-on each iteration, access element in second array at corresponding index
-find absolute difference between the 2 numbers (asb_diff)
  -can use #abs on both?
  -otherwise check if either number is less than 0 and multiply by -1
-multiply abs_diff by itself
-store result in an array (squares_arr)
 - if using #map, the return array will be automatically populated by this
  - could manually << to array created beforehand
-sum elements in squares_arr
  -#sum or #reduce
-divide result of squares sum by size of squares_arr
-return result

OOPs: need to actually find difference between the positive and negative and
then convert that difference to an absolute num - should have checked test case
with 2 -2 -> 4 -> 16 more closely

OOPS2 - FORGOT THE FLOAT - veen noticed it but forgot to write down

takeaways: thing about the implications over EVERYTHING in the test cases

def solution(arr1, arr2)
  squares = arr1.map.with_index do |el, idx|
              (el - arr2[idx]).abs * (el - arr2[idx]).abs
            end

  squares.sum.to_f / squares.size.to_f
end

p solution([1, 2, 3], [4, 5, 6]) == 9
p solution([10, 20, 10, 2], [10, 25, 5, -2]) == 16.5
p solution([-1, 0], [0, -1]) == 1

27. Exponent method
(https://www.codewars.com/kata/5251f63bdc71af49250002d8)
5 kyu
Create a method called "power" that takes two integers and returns the value of
the first argument raised to the power of the second. Return nil if the second
argument is negative.

Note: The ** operator has been disabled.

P:
wite a method that takes two integers as arguments are returns the reuslt of
raising the first to the power of the second without using **

input: two integers (positive or nagative)
return: integer (positive or negative)

rules:
-raise the first integer to the power of the second
-don't use ** operator
-integers can be positive or negative
  (-if the first integer is negative, the return value will be negative)
-if the second integer is negative, the method should return nil
-OK NEW MATH
  : any number to the power of 0 ( n ** 0) equals 1
-so, if the second number of 0, the method will return 1

E:
p power(2, 3) == 8
p power(10, 0) == 1
p power(-5, 3) == -125  5x1 = 5, 5x5 = 25 25x5 = 125
p power(-4, 2) == 16 -4 X 1 = -4, -4x-4 = 16
p power(3, 2) == 9 3x1 = 3, 3x3 = 9
p power(8, -2) == nil

D:
- control flow statement checking whether second integer is positive or negative
- control flow to check whether first integer is 0
-loop to iterate over first integer until it has been multiplied the number of
times specified by the second integer

A:
-check whether int2 is negative
  -if yes, return NIL
-check whether int2 is 0
  - if yes, return 1
-iterate over int2
  - #upto
  - #times
  -set a range
-with range starting at 1 up to and including int2
  -multiply int1 by int 2
  -reassign int1 to result of previous multiplication
  -continue until iteration is complete

-use reduce?

talking out this math: power(-5, 3) #== -125  5x1 = 5, 5x5 = 25 25x5 = 125

-so per above, I want to multiply it by 1 1 time - so essentially not multiply it
-so actually I want to multiply it one less that int2 (and that missing 1 is its starting value)
-iterate from 1 up to 1 less than int2
  so I can do 1.upto(int2-1)
-iteration is set
so on each remaining iteration,
  -set running total to int1
  multiply running total by int1
  -reassign rinning total to result

def power(int1, int2)
  return nil if int2 < 0
  return 1 if int2 == 0

  running_total = int1
  1.upto(int2 - 1).each do |num|
    running_total = running_total * int1
  end
  running_total
end

p power(2, 3) == 8
p power(10, 0) == 1
p power(-5, 3) == -125  #5x1 = 5, 5x5 = 25 25x5 = 125
p power(-4, 2) == 16 #-4 X 1 = -4, -4x-4 = 16
p power(3, 2) == 9 #3x1 = 3, 3x3 = 9
p power(8, -2) == nil


28. Where my anagrams at?
(https://www.codewars.com/kata/523a86aa4230ebb5420001e1)
5 kyu
What is an anagram? Well, two words are anagrams of each other if they both
contain the same letters. For example:

'abba' & 'baab' == true

'abba' & 'bbaa' == true

'abba' & 'abbba' == false

'abba' & 'abca' == false
Write a function that will find all the anagrams of a word from a list. You will
be given two inputs a word and an array with words. You should return an array
of all the anagrams or an empty array if there are none. For example:

P:
write a method that takes two arguemtn, a string and an array of string and
returns a new array of all the input array element that are anagrams of the
input string.

input: string and an array (of strings)
return: aray of selected strings

rules:
-identify which words in the input array are anagram of the input string
(ie, the share the exact same letters - count and type)
-return in the anagrams in an array
- assume all input is lowercase letters and no input is empty?
-if no array elements are anagrams of the input string, return an empty array

E:
p anagrams('abba', ['aabb', 'abcd', 'bbaa', 'dada']) == ['aabb', 'bbaa']
p anagrams('racer', ['crazer', 'carer', 'racar', 'caers', 'racer']) == ['carer', 'racer']
p anagrams('laser', ['lazing', 'lazy',  'lacer']) == []

D:
-iterative structure to loop over the input array and compare each elements
to the input string
-new array object as return value

A:
-iterate over the input array, performing selection (#select)
on each iteration, sort the current array element and check if it's equal to
the string input sorted


def anagrams(string, array)
  array.select do |word|
    word.chars.sort == string.chars.sort
  end
end

p anagrams('abba', ['aabb', 'abcd', 'bbaa', 'dada']) == ['aabb', 'bbaa']
p anagrams('racer', ['crazer', 'carer', 'racar', 'caers', 'racer']) == ['carer', 'racer']
p anagrams('laser', ['lazing', 'lazy',  'lacer']) == []


29. Split Strings
(https://www.codewars.com/kata/515de9ae9dcfc28eb6000001)
6 kyu
Complete the solution so that it splits the string into pairs of two characters.
If the string contains an odd number of characters then it should replace the
missing second character of the final pair with an underscore ('_').

P:
write a method that takes a string an returns an array holding the input string
split into two-character string. If the final string holds only one character,
add '_'

input: string
return: array (holding input string split into 2-character strings)

rules:
-add '_' to final string if string.length == 1
- split input string into 2-character string
-store in array and return
-empty string should return empty array

E:
p solution('abc') == ['ab', 'c_']
p solution('abcdef') == ['ab', 'cd', 'ef']
p solution("abcdefg") == ["ab", "cd", "ef", "g_"]
p solution("") == []

D:
-iterative structure to loop over the input string
-array to hold substrings

A:
-initialize and empty array to hold result
-initialize placeholder
-split input string into an array of characters
-iterate over chars array with index
  -if placeholder string < 2
    -add current el
  -else,
    -add placeholder to substring array
    -reassign placeholder to current el
  -when iteration is complete, check if length of placeholder is 1
    -if one, add '_' and add to array
    -if 2, add to array


def solution(string)
  return [] if string.empty?
  result = []
  placeholder = ''
  string.chars.each do |el|
    if placeholder.length < 2
      placeholder << el
    else
      result << placeholder
      placeholder = el
    end
  end
    placeholder.length < 2 ? result << placeholder + '_' : result << placeholder
    result
end

def solution(string)
  return [] if string.empty?
  result = []
  string.chars.each_slice(2) { |pair| result.push(pair.join) }
  result.last << '_' if result.last.length == 1
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

P: write a method that takes two string and returns an integer identifying how
many numbers total need to be removed from each word to turn the strings into
anagram

input: 2 strings
return: integers (count of removed letters)

rules:
-all input will be lowercase letters
-return count of total letters removed frmo both words
-input can be an empty string
-if inputs are both empty or both are anagrams, return 0
-if strings contain no shared letters, all character will be removed
(to make mathcing empty strings)

E:
anagram_difference('', '') == 0
p anagram_difference('a', '') == 1
p anagram_difference('', 'a') == 1
p anagram_difference('ab', 'a') == 1
p anagram_difference('ab', 'ba') == 0
p anagram_difference('ab', 'cd') == 4
p anagram_difference('aab', 'a') == 2
p anagram_difference('a', 'aab') == 2
p anagram_difference('codewars', 'hackerrank') == 10

D:
-array to hold elements of one input string
-iterative structure to loop over the string array and compare it to the other input string
-array to hold the rejected letters (to be counted)

A:
-initialize empty array to hold rejected letters
-convert str1 into an array of chars

-iterate over array
-check if current element is included in str2
  -if not included, add element to rejected letters array
-convert str2 to an array of characters]
-iterate over str2 array
  -check if each letter is included in str1
    if not included, add to rejected letters array

-find and return count of rejected letter array

# works - refactored below to use helper method
def anagram_difference(str1, str2)

  rejected_letters = []
    str1.chars.each do |el|
      if !str2.include?(el) || str2.count(el) > str1.count(el)
        rejected_letters << el
      end
  end

  str2.chars.each do |el|
      if !str1.include?(el) || str1.count(el) > str2.count(el)
        rejected_letters << el
      end
  end

  rejected_letters.count
end


def letter_removal(str1, str2)
  rejected_letters = []

  str1.chars.each do |el|
    if !str2.include?(el) || str2.count(el) > str1.count(el)
      rejected_letters << el
    end
  end
  rejected_letters
end

def letter_removal(str1, str2)
  p str1.chars.reject do |el|
    str2.include?(el) || str1.count(el) < str2.count(el)
  end
end

def anagram_difference(str1, str2)
  #str1_rejects = letter_removal(str1, str2)
  #str2_rejects = letter_removal(str2, str1)
  #(str1_rejects + str2_rejects).count
  (letter_removal(str1, str2) + letter_removal(str2, str1)).count
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

P: write a method that takes two strings and returns a booelan -- true if the
input strings are anagram, false if not

input: 2 strings
output: boolean

rules:
-case should not consdier case
-identify whether the 2 input strings are anagrams

E:
p is_anagram('Creative', 'Reactive') == true
p is_anagram("foefet", "toffee") == true
p is_anagram("Buckethead", "DeathCubeK") == true
p is_anagram("Twoo", "WooT") == true
p is_anagram("dumble", "bumble") == false
p is_anagram("ound", "round") == false
p is_anagram("apple", "pale") == false

D:
-arrays to hold sorted chars in input strings

A:
-convert both input strings to downcased arrays of chars and sort
-compare whether the two sorted string ae the same
- if a truthy value is sufficiemt
  -return result of comparision
-if a true booleans must be returned:
  -coerce booelan using double not !!


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

P:
write a method that takes a string of words, calculates the score of each word
(with points coinciding with position in alphabet) and returns word with highest
score

input: string (of words)
output: string (single word with highest score)

rules:
-assume all input in valid
-assume all strings contain only lowercase letters and spaces
- assuming each string contains at least 2 words
-identify score of each word by equating each letter to its position in alphabet
and finding sum of each word's score
-letter value/score is equal to its index position + 1

E:
p high('man i need a taxi up to ubud') == 'taxi'
p high('what time are we climbing up the volcano') == 'volcano'
p high('take me to semynak') == 'semynak'
p high('aaa b') == 'aaa' -> [[1, 1, 1], [2]] -> [[3], [2]] -> 3 -> 'aaa'

D:
-array to hold each word from string input as element
-nested iterative structure to iterate over word array
  -pass each word into an inner iteration to find the score of each letter
-array holding letter scores grouped by word

other thoguhts -

A:
-initialize array all lower case letters
-split input string into an array split at the space, so each array element is a word
-iterate over the words array,
  -on each iteration, pass word into block
    -split word into an array of characters
      -iterate over letters array, performing transformation
      -on each iteration, find index of current element in the alphabet array
        and add 1 (since indices are 0-based and alphabet positions are 10-based)
-iterate over returned nested array of letter scores
  -sum the contents of each subarray
  -identify and return highest number

def high(string)
  alphabet = ('a'..'z').to_a
  word_array = string.split

  result = string.split.map do |word|
    word.chars.map do |el|
     alphabet.index(el) + 1
    end
  end

  word_scores = result.map { |subarr| subarr.sum }

  high_score = word_scores.max
  final_word = ""

  word_scores.map.with_index do |score, idx|
    if score == high_score
      final_word << word_array[idx]
    end
  end
  final_word
end

#the above works but it's so long. Wondering if it woruld be easier to save the
word-score pairs as a hash

def high(string)
  alphabet = ('a'..'z').to_a
  word_score_hash = {}

  string.split.map do |word|
    word_score_hash[word] = word.chars.map do |el|
      alphabet.index(el) + 1
    end
  end

p word_score_hash.map { |word, score_arr| word_score_hash[word] = score_arr.sum }
p word_score_hash.key(word_score_hash.values.max)
#  word_scores = result.map { |subarr| subarr.sum }

 # high_score = word_scores.max
  # final_word = ""

  # word_scores.map.with_index do |score, idx|
  #  if score == high_score
   #   final_word << word_array[idx]
   # end
  # end
  # final_word
end
p high('man i need a taxi up to ubud') == 'taxi'
p high('what time are we climbing up the volcano') == 'volcano'
p high('take me to semynak') == 'semynak'
p high('aaa b') == 'aaa'


33. Replace With Alphabet Position
(https://www.codewars.com/kata/546f922b54af40e1e90001da)
6 kyu
In this kata you are required to, given a string, replace every letter with its
position in the alphabet.

If anything in the text isn't a letter, ignore it and don't return it.

"a" = 1, "b" = 2, etc.

Example
alphabet_position("The sunset sets at twelve o' clock.")
Should return "20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12
15 3 11" (as a string)

P:
write a method that takes a string and replaces every letter with its position
in the alphabet

input: string
return: string (new string?)

rules:
-replace every letter in input string with the number indicating position in the
alphabet
-each number in the returns string should be separated by a space
-if string contains non-letter characters, ignore and DON'T return
-if the string contains no letters, return an empty string
-method is case insensitive

E:
alphabet_position("The sunset sets at twelve o' clock.") == "20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12 15 3 11"
alphabet_position("-.-'") == ""

D:
-array holding the aplhabet (to use index position to access alphabet positions)
-array to hold the chars in the input string
-iterative structure to loop over array of characters and replace each letter with an integer
-string (return value)

A:
-intiialize a rnage of a-z and convert to array
-downcase the input string
-convert the input string to an array of individual characters
-iterate over character array, performing selection
  - select all elements that appear in alphabet array
-iterate over character array, performing transformation
  -find alphabet array index of current character and + 1
-convert return array to a string with each element spearated by spaces
-edge cases -- should automatically return an empty string for input with no letters

def alphabet_position(string)
  alphabet = ('a'..'z').to_a

  letters = string.downcase.chars.select { |el| alphabet.include?(el) }
  letters.map { |el| alphabet.index(el) + 1 }.join(' ')
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

P:
write a method that takes mystery hash with names as keys and arrays of integers
as values, and also an array of integers. Return all hash keys whose values
contain any number not included in the input array.

input: pockets hash, array of integers
return: -array of hash keys

rules:
-if input integers array is empty, method will return all hash keys in array
-if all hash values are numbers included in input array, method will return nil
-if no hash/hash is empty, also return nil

E:
p find_suspects(pockets, [1, 2]) == [:tom, :jane]
p find_suspects(pockets, [1, 7, 5, 2]) == nil
p find_suspects(pockets, []) == [:bob, :tom, :jane]
p find_suspects(pockets, [7]) == [:bob, :tom]

D:
-pockets hash
-input integer array
-iterative structure to loop over hash vaules and compare them to integer array
-array for return value

A:
-if pockets hash == nil, return nil
-iterate over hash (with key and value as parameters)
-perform nested iteration over hash values
-check if #all? values are included in input integer array
  -if all values are not inlcuded, add hash key to the return array
-edge cases - if return array is empty, return nil

pockets = {
  bob: [1],
  tom: [2, 5],
  jane: [7]
}

def find_suspects(hash, array)
  return nil if hash == nil

  suspects = hash.select do |name, numbers|
    numbers.any? { |num| !array.include?(num) }
  end.keys

 suspects.size == 0 ? nil : suspects
 p hash.values.flatten.size
end

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

P:
write a method that takes a lwoercase string and returns an array in which
each element is the input string, but with single conseuctive letters upcased
beginning with the first letter in the first array element

input: string
return: array of strings

rules:
-all input will be lower
-input string can be empty
-input string can have spaces
-any spaces shouldbe ignored
-input string should appear in return array number of times indidcated by string length
-for first entry, first letter is capital. for second entry, second letter is capital, etc
-emtpy string should return an empty array

E:
p wave("hello") == ["Hello", "hEllo", "heLlo", "helLo", "hellO"]
p wave("codewars") == ["Codewars", "cOdewars", "coDewars", "codEwars", "codeWars", "codewArs", "codewaRs", "codewarS"]
p wave("") == []
p wave("two words") == ["Two words", "tWo words", "twO words", "two Words", "two wOrds", "two woRds", "two worDs", "two wordS"]
p wave(" gap ") == [" Gap ", " gAp ", " gaP "]

D:
-array of individual characters
iterative structure to loop over array with index

A
-initialize a result array empty
-iterate from 0 to input string length minus 1
-use integer as index
-if current element is not an empty space
-use index reference to capitalize element at current index

-push result to a result array
-return result array
-
-

def wave(string)
  result = []
  string.size.times do |idx|
    if el == " "
      next
    else
     result << string.sub(string[idx], string[idx].upcase)
   end
  end
  p result
end
p wave("hello") == ["Hello", "hEllo", "heLlo", "helLo", "hellO"]
p wave("codewars") == ["Codewars", "cOdewars", "coDewars", "codEwars", "codeWars", "codewArs", "codewaRs", "codewarS"]
p wave("") == []
p wave("two words") == ["Two words", "tWo words", "twO words", "two Words", "two wOrds", "two woRds", "two worDs", "two wordS"]
p wave(" gap ") == [" Gap ", " gAp ", " gaP "]

# the above didn't fully work - retying a few hours later

35. Mexican Wave
(https://www.codewars.com/kata/58f5c63f1e26ecda7e000029/train/ruby)
6 kyu

In this simple Kata your task is to create a function that turns a string into
a Mexican Wave. You will be passed a string and you must return that string in
an array where an uppercase letter is a person standing up.
Rules
1.  The input string will always be lower case but maybe empty.
2.  If the character in the string is whitespace then pass over it as if it was
an empty seat.

P:
write a emthod that that takes a string and returns and returns an array holding
copies of the input string. Each array element should have one letter uppercased
-first letter in first element, second letter in second element, etc

input: string
return: array (of string)

rules:
-input string will only contain lower case letters
-input string can contain spaces
-spaces should be ignored when counting for capitalization / length, but must
be included in the strings returned in the array
-input string can be empty
-when empty, method should return an empty array
-any spaces in the input string (including leadinga and trailing spaces) must be
included in return values

E:
p wave("hello") == ["Hello", "hEllo", "heLlo", "helLo", "hellO"]
p wave("codewars") == ["Codewars", "cOdewars", "coDewars", "codEwars", "codeWars", "codewArs", "codewaRs", "codewarS"]
p wave("") == []
p wave("two words") == ["Two words", "tWo words", "twO words", "two Words", "two wOrds", "two woRds", "two worDs", "two wordS"]
p wave(" gap ") == [" Gap ", " gAp ", " gaP "]

D:
-iterative structure
-return array

A:
-initiatize local variable size to result of converting the input string to an array of chars
-iterate from 0 up to but not including size
  -add input string to result array
-iterate over result array with indices (performing transformation?)
-if current
  -remove element of current word at current index (#slice!)
  -re-insert removed element (#insert) capitalized
-return mutated array
-empty ?

def wave(string)
  return [] if string.empty?
  size = string.chars.delete_if { |el| el == ' ' }.size
  result = []

  size.times { |_| result << string }
  result = result.map.with_index do |el, ind|
  p el.split.map do |letter|
    if result.index
  waver = el.slice(ind)
   p el.insert(ind, waver.upcase)

  end
p result
end

p wave("hello") #== ["Hello", "hEllo", "heLlo", "helLo", "hellO"]
p wave("codewars") == ["Codewars", "cOdewars", "coDewars", "codEwars", "codeWars", "codewArs", "codewaRs", "codewarS"]
p wave("") == []
p wave("two words") == ["Two words", "tWo words", "twO words", "two Words", "two wOrds", "two woRds", "two worDs", "two wordS"]
p wave(" gap ") == [" Gap ", " gAp ", " gaP "]

# wow have made a huge mess of that

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

P:
write a method that takes an integers and returns the largest possible integer
that can be obtains by deleting one digit from the input integer

input: integer
output: integer

rules:
-find all combinations of the input integer with one digit removed
-return the largest integer made by removing one digit from the input integer
-input integer will be greater than or equal to ten (no negative, 0, or 1-digit inputs)
-input integer will be less than or equal to 1,000,000
-return integer can occur more than once (doesn't matter which is returned)
-return value will never be 0

E:
p delete_digit(152) == 52
p delete_digit(1001) == 101
p delete_digit(10) == 1

D:
-array of digits from the input integer
-interative strucutre to loop of the digits array and create a new array holding
  each version of the input integer with 1 digit removed

A:
-convert input integer to an array of digits (#digits #reverse)
-iterate over digits array with index performing transformation
  -convert input integer to string
  -delete element at current index
  -convert back to integer
  -populate combination array with modified digit
-find and return larger integer in combination array

def delete_digit(int)
  digits_arr = int.digits.reverse
  combos = digits_arr.map.with_index do |num, idx|
    new = digits_arr.dup
    new.delete_at(idx)
    new.join.to_i
  end
  combos.max
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

P:
write a method that take an integer, identifies the number of multiples of 3 and
5 less than the input integer, sums the selected multiples, and returns
the sum

input: integer
return: integer

rules:
-collect all integers less than the input integer that are multiples of
3 or 5
-if a number is a multiple fo both 3 and 5, only count it once
-sum all multiples and return sum
-assumptions - valid input, greater than zero?

E:
p solution(10) == 23
p solution(20) == 78
p solution(200) == 9168

D:
iterative structure to loop from 1 up to one less than the input integer, select
all numbers that are multiples of 3 or 5, sum, and return

A:
-set range from 1..input integer
-iterate over range, performing selection
  -select current integer if it's a multiple or 3 or 5
-sum the array of selected integers
-return sum

def solution(int)
  (0...int).select do |num|
    num % 3 == 0 || num % 5 == 0
  end.sum
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

P;
write a method that takes a string and reverese the case of each letter and the
order of all all words, keeping all spaces intact

input: string
return new string

rules:
-reverse case of each letter
-reverse order of words
-don't alter spaces
-can contain leading and trailing spaces

E:
"Example Input" ==> "iNPUT eXAMPLE"
'Example string' ==> 'STRING eXAMPLE'

D:
-array of all characters in input string (#char) - include all spaces
-iterative structure to loop over the array of char and reverse case
-

A:
-convert input string to an array of individual characters
-iterate over the characters array performing transforming
  -if current element is not a space
    -if current element upcase does not equal current element
      current element upcase
    -else if current element downcase does not equal current element
      current element downcase

--returning array now holds all spaces and correctly capitalized letters

-split returned array at the spaces and save as a variable
-reverse order of words in spaceless-copy

#not solved -- cannot figure out how to reverse word order while maintiaining
leading and trailing spaces

def string_transformer(string)
  p char_array = string.chars
 adjusted_chars =  char_array.map do |el|
    if el == ' '
      el
    else
      if el.downcase != el
        el.downcase
      elsif el.upcase != el
        el.upcase
      end
    end
  end
p  adjusted_string = adjusted_chars.join
 reversed_words =  adjusted_string.split.reverse.join(' ')
 adjusted_string
end

p string_transformer(" Example Input ") #== "iNPUT eXAMPLE"

39. Largest product in a series
(https://www.codewars.com/kata/529872bdd0f550a06b00026e/train/ruby)
6 kyu
Complete the greatestProduct method so that it'll find the greatest product of
five consecutive digits in the given string of digits.

For example:

greatestProduct("123834539327238239583") // should return 3240
The input string always has more than five digits.

P:
write a method that takes a string integer, calculates the product of each set
of 5 consecutive integers, and returns the greatest product

input: string (of digits)
return: integer

rules:
-input string will always contain at least 6 digits
-assume that input string will never hold only zeros?
-return value can be 0

E:
p greatest_product("123834539327238239583") == 3240
p greatest_product("395831238345393272382") == 3240
p greatest_product("92494737828244222221111111532909999") == 5292
p greatest_product("92494737828244222221111111532909999") == 5292
p greatest_product("02494037820244202221011110532909999") == 0

D:
-iterative structure to loop over 5-element slices of the input string
and calculate sum
-result string
-placeholder string

A:
-iterate over a range from 0 up to the size of the input string - 5
    -each number represents index
  -take a slice of the input string starting at current index and with a length of 5
    -convert to an integer
    -convert to array of digits
    -multiply all digits in the array
    -add product to products array
  -find and return largest integer in number array


def greatest_product(string)
  product_array = []
  (0..string.size - 5).each do |idx|
   p slice = string.slice(idx, 5)
     product_array << slice.to_i.digits.reduce { |total, num| p total *= num }
  end
 product_array.max
end

#p greatest_product("123834539327238239583") == 3240
#p greatest_product("395831238345393272382") == 3240
#p greatest_product("92494737828244222221111111532909999") == 5292
#p greatest_product("92494737828244222221111111532909999") == 5292
p greatest_product("02494037820244202221011110532909999") == 0

#ugh, not sure why last 3 arent passing -- multiplcation with the zeros isn't happening right

40. Duplicate Encoder
(https://www.codewars.com/kata/54b42f9314d9229fd6000d9c/train/ruby)
6 kyu
The goal of this exercise is to convert a string to a new string where each
character in the new string is "(" if that character appears only once in the
original string, or ")" if that character appears more than once in the original
string. Ignore capitalization when determining if a character is a duplicate.


P:
write a methd that takes a string and return a new string composed only of
parentheses: opening ( if a char appears only once, and closing ) if it appears
more than once.

input: string (of letters)
return: a string of ( and )

rules:
-first each character in char, replace with ( if count == 1 and ) if count is > 1
-method should be case insensitive (A and a both count for A/a)
-string can contain any type of character
-string can contain spaces
-spaces should be counted and replaced like any character

Examples
"din"      =>  "((("
"recede"   =>  "()()()"
"Success"  =>  ")())())"
"(( @"     =>  "))(("

D:
-array of all chars in the input string
-iterative structure to loop of the chars array, identify count of each character,
and return either ( or )
-count add to stirng/array (array returned by iteration)
-string for return

A:
FORGOT TO DOWNCASE
-convert input string to an array of individual characters
-iterate over the input array, performing transformation
  -check the count of the current character in the input string
  -if count == 1, return '('
  -else return ')'
-convert array of () back to a string

def duplicate_encode(string)
  char_array = string.downcase.chars
  char_array.map { |el| string.downcase.count(el) == 1 ? '(' : ')' }.join
end

p duplicate_encode("din") == "((("
p duplicate_encode("recede") == "()()()"
p duplicate_encode("Success") == ")())())"
p duplicate_encode("(( @") == "))(("

41. Backspaces in string
(https://www.codewars.com/kata/5727bb0fe81185ae62000ae3/train/ruby)
6 kyu
Assume "#" is like a backspace in string. This means that string "a#bc#d"
actually is "bd"

Your task is to process a string with "#" symbols.

P:
write a method that takes a string of chars and # symbols and deletes every
char followed by a #

input: string
return: string

rule:
-when # follows a character, the character and # should be deleted
-after deletion, if # now follows another character, that char and # must also be deleted
-can return an empty string
-should return a string with # contained
-if only # is left in the string, delete all and return empty string

Examples
"abc#d##c"      ==>  "ac"
"abc##d######"  ==>  ""
"#######"       ==>  ""
""              ==>  ""

D:
-iteratate structue to continue looping over input until all # and preceding letter
have been deleted
-array of chars ot hold input
-return string

A:
-convert input string to an array of chars
-iterate over chars array with index performing transformation
  -if current element equals #
    -replace element with ''
    - replace current index - 1 with '' (first iteration?)
  -if all elements of array are #
  -return empty string
-if current element includes #,
    -repeat iteration until no # are left
  -retrn string

=end
#tried using loop - havent done that in a while, isnt working
=begin
def clean_string(string)
  chars_array = string.chars
  counter = 0

  loop do
    break if string.empty? || !string.include?('#') || counter >= string.size - 2
    if string[counter + 1] == '#'
      string[counter] = ''
      string[counter + 1] = ''
      counter += 1
    end
  end
  string
end

def cleaner!(str)
  chars = str.chars
  result = chars.map.with_index do |el, idx|
    p chars
    if el == '#'
      chars.delete_at(idx)
      chars.delete_at(idx - 1)
    else
      el
    end
  end
  result
end

def clean_string(string)
  result =[]
  loop do
    break if !result.include?('#')
   p result = cleaner!(str)
  end
  p result.join
end
p clean_string('abc#d##c') == "ac"
p clean_string('abc####d##c#') == ""


42. Sort Arrays (Ignoring Case)
(https://www.codewars.com/kata/51f41fe7e8f176e70d0002b9/train/ruby)
6 kyu
Sort the given strings in alphabetical order, case insensitive. For example:

["Hello", "there", "I'm", "fine"]  -->  ["fine", "Hello", "I'm", "there"]
["C", "d", "a", "B"])              -->  ["a", "B", "C", "d"]

P:
write a method thattakes an array of string and returns that array sorted,
ignoring case

input: array of strings
output: same? array of strings

rules:
-sort the given array and return
-ignore case

D:
iterative structure to sort array contents

E:
["Hello", "there", "I'm", "fine"]  -->  ["fine", "Hello", "I'm", "there"]
["C", "d", "a", "B"])              -->  ["a", "B", "C", "d"]

A:
sort over an array using a block
-within block, downcase each element and sort


def sortme(arr)
  arr.sort { |a, b| a.downcase <=> b.downcase }
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

P:
write a method that takes and array of positive integers, sums them, and returns
the integer needed to make the array sum equal the nearest (greater) prime number

input: array of positive integers (to be summed)
output: integer (positive) (represent distance to next prime number)

rules:
-sum array, return integer representing difference between array sum and the next prime number
-all numbers are positve
-numbers in the array can be repeated
-input array will have at least two elements

E:
({50,39,49,6,17,28}) ==> return (2)
({2,12,8,4,6}) ==> return (5)
({3,1,2}) ==> return (1)

D:
iterative strucutre to sum array contents
-loop to add a 1 to array sum, check if prime:
  if prime, return
else (not prime)
  -add another 1 and check againe

A:
-find the sum of the input array
  -#sum
  -#reduce/#inject
-initialize loop
-set break condition (break if current sum is a prime number)
-reassign digits sum to reference digits sum plus 1
-check if digits sum is a prime number
  X-if we had a limit, could initialize an array of prime, but there's not limit
  -set up an interative structure that loops from 1 up to digits sum / 2
    -check if each num % digits_sum == 0
    - if #all? iteraions are false, number must be prime
    -prime?
-once prime number is reached, lop will exit
- substract sum of the array from the current digits to finda nd return difference

def minimum_number(arr)
  digit_sum = arr.sum

  loop do
    break if (1..digit_sum / 2).all? { |num| !(digit_sum % num == 0) }
    digit_sum += 1
  end

  digit_sum - arr.sum

end

p minimum_number([3,1,2]) #== 1
p minimum_number([5,2]) #== 0
p minimum_number([1,1,1]) #== 0
p minimum_number([2,12,8,4,6]) #== 5
p minimum_number([50,39,49,6,17,28]) #== 2

retrying Mexican Wave again - 3/31

P:
Write a method that takes a string as input and places it into an array the same number
as times as letter characters in the input string. Upcase each string element
at the index position that coincides with the string's position in the array.


input: string
output: array (containing copies of the index string)

rules:
-for each copy of input string, create copy of string and place in array to be returned
-each string element in the array should have one letter upcased
-letters should be upcased consecutively, with one upcase per string
-input letters will always be lowercase
-input can be an empty string
-when input is an empty string, return empty array
-input string may contain spaces
-spaces should be ignored when counting string characters for upcasing
-input strings can have leading and trailing spaces
-all spaces should be maintained in the strings appearing in the array

question -- can the input string contain non-letter characters?

E:
p wave("hello") == ["Hello", "hEllo", "heLlo", "helLo", "hellO"]
p wave("codewars") == ["Codewars", "cOdewars", "coDewars", "codEwars", "codeWars", "codewArs", "codewaRs", "codewarS"]
p wave("") == []
p wave("two words") == ["Two words", "tWo words", "twO words", "two Words", "two wOrds", "two woRds", "two worDs", "two wordS"]
p wave(" gap ") == [" Gap ", " gAp ", " gaP "]

D:
-array for return value
-iterative structure to loop over string perform capitalization, and add to array
-control flow structure to examine whether a string element is a letter or a space

A:
-initialize empty result array
-iterate from 0 up to one less than the size of the string (#times, #size)
-create a control flow structure (if/else)
  -if current element is is not included in the range a-z, skip to next iteration (next)
  -else:
      1. use index reference to access and upcase the string element at the current index position
      2. concatenate the upcase element to any preceding and following slices of the string
      3. apprend to result array
-return result array

def wave(string)
  result = []
  string.each_char.with_index do |el, idx|
    if !('a'..'z').include?(el)
      next
    else
  #  result << string[0...idx] + string[idx].upcase + string[idx.next..-1]
     result
  p    el.upcase
  p string
    end
  end
#  result
end
p wave("hello") == ["Hello", "hEllo", "heLlo", "helLo", "hellO"]
p wave("codewars") == ["Codewars", "cOdewars", "coDewars", "codEwars", "codeWars", "codewArs", "codewaRs", "codewarS"]
p wave("") == []
p wave("two words") == ["Two words", "tWo words", "twO words", "two Words", "two wOrds", "two woRds", "two worDs", "two wordS"]
p wave(" gap ") == [" Gap ", " gAp ", " gaP "]

36. Delete a Digit

Given an integer n, find the maximal number you can obtain by deleting exactly one digit of the given number.

Example
For n = 152, the output should be 52;

For n = 1001, the output should be 101.

Input/Output
[input] integer n

Constraints: 10 ≤ n ≤ 1000000.

[output] an integer

P: wrtie a method that takes an integer and greatest number that can be formed
by deleting one digit in the input integer

input: integer
return: integer

rules
-return the greatest number than can be created by deleting one digit
-aside from deleted digits, other digits must remain in the order in whcih they
appear in the input integer
-input integer will be at least 2 digits
-input integer range is 10 ≤ n ≤ 1_000_000

E:
For n = 152, -> [52, 12, 150 -> the output should be 52;
For n = 1001,-> [001, 101, 101, 100]  -> the output should be 101.
delete_digit(10) - [1,0] ->  1

D:
-string verison of input integer
-array to hold all combinations of input inter with one digit deleted
-iterative structure to loop over the string number and collect all permutations
-sorting structure to find the greatest string number

A:
-convert input integer to string_num
-initialize empty combinations array
-iterate over string_num indices (#times)
  -concatenate slices of the string that proceed and follow the current index
  -convert to integer
  -append to comb_arr
-sort comb_arr array and return largest integer (#max)

def delete_digit(int)
  int = int.to_s
  comb_arr = []
  int.size.times do |idx|
    comb_arr << (int[0...idx] + int[idx.succ..-1]).to_i
  end
  comb_arr.max
end

p delete_digit(152) == 52
p delete_digit(1001) == 101
p delete_digit(10) == 1


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
write takes a string and returns a new string with the case of each letter reversed

input: string
output: new string

rules:
-returned string should be new object
-reverse case of each letter in input string
-assume input only contains letters and spaces
-input can have mulitiple spaces and leading or trailing spaces

D:
iterative structure to loop over input string
string for return

A:
-initialize empty result string
-iterate over each character of input string (#each_chars)
  Option 1:
  -swap case of each element (#swapcase)
  -append each element to result string
  at end of iteration, return result string
  Option 2:
    -if element is a space
      -append to result string
      -skip to next iteration
    -elsif element is included in range A-Z
      -downcase element
      -append to result sting
    - else (element is included in range a-z)
        -upcase element
        -apprend to result string
-return result string

#failed to read instruction propery - took a break, trtrying below
def string_transformer(string)
  result = ''
  string.each_char do |el|
    result.insert(0, el.swapcase)
  end
  result
end

p string_transformer('Example string') # == 'STRING eXAMPLE'


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
write a method that takes a string and returns a new string. In the new string,
1. reverse the order of words and 2. reverse the order of each word

input: string
output: new string (with case and word order reverse)

rules:
-reverse order of words
-reverse care of each letter
-do not reverse order of letters in a word
-input string will only contain lower case letters and spaces
-can contain leading and trailing spaces
  -'handle' - assuming these should be maintained in the output string

##cannot figure this out. Proceed without concern for leading trailing spaces for now

E:
string_transformer('Example string') # == 'STRING eXAMPLE'
' cat DOG fRoG ' -> ' FrOg dog CAT '

D:
-array of words from inputs string
-nested iterative structure to access words and then letter to swap case
string to return

A:
-transform input string to array of words
-initilaize empty result_arr array
-iterate over array of words
  -on each iteration, iterate over word, performing transformation
    -in inner iteration, reverse the case of each letter
      -*can do this using #swapcase
      -can also do this with and if/elsif/else, and the ranges a-z and A-Z
    -prepend return value of inner iteration (word with case reversed) to result_arr
      -unshift or #insert(idx, el) or #prepend
-join result array with spaces
-can check first and last els of input string to see if leading/trailing spaces
need to be added to the return string

#ugh does not work for multiple spaces between words
def string_transformer(string)
  words_arr = string.split
   result_arr = []
   words_arr.each do |word|
  p  result_arr.prepend(word.chars.map do |letter|
       letter.swapcase
     end.join)
   end
   result_arr.join(' ')
end


#mini pedac:
-initialize a result string
-moved above code to a help method reverses the case of each letter
-compare input string chars and index to string with letter case reversed
  -if both els at same index are a space or both all are included in range a-z
    -append to result string
  -else (meaning input string has a space where result string is missing one)
    -append a space to result string
    -append current el to result string
-return result string

def reverse_letter_case(string)
  words_arr = string.split
   result_arr = []
   words_arr.each do |word|
    result_arr.prepend(word.chars.map do |letter|
       letter.swapcase
     end.join)
   end
   result_arr.join(' ')
end

LETTERS = (('A'..'Z').to_a << ('a'..'z').to_a).flatten

def string_transformer(string)
  case_swapped_string = reverse_letter_case(string)
 # result_string = ''

  string.each_char.with_index do |el, idx|
    if el == case_swapped_string[idx] #will only return true for spaces and coinciding letters
   #   result_string << el
   next
    elsif
      LETTERS.include?(el) && LETTERS.include?(case_swapped_string[idx])
   #   result_string << el
   next
 else
   case_swapped_string.insert(idx, ' ')
    end
  end
case_swapped_string
end

p string_transformer(' Example string ')  #== 'STRING eXAMPLE'

this can turned into a major mess. My logic here is all wrong -- since we
swapped the words and the words have different lengths, the saces will not align
really no idea


39. Largest product in a series
(https://www.codewars.com/kata/529872bdd0f550a06b00026e/train/ruby)
6 kyu
Complete the greatestProduct method so that it'll find the greatest product of
five consecutive digits in the given string of digits.

For example:

greatestProduct("123834539327238239583") // should return 3240
The input string always has more than five digits.

P:
write a method that takes a string of digits and find the greatest product of 5
consecutive digits

input: string of numbers
return: integer

rules:
-find greatest product of 5 consecutive digits in a string and return product
as an integer
-input string will always have at least 5 digits in string

D:
-iterative structure to loop over input string and find product of each slice of
5 consecutive digits
-array to hold products

A:
-initialize empty products array
iterate from 0 to one less than the size of the input string - 5
-on each iteration, take a slice of input string starting at current index
with a length of 5
-save as variable slice
-convert to integer
-convert to array of digits (and reverse)
-find product of all numbers in digits array
-append product to products array
-find and return largest number in products array

#1234567 -length = 7; index position = 6
def greatest_product(num_string)
  products_arr = []
  (0..num_string.size - 5).each do |idx|
    num_slice = num_string[idx, 5]
    int = num_slice.chars.map do |num|
      num.to_i
    end
    int.reverse.inject do |total, num|
      products_arr << total * num
  end
end
   products_arr#.max
end

#p greatest_product("123834539327238239583") #== 3240
#p greatest_product("395831238345393272382") == 3240
#p greatest_product("92494737828244222221111111532909999") #== 5292
p greatest_product("02494037820244202221011110532909999") #== 0

40. Duplicate Encoder
(https://www.codewars.com/kata/54b42f9314d9229fd6000d9c/train/ruby)
6 kyu
The goal of this exercise is to convert a string to a new string where each
character in the new string is "(" if that character appears only once in the
original string, or ")" if that character appears more than once in the original
string. Ignore capitalization when determining if a character is a duplicate.


P:
write a method that transforms a string to sequence of opening and closing
parentheses based on whether the character appears one or more than once

input: string (upper or lowercase letters)
return: string (composed only of opening and closing ())

rules:
-if a letter appears in the string only once, replace with '('
-if a letter appears in the string more than once, replace with ')'
-method should be case-insensitive
-input string can contain non-letter chars and spaces - these should also be counted

Examples
"din"      =>  "((("
"recede"   =>  "()()()"
"Success"  =>  ")())())"
"(( @"     =>  "))(("

D:
iterative structure to perform trasformation
control flow statement to determine count of char and its corresponding return character

A:
-convert input string to an array of all characters, including spaces (#chars)
-iterative over the chars_arr, performing transformation (#map)
-initiate control flow within block
  if count of the current element in the input string is 1
    -return '('
  else
    -return ')'
join the transformed array back to string

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

P:
write a method that takes a string an delete each # as well as the character
preceeding the #

input: string
return: string (new or same object?)

rules:
-# means delete preceeding char
-letters and # are not in corresponding order
-input can be emptry string
-empty string input should return empty string

notes:
-loop over string, deleting # and preceedings char
-repeat until no # are left
-if remaining string only contains #, return empty string

Examples
"abc#d##c"      ==>  "ac"
"abc##d######"  ==>  ""
"#######"       ==>  ""
""              ==>  ""

D:
-loop over repeatedly itertive over string until all # are gone or string only contains #

A:
initialize outer counter to 0
initilaize loop
-iterate over each char in string with index (#each_char, #with_index)
-if current element is a #
  -delete char and char at previous index
  break if !string.include?(# ) or if all elements in string are #
if all elements re #, return empty string
-else, return string

=end

def clean_string(string)
  loop do
    break if !string.include?('#') || string.chars.all? {|el| el == '#' }
  counter = 0
  loop do
    break if counter >= string.size
    string.each_char.with_index do |el, idx|
      if el == '#'
        string.delete_at(idx-1) && string.chars.delete_at(idx)
      else
        next
      end

    end
    counter += 1

  end
end
string.include?('#') ? '' : string
end

p clean_string('abc#d##c') == "ac"
p clean_string('abc####d##c#') == ""


