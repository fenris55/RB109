=begin
Codewars problems recemmended in the 109 study guide

1. Count letters in string
In this kata, you've to count lowercase letters in a given string and return
the letter count in a hash with 'letter' as key and count as 'value'. The key
must be 'symbol' instead of string in Ruby.

P:
write a method that takes a string and return a hash with each letter in the string
as a key and the count of each letter as the value

input: string
return: hash

rule:
-create a hash with each letter from the input strign as a key and coutn of each
letter as value
-letter keys should be symbols, not strings
-assume input is lowercase
-in return hash, key should be in alphabetical order

E:
letter_count('codewars') == {:a=>1, :c=>1, :d=>1, :e=>1, :o=>1, :r=>1, :s=>1, :w=>1})
letter_count('activity') == {:a=>1, :c=>1, :i=>2, :t=>2, :v=>1, :y=>1})
letter_count('arithmetics') == {:a=>1, :c=>1, :e=>1, :h=>1, :i=>2, :m=>1, :r=>1, :s=>1, :t=>2})

D:
-hash to hold letter/symbols and counts
-iterative structure to loop over input string, convert each string to a symbol,
  and convert symbol to hash key and its count in input string to a value

A:
-initialize empty result hash with default value of 0
-iterate over each character in input string
  -use hash reference to assign the current element converted to a symbol as a hash
  key with value set to the count of the current element in the input array

@#this works, refactign below
def letter_count(string)
  result = Hash.new(0)
  string.each_char do |el|
    result[el.to_sym] = string.count(el)
  end
 result
end

#works, shorter
def letter_count(string)
 string.chars.each_with_object({}) do |el, hash|
  hash[el.to_sym] = string.count(el)
  end

end
p letter_count('codewars') == {:a=>1, :c=>1, :d=>1, :e=>1, :o=>1, :r=>1, :s=>1, :w=>1}
p letter_count('activity') == {:a=>1, :c=>1, :i=>2, :t=>2, :v=>1, :y=>1}
p letter_count('arithmetics') == {:a=>1, :c=>1, :e=>1, :h=>1, :i=>2, :m=>1, :r=>1, :s=>1, :t=>2}


2.
Find all pairs (retired)

You are given array of integers, your task will be to count all pairs in that
array and return their count.

Notes:

Array can be empty or contain only one value; in this case return 0
If there are more pairs of a certain number, count each pair only once. E.g.:
for [0, 0, 0, 0] the return value is 2 (= 2 pairs of 0s)
Random tests: maximum array length is 1000, range of values in array is between
0 and 1000

P:
write a method that takes an array of integers and returns the number of pairs
in that array

input: array (of integers)
return: integer

rules:
-return count of pairs in array
-a pair is 2 of the same number
-the same number can be paired multiple times
-empty and 1-element array should return empty array

E:
pairs([1, 2, 5, 6, 5, 2]) == 2
pairs([1, 2, 2, 20, 6, 20, 2, 6, 2]) == 4
pairs([0, 0, 0, 0, 0, 0, 0]) == 3
pairs([1000, 1000]) == 1
pairs([]) == 0
pairs([54]) == 0

D:
iterative structure to loop over input array

A:
-initialize counts variable to 0
-iterate over an array of uniq character from input string (so that each number
is only counted once)
  -save count variable to count of current element in input array
  -if the count of current character in input array is greater than 1
    -divide count by 2 and save as current_pair_count-> integer division will return the number of times 2 goes
      into the count; can also call divmod and the access the 1st array element
    -increment count variable by the current_pair_count
  else (cont is less than 2)
    next
return counts

def pairs(arr)
  counts = 0
  arr.uniq.each do |num|
    count = arr.count(num)
    if count > 1
      current_pair_count = count / 2
      counts += current_pair_count
    else
      next
    end
  end
  counts
end

#works, refactoring again
def pairs(arr)
  result = 0
  counts = arr.uniq.map { |num| arr.count(num).divmod(2) }
  counts.each { |subarr| result += subarr[0] }
  result
end


def pairs(arr)
 arr.uniq.map { |num| arr.count(num) / 2 }.sum
end

p pairs([1, 2, 5, 6, 5, 2]) #== 2
p pairs([1, 2, 2, 20, 6, 20, 2, 6, 2]) #== 4
p pairs([0, 0, 0, 0, 0, 0, 0]) #== 3
p pairs([1000, 1000]) #== 1
p pairs([]) #== 0
p pairs([54]) #== 0

3. Return substring instance count

Complete the solution so that it returns the number of times the search_text is
found within the full_text.

p:
write a method that takes 2 strings and returns the count of the times the second
string appears within the first string

input: 2 strings
return: integer (count)

rules:
-find number of times str2 (search_text) appear in str1 (full_text)
-in test cases, all input is only lowercase letters - no spaces, non-letter chars
-case sensitivity

Questions: assume input string only hold lower case letters?
-what counts as an occurrence - is bbb 1 or 2 occurences of bb??


E:
solution('aa_bb_cc_dd_bb_e', 'bb') == 2 #since bb shows up twice
solution('aaabbbcccc', 'bbb') == 1
solution('abcdeb','b') == 2
solution('abcdeb', 'a') == 1
solution('abbc', 'bb') == 1

D:
-iterative structure to create subsarray
-iterative structure to find the count of substrings that match the search text

A:
create substrings:
  -initialize substring array
  -save the size of the search_text to substring_size
  -iterate from 0 up to the size of the full_text string minus substring size (index)
    -take a slice of the search text starting at current index with a length of substring size (substring)
    append substring to substring_array
-find count of elements in substring_array that match the search_text
-return count

#works - trying below with gsub
def solution(full_text, search_text)
  substring_array = []
  substring_size = search_text.size
  ending_index = full_text.size - substring_size

  0.upto(ending_index).each do |index|
    substring_array << full_text.slice(index, substring_size)
  end

  substring_array.count { |ss| ss == search_text }
end

#does not work -
#################Ask about in session -- split down to search_text only -- is
#there a way to find the count occurence without creating substrings?

def solution(full_text, search_text)
  full_text.gsub!(/[^#{search_text}]/, '')
end

p solution('aa_bb_cc_dd_bb_e', 'bb') #== 2 #since bb shows up twice
p solution('aaabbbcccc', 'bbb') == 1
p solution('abcdeb','b') == 2
p solution('abcdeb', 'a') == 1
p solution('abbc', 'bb') == 1


4. Longest vowel chain
The vowel substrings in the word codewarriors are o,e,a,io. The longest of these
has a length of 2. Given a lowercase string that has alphabetic characters only
(both vowels and consonants) and no spaces, return the length of the longest
vowel substring. Vowels are any of aeiou.

P:
-write a method that takes a string and returns the length of the longest vowel
substring

input: string
return: integer

rules:
-find and return length of longest vowel substring
-vowels are only aeiou
-input will only be lowercase letters with no spaces

E:
solve("codewarriors") == 2
solve("suoidea") == 3
solve("iuuvgheaae") == 4
solve("ultrarevolutionariees") == 3
solve("strengthlessnesses") == 1
solve("cuboideonavicuare") == 2
solve("chrononhotonthuooaos") == 5
solve("iiihoovaeaaaoougjyaw") == 8

D:
-array of vowels
helper method: (get_vowel_substrings)
  -iterative structure to get all substrings
  -iterative structure to filter for substring that only include vowels
iterative structure sort vowel substrings, return the largest, and find the size

A:
create helper method: get_vowel_substrings
  -initialize array of vowels
  - initialize empty (all_substrings) array
  -get all substrings from input string
  -iterate over all_substrings, performing selection (vowel_substrings)
    -check if all letters in each substring are included in the vowels array
  -return vowel_substrings frmo helper method
find and return length of largest vowel substring:
  -sort vowel_substring array
  -access last element in sort array and return the length

#return to this -- had a hard time with the substring helper -- couldn't get the
indices correct
# also, seems like it doesn't need to be so long
def get_all_substrings(string)
  all_substrings = []
  (0...string.length).each do |index|
    (1..string.length - index).each do |length|
     all_substrings << string[index, length]
    end
  end
all_substrings
end

def get_vowel_substrings(substring_array)
  vowels = %w(a e i o u)
  vowel_substrings = substring_array.select do |ss|
     ss.chars.all? { |letter| vowels.include?(letter) }
  end
  vowel_substrings
end

def solve(string)
  all_substrings = get_all_substrings(string)
  vowel_substrings = get_vowel_substrings(all_substrings)
  vowel_substrings.sort_by { |ss| ss.size }.last.size
end

p solve("codewarriors") == 2
p solve("suoidea") == 3
p solve("iuuvgheaae") == 4
p solve("ultrarevolutionariees") == 3
p solve("strengthlessnesses") == 1
p solve("cuboideonavicuare") == 2
p solve("chrononhotonthuooaos") == 5
p solve("iiihoovaeaaaoougjyaw") == 8


5. Non-even substrings

Given a string of integers, return the number of odd-numbered substrings that
can be formed. For example, in the case of "1341", they are 1, 1, 3, 13, 41, 341, 1341, a total
of 7 numbers.

P:
write a method that takes a string number and returns the count of substrings
representing odd numbers

input: string (of numbers)
return: integer (count of odd number substrings)

rules:
-find all substrings
-select substrings that are odd numbers when converted to an integer
-return count of odd number substrings

E:
solve("1341") == 7
solve("1357") == 10
solve("13471") == 12
solve("134721") == 13
solve("13472315") == 28

D:
-iterative structure to get all substrings
-iterative strucure to select substrings that are odd numbers wehn converted to an
integer

A:
-initialize empty all_substrings array
-iterate over input string
  -iterate from 0 to the input string size - 1 (index)
    -iterate from 1 up to but not including the size of the input string minus the
    current index (length)
    -take a slice of the input string beginng at index with a length of length
    -add each substring slice to the all_substrings array
-iterate over all_substrings, performing selection (odd_substrings)
  -convert current substring to integer
  -check if integer is odd
-find and return the size of the odd_substrings array


def solve(string)
  all_substrings = []
  (0...string.size).each do |index|
    (1..string.size - index).each do |length|
    all_substrings<< string[index, length]
    end
  end
  odd_substrings = all_substrings.select do |ss|
    ss.to_i.odd?
  end
  odd_substrings.size
end

p solve("1341") == 7
p solve("1357") == 10
p solve("13471") == 12
p solve("134721") == 13
p solve("13472315") == 28

6. Repeated Substring

For a given nonempty string s find a minimum substring t and the maximum number
k, such that the entire string s is equal to t repeated k times.
The input string consists of lowercase latin letters.
Your function should return : an array [t, k] (in Ruby and JavaScript)

P:
write a method that takes a string and find the smallest subtring that can be
repeated to form the entire input string. return the selected substring and the
number of repeats required to form the input string in an array

input: string
return: array (substring and count)

rules:
-find the smallest substring that can be repeated to form the input string
-find the number of times the selected substring must be repeated to form the input string
-return both the substring and count in an array
-when no smallest substring exists, return the entire input string with a count of 1

E:
f("ababab") == ["ab", 3]
'a' -> 'a' * input string.size == input_string? false
'ab' => 'ab'* input_string.size / ss.size == input_string? true

f("abcde") == ["abcde", 1]

D:
-array of all substrings

A:
-initialize empty all_substrings array
  -iterate over a range from 0 up to the size of the input string, exclusive (index)
    -iterate over a range from 1 up to the size of the input string minus the current index, inlcusive (length)
      -take a slice of the input string starting at current index with a length of length
      -add each substring to all_substrigns array
-iterate over all_substrings array, performing selection -> (valid_substrings)
  -check if current substring, multiplied by (the input string size divided by the substring size)
  is equal to the input string
  -initialize result array
-sort valid_substrings by size
  -select the first element from the sorted array and add to result array
  -find the count of the first element in the sorted array and add to result array
-return result array

def f(string)
  all_substrings = []
  (0...string.size).each do |index|
    (1..string.size - index).each do |length|
     all_substrings << string[index, length]
    end
  end

  valid_substrings = all_substrings.select do |ss|
    ss * (string.size / ss.size) == string
  end

  result = []
  result << valid_substrings.first
  result << string.size / valid_substrings.first.size
  result
end

p f("ababab") == ["ab", 3]
p f("abcde") == ["abcde", 1]

7. Detect Pangram

A pangram is a sentence that contains every single letter of the alphabet at
least once. For example, the sentence "The quick brown fox jumps over the lazy
dog" is a pangram, because it uses the letters A-Z at least once (case is
irrelevant). Given a string, detect whether or not it is a pangram.
Return True if it is, False if not. Ignore numbers and punctuation.

P:
write a method that takes a string and returns a boolean identifying whether
the string contains all letters of the alphabet

input: string
return: boolean

rules:
-check whether input string contains all letters of the alphabet
-if yes, return true; else return false
-ignore numbers, spaces, and punctuation
-method should be case insensitive

E:
pangram?("The quick brown fox jumps over the lazy dog.") == true
pangram?("This is not a pangram.") == false

D:
-range of all letters of alphabet
-iterative structure to loop over the alphabet range, checking if all letters
are included in input string

A:
-initialize range from 'a'..'z'
-iterate over alphabet range checking that all letters are included in input string (#all?)
  -downcase input string
  -check if downcased string includes current letter

def pangram?(string)
  ('a'..'z').all? { |letter| string.downcase.include?(letter) }
end

p pangram?("The quick brown fox jumps over the lazy dog.") == true
p pangram?("This is not a pangram.") == false

8. Scramblies

Complete the function scramble(str1, str2) that returns true if a portion of
str1 characters can be rearranged to match str2, otherwise returns false.
Only lower case letters will be used (a-z). No punctuation or digits will be
included.

P:
write a method that takes 2 strings and identifies the letters in str1 can be
rearranged to form string 2 (all str2 letter appear in string1 with sufficient count)

input: string
return: booelan

rule:
-identify whether string 2 can be formed from string 1
-if yes, return true; else return false
-string charactres will only be lower case letters
-spaces are not mentioned
-string 1 must include all letters in string 2
-the count of overlapping letters in str1 must be equal to or greater than the
count in string 2

E:
scramble('rkqodlw','world') == true
scramble('cedewaraaossoqqyt', 'codewars') == true
scramble('katas', 'steak' ) == false
scramble('scriptjava', 'javascript') == true
scramble('scriptingjava', 'javascript') == true

D:
iterative structure to loop over second stringg
  -control flow statement checking:
    1. if every str2 letter is included in str1
    2. if the count of each included str2 letter is greater or equal in str1

A:
-iterative over each character is string 2
  -return false unless current letter is included in string 1
  -return false unless count of current letter in string 1 is greater than or
  equal to the count of that letter in string 2
-explicitly return true (because all condition have been met; otherwise false
would have been returned from iteration)

#works, but still not passing efficiency test on codewars

def scramble(str1, str2)
  str2.each_char do |letter|
    return false unless str1.include?(letter)
    return false unless str1.count(letter) >= str2.count(letter)
  end
  true
end

#another approach:
-still can't pass efficientcy tests

def scramble(str1, str2)
  str2.chars.all? {|el| str1.include(el) && str1.count(el) >= str2.count(el) }
end

#scramble('rkqodlw','world') == true

p scramble('cedewaraaossoqqyt', 'codewars') == true
p scramble('katas', 'steak' ) == false
p scramble('scriptjava', 'javascript') == true
p scramble('scriptingjava', 'javascript') == true


9. Multiples of 3 or 5
If we list all the natural numbers below 10 that are multiples of 3 or 5,
we get 3, 5, 6 and 9. The sum of these multiples is 23.

Finish the solution so that it returns the sum of all the multiples of 3 or 5
below the number passed in.

Note: If the number is a multiple of both 3 and 5, only count it once.

P:
write a method that finds all multiples of 3 or 5 below the input intger and
returns their sum

input: integer
return: integer

rules:
-find all multilpes of 3 or 5 below input integer
-find sum of selected multiples nand return
-only count each number once
-do not inlucde the input integer

E:
p solution(10) == 23
p solution(20) == 78
p solution(200) == 9168

D:
iterative structure to loop from 1 up to one less than input intgers, collect
multiples of 3 or 5

A:
-iterate from 1 up to one less than input integer ()
-select numbers that are multiples of 3 or 5
-find sum of selected numbers
-return sum

def solution(int)
 multiples =  (1...int).select do |num|
    num % 3 == 0 || num % 5 == 0
  end
  multiples.reduce(&:+)
end

p solution(10) == 23
p solution(20) == 78
p solution(200) == 9168


10. Largest product in a series

Complete the greatestProduct method so that it'll find the greatest product of
five consecutive digits in the given string of digits.


greatestProduct("123834539327238239583") // should return 3240
The input string always has more than five digits.

P:
write a method that takes a string of numbers and returns the greatest product
that can be formed by 5 consecutive digits

input: string(of numbers)
return: integer (largest product formed by 5 consectutive integers)

rules:
-input string will always have five numbers
-assume valid input
-create substrings of every 5 consecutive string elements
-convert to integer, find product, return largest

E:
greatest_product("395831238345393272382") == 3240
greatest_product("92494737828244222221111111532909999") == 5292
greatest_product("02494037820244202221011110532909999") == 0

D:
-helper method to create all consecutive substrings with a length of 5
-iterative structure to loop over substring arrays and transform to integers
-iterative structure to loop of integer arrays and transform to product
-sorting mechanism to find and return largest product

A:
-get substrings:
-define helper method get_substrings
  -initialize empty substring array
  -iterate from 0 up to the length of the input string minus 5 (index)
    -take slice from input string starting at current index with a length of 5
    -add each slice to substring array
  -return substring array

-save substring_array to return value of get_substring method (with input sring passed as argument)

-convert to integers:
-create a helper method
  -iterate over substrings performing transformation
    --convert each subarry element to integer
  -save return value as int_subarray

-get product of each subarray:
  -iterate over int_subarray
    -find product of all integers in a subarray
  -save return value as product_array

-return largest product:
  -sort product array and return largest value


def get_substrings(string)
  substrings = []
  (0..string.length - 5).each do |index|
   substrings << string[index, 5]
  end
   substrings
end

def convert_to_integers!(array)
   array.map do |string_num|
    string_num.chars.map {|num| num.to_i }.to_a
  end
end

def get_product!(array)
  array.map do |subarray|
    subarray.reduce {|total, num| total *= num }
  end
end

def greatest_product(string)
  substrings = get_substrings(string)
  int_array = convert_to_integers!(substrings)
  product_array = get_product!(int_array)
  product_array.max
end

refactoring:

def greatest_product(string)
  subarrays = string.to_i.digits.reverse.each_cons(5).to_a
  subarrays.map { |subarray| subarray.reduce(&:*) }.max
end

p greatest_product("123834539327238239583") == 3240
p greatest_product("395831238345393272382") == 3240
p greatest_product("92494737828244222221111111532909999") == 5292
p greatest_product("92494737828244222221111111532909999") == 5292
p greatest_product("02494037820244202221011110532909999") == 0


11. Counting Duplicates

Count the number of Duplicates
Write a function that will return the count of distinct case-insensitive
alphabetic characters and numeric digits that occur more than once in the input
string. The input string can be assumed to contain only alphabets (both
uppercase and lowercase) and numeric digits.

P:
write a method that takes a string and return the count of the characters that
appear more than once in the string

input: string
return integer

rules:
-method should be case insensitive
-input string will only contain letters or numbers
-count how many letters or numbers appear more than once in the string

E:
"abcde" -> 0 # no characters repeats more than once
"aabbcde" -> 2 # 'a' and 'b'
"aabBcde" -> 2 # 'a' occurs twice and 'b' twice (`b` and `B`)
"indivisibility" -> 1 # 'i' occurs six times
"Indivisibilities" -> 2 # 'i' occurs seven times and 's' occurs twice
"aA11" -> 2 # 'a' and '1'
"ABBA" -> 2 # 'A' and 'B' each occur twice

D:
-array of unique character from input string
-count variable to hold running count
-iterative structure to loop over ubique_chars array and find count of each
character in input string

A:
-initialize count variable to 0
-create array of unique characters from downcased input string
-iterate over unique characters array
  -find count of current current in downcased input string
  -if count is greater than 1
    -increment count variable by 1
-return count variable


def duplicate_count(string)
  count = 0
  string.downcase.chars.uniq.each do |el|
    count += 1 if string.downcase.count(el) > 1
  end
  count
end

p duplicate_count("") == 0
p duplicate_count("abcde") == 0
p duplicate_count("abcdeaa") == 1
p duplicate_count("abcdeaB") == 2
p duplicate_count("Indivisibilities") == 2


12.Transform To Prime

Given a List [] of n integers , find minimum number to be inserted in a list,
so that sum of all elements of list should equal the closest prime number .

Notes
List size is at least 2 .

List's numbers will only positives (n > 0) .

Repetition of numbers in the list could occur .

The newer list's sum should equal the closest prime number .


P:
Write a method that takes an array of integers, and find the smallest number that
can be array to the sum to the array to form a prime number

input: array of integers
return: integer

rules:
-find smallest number that can be added to the array sum to find a prime number
-array size will always be at least 2

E:

1- minimumNumber ({3,1,2}) ==> return (1)

Since , the sum of the list's elements equal to (6) , the minimum number to be
inserted to transform the sum to prime number is (1) , which will make the sum
of the List equal the closest prime number (7)

2-  minimumNumber ({2,12,8,4,6}) ==> return (5)

[2, 12, 8, 4, 6].sum -> 32
32 + 1 -> 33
  array_num = arry.sum
  prime = false
  until prime == true
    array_num += 1
    prime = !(2...arr_num).all? {|muliples| muliples % arr_num == 0 }

  find difference between array_num and arr.sym and return


Since , the sum of the list's elements equal to (32) , the minimum number to be
inserted to transform the sum to prime number is (5) , which will make the sum
of the List equal the closest prime number (37) .

3- minimumNumber ({50,39,49,6,17,28}) ==> return (2)

Since , the sum of the list's elements equal to (189) , the minimum number to be
inserted to transform the sum to prime number is (2) , which will make the sum
of the List equal the closest prime number (191) .

D
-loop to increment the array sum by 1 and check if the result is prime
-control flow statement:
  -if prime, find difference in return
  -else, increment and check for prime again

A:
-find sum of input array
-save sum to variable array_num
  -check if any number from 2 to array_num exclusive if a mulitple of array_num
-initialize local variable prime to false
-initialize loop with break condition prime == true
  -increment array_num by 1
  -set range from 2 to array_num, exclusive
  -check if array number modulo each number in the range equals zero
  -reverse boolean so that the inner iteration returns true if current array number
  is prime
  -reassign prime to this return value on each iteration
    -if prime, loop ends
    -else, increment arry_num by 1 and repeat loop a prime is found
-when loop break, array_num now points to next prime numbers
-subtract array.sum from array_num
-return difference


def minimum_number(array)
  array_num = array.sum
  return 0 if (2...array_num).all? {|num| !(array_num % num == 0) }
  prime = false

  until prime == true
    array_num += 1
    prime = (2...array_num).all? { |divisor| !(array_num % divisor == 0) }
  end
  array_num - array.sum
end

p minimum_number([3,1,2]) == 1
p minimum_number([5,2]) == 0
p minimum_number([1,1,1]) == 0
p minimum_number([2,12,8,4,6]) == 5
p minimum_number([50,39,49,6,17,28]) == 2



13. Equal Sides Of An Array

You are going to be given an array of integers. Your job is to take that array
and find an index N where the sum of the integers to the left of N is equal to
the sum of the integers to the right of N. If there is no index that would make
this happen, return -1.

For example:

Let's say you are given the array {1,2,3,4,3,2,1}:
Your function will return the index 3, because at the 3rd position of the array,
the sum of left side of the index ({1,2,3}) and the sum of the right side of the
index ({3,2,1}) both equal 6.

Let's look at another one.
You are given the array {1,100,50,-51,1,1}:
Your function will return the index 1, because at the 1st position of the array,
the sum of left side of the index ({1}) and the sum of the right side of the
index ({50,-51,1,1}) both equal 1.

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


P:
write a method that takes an array of integers and returns the 1st index position
at which the sum of elements to the right of the index is equal to the sum of
elements to the left

input: array (of integers)
return: integer (index position or -1)

rules:
-for each position in the input array, check the sum of all elements to the left
and right
  -if equal, return current index
  -else, continue to next iteration
-if iteration finishes without returning an index position (no sums are equal)
  -return -1
-input array will always contain at least 1 element
-array elements can be negative or positive
-with multiple correct answers, always return 1st index
- elements to the left of the first index position are considered 0

E: see below and above

D:
iterative structure to loop over each index of the input array

A:
-iterate from 0 up to input array size, exclusive (index)
  -take slice from index 0 up to current index, exclusive
  -take slice from index + 1 to the end of the input array
  -find sum of each slice
  -compare for equality
  -if equal, return current index
  -else, continue to next iteration
-if iteration finishes, there are no equal sums: return -1


def find_even_index(arr)
  (0...arr.size).each do |index|
  return index if arr[0...index].sum == arr[index + 1..-1].sum
  end
  return -1
end


p find_even_index([1,2,3,4,3,2,1]) == 3
p find_even_index([1,100,50,-51,1,1]) == 1
p find_even_index([1,2,3,4,5,6]) == -1
p find_even_index([20,10,30,10,10,15,35]) == 3
p find_even_index([20,10,-80,10,10,15,35]) == 0
p find_even_index([10,-80,10,10,15,35,20]) == 6
p find_even_index((1..100).to_a) == -1
p find_even_index([0,0,0,0,0]) == 0 # "Should pick the first index if more cases are valid")
p find_even_index([-1,-2,-3,-4,-3,-2,-1]) == 3
p find_even_index((-100..-1).to_a) == -1


14. Find the odd int

Given an array of integers, find the one that appears an odd number of times.

There will always be only one integer that appears an odd number of times.

Examples
[7] should return 7, because it occurs 1 time (which is odd).
[0] should return 0, because it occurs 1 time (which is odd).
[1,1,2] should return 2, because it occurs 1 time (which is odd).
[0,1,0,1,0] should return 0, because it occurs 3 times (which is odd).
[1,2,2,3,3,3,4,3,3,3,2,2,1] should return 4, because it appears 1 time
(which is odd).

P:
wite a method that takes an array of integers and returns the element that appears
an odd number of times

input:aray of intgers
return: integer (selected from input array)

rules:
-find and return the array element that appears an off number of times
- only one element will appear an odd number of times
-input integers can be positive or negative

E:
-see below

D:
-iterative structere to loop over input array, checking the count of each element
and returning that element if count is odd

A:
-iterate over input array
  -check if the count of each element in the input array if odd
  -if odd, return element

def find_it(arr)
  arr.each do |num|
    return num if arr.count(num).odd?
  end
end

p find_it([20,1,-1,2,-2,3,3,5,5,1,2,4,20,4,-1,-2,5]) == 5
p find_it([1,1,2,-2,5,2,4,4,-1,-2,5]) == -1
p find_it([20,1,1,2,2,3,3,5,5,4,20,4,5]) == 5
p find_it([10]) == 10
p find_it([1,1,1,1,1,1,10,1,1,1,1]) == 10


15. Find the unique number

There is an array with some numbers. All numbers are equal except for one.
Try to find it! It’s guaranteed that array contains at least 3 numbers.
The tests contain some very huge arrays, so think about performance.

P:
write a method that finds and returns the unique element in an array

input: array of numbers (integers and floats)
return: integer (unique number from array)

rules:
-only one array element will appear once; find and return it
-array will always hold at least 3 elements

E:
find_uniq([ 1, 1, 1, 2, 1, 1 ]) == 2
find_uniq([ 0, 0, 0.55, 0, 0 ]) == 0.55

D:
-iterative structure to loop over input array to find and return the element
with a count of 1

A:
-iterate over input array
  -check input array for count of current element
    -return element if count equals 1

def find_uniq(arr)
  arr.each {|n| return n if arr.count(n) == 1 }
end

#trying an approach without using count
-initialize hash wth defauls value of 0
-iterative over input array, adding each element as a hash key and incrementing
value by 1
-return the hash key with the element that has a count of 1

def find_uniq(arr)
  count_hash = Hash.new(0)

  arr.each do |num|
    count_hash[num] += 1
  end

 count_hash.min_by {|k, v| v }.first
end

p find_uniq([ 1, 1, 1, 2, 1, 1 ]) == 2
p find_uniq([ 0, 0, 0.55, 0, 0 ]) == 0.55
p find_uniq([1,1,1,1,0]) == 0


16. Are they the same

Given two arrays a and b write a function comp(a, b) (orcompSame(a, b)) that
checks whether the two arrays have the "same" elements, with the same
multiplicities (the multiplicity of a member is the number of times it appears).
"Same" means, here, that the elements in b are the elements in a squared,
regardless of the order.

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
If, for example, we change the first number to something else, comp is not
returning true anymore:

a = [121, 144, 19, 161, 19, 144, 19, 11]
b = [132, 14641, 20736, 361, 25921, 361, 20736, 361]
comp(a,b) returns false because in b 132 is not the square of any number of a.

a = [121, 144, 19, 161, 19, 144, 19, 11]
b = [121, 14641, 20736, 36100, 25921, 361, 20736, 361]
comp(a,b) returns false because in b 36100 is not the square of any number of a.

Remarks
a or b might be []
a or b might be nil
If a or b are nil the problem doesn't make sense so return false.

P:
write a method that takes 2 arrays of integers and returns a boolean -- true if
all elements in the second array are squares of the elements in the first array,
else false

input: 2 arrays of integers
return: boolean:

rules:
-return false if a or b is nil
-return false if a or b is an empty array
-the 2 input arrays may not be the same length
-the 2 arrays will not be sorted
-to return true, each element in the second array must be the square of an element
in the first array
-multiplicity/array size must the be the same for both array

E: see above

D:
-sorted copy of each input array
-iterative structure to loop over index nubers and comare the values in each array

A:
#validate input arrays
-define validate_arrays method
  -returns false if a or b is empty
  -returns false if a or b is nil
  -returns false if a and b are not the same size
-call validate_arrays and pass a and b pass arguments - save return as validation_result
-if validation result is false, return false
#analyze arrays
-reassign array a to a sorted copy of a
-reassign array b to a sorted copy of b
-iterate from 0 up to one less than the size of array a
  -use index reference to access element at current index in a
  -square element
  -check if square is equal to element at corresponding index in b
  -unless this is true, return false
-if iteration finishes, all elements in b are square of elements in a -- return true

NOTE: i assumed empty arrays should return true. I has to remove that to pass the
codewars test -- they were meant to return true

def validate_arrays(arr1, arr2)
  return false if (arr1 == [] || arr2 == [])
  return false if (arr1 == nil || arr2 == nil)
  return false if arr1.size != arr2.size
end

def compare_squares(a, b)
   a = a.sort
   b = b.sort
  (0...a.size).each do |index|
    unless a[index]*a[index] == b[index]
      return false
    end
  end
  true
end

def comp(a, b)
  validation_result = validate_arrays(a, b)
  return false if validation_result == false

  compare_squares(a, b)
end

p comp( [121, 144, 19, 161, 19, 144, 19, 11], [11*11, 121*121, 144*144, 19*19, 161*161, 19*19, 144*144, 19*19]) #== true


17. Sum of pairs

Given a list of integers and a single sum value, return the first two values
(parse from the left please) in order of appearance that add up to form the sum.

If there are two or more pairs with the required sum, the pair whose second
element has the smallest index is the solution.

Negative numbers and duplicate numbers can and will appear.

NOTE: There will also be lists tested of lengths upwards of 10,000,000 elements.
Be sure your code doesn't time out.

EXAMPLES:
sum_pairs([11, 3, 7, 5],         10)
#              ^--^      3 + 7 = 10
== [3, 7]

sum_pairs([4, 3, 2, 3, 4],         6)
#          ^-----^         4 + 2 = 6, indices: 0, 2 *
#             ^-----^      3 + 3 = 6, indices: 1, 3
#                ^-----^   2 + 4 = 6, indices: 2, 4
#  * the correct answer is the pair whose second value has the smallest index
== [4, 2]

sum_pairs([0, 0, -2, 3], 2)
#  there are no pairs of values that can be added to produce 2.
== None/nil/undefined (Based on the language)

sum_pairs([10, 5, 2, 3, 7, 5],         10)
#              ^-----------^   5 + 5 = 10, indices: 1, 5
#                    ^--^      3 + 7 = 10, indices: 3, 4 *
#  * the correct answer is the pair whose second value has the smallest index
== [3, 7]

P:
write a method that takes an array of integers and a sum, and returns an array
holding the index positions of the first 2 number pairs in the array that can create the sum

input: array of integers and integer (sum)
return: array of intgers (index positions of the first 2 array elements that
form the input sum)

rules:
-input array can hold negative numbers
-input array can hold dulicate numbers
-if no array elements can form the sum, method should return nil
-the array can have multiple pairs that form the sum
-should return the pair whose second index position is the small number

E: see above

D:
-iterative structure to loop over input array with index and check if each pair
added forms the input sum
-nested array to store a 2-element array holding the index position of each
that forms the sum
-sorting structure to find the subarray with the smallest final number

A:
Get index pairs:
-initialize empty index_pairs array
-iterate from 0 up to 2 less than input array size (outer_index)
  -set inner iteration from outer_index + 1 to array size, exclusive (inner_index)
  -use index reference to check if the array element at the outer_index plus
  the array element at the inner_index equal the input sum
  -if equal, place outer_index and inner_index into an array
  -append array to index_pairs array
Selected index pair:
  -iterate over index_pairs array
  -select the element with the smallest value at the 2nd subarray position
Return array pair
  -use index reference to access array elements at selected index positions
  -place into array and return


def get_pairs(arr, sum)
  index_pairs = []
  (0..arr.size - 2).each do |outer_index|
    (outer_index + 1...arr.size).each do |inner_index|
      if arr[outer_index] + arr[inner_index] == sum
        index_pairs << [arr[outer_index], arr[inner_index]]
      end
    end
  end
  index_pairs
end

def sum_pairs(arr, sum)
  index_pairs = get_pairs(arr, sum)
  return nil if index_pairs.empty?
   result_indices = index_pairs.min_by {|subarray| subarray.last }
  [arr[result_indices[0]], arr[result_indices[-1]]]
end

l1= [1, 4, 8, 7, 3, 15]
l2= [1, -2, 3, 0, -6, 1]
l3= [20, -13, 40]
l4= [1, 2, 3, 4, 1, 0] #->[0, 4], [1, 5], []
l5= [10, 5, 2, 3, 7, 5]
l6= [4, -2, 3, 3, 4]
l7= [0, 2, 0]
l8= [5, 9, 13, -3]


p sum_pairs(l1, 8) #== [1, 7] # should return [1, 7] for sum = 8")
p sum_pairs(l2, -6) == [0, -6] #should return [0, -6] for sum = -6")
p sum_pairs(l3, -7) == nil #should return nil for sum = -7")
p sum_pairs(l4, 2) #== [1, 1] #should return [1, 1] for sum = 2 ")
p sum_pairs(l5, 10) #== [3, 7] # should return [3, 7] for sum = 10 ")
p sum_pairs(l6, 8) == [4, 4] #should return [4, 4] for sum = 8")
p sum_pairs(l7, 0) == [0, 0] #should return [0, 0] for sum = 0")
p sum_pairs(l8, 10) == [13, -3] # should return [13, -3] for sum = 10")

18. Grouping and Counting
Your goal is to write the group_and_count method, which should receive an
array as unique parameter and return a hash. Empty or nil input must return nil
instead of a hash. This hash returned must contain as keys the unique values of
the array, and as values the counting of each value.

The following methods were disabled:
Array#count
Array#length

P:
write a method that takes an array and returns a hash with array elements as
keys and their counts as values

input: array
return: hash (or nil)

rules:
-if input array is emtpy, return nil
-if input is nil, return nil
-do not use Array#count or Array#length methods
-for return hash, array elements are key and counts are values

E:
Example usage:
input = [1,1,2,2,2,3]
group_and_count(input)# == {1=>2, 2=>3, 3=>1}

D:
-hash
-iterative structure to loop over input array and add elements and counts to hash

A:
-initialize empty result hash iwth default value 0
-iterate over input array
  -use hash reference to add/access hash key refereced by current array element
  -increment value by 1
-return hash

NOTE: test cases passed by forgot to handle nil input and empty arrays-- adding

def group_and_count(array)
  return nil if array == nil
  result = Hash.new(0)
  array.each do |el|
    result[el] += 1
  end
  result.empty? ? nil : result
end

input = [1,1,2,2,2,3]
p group_and_count(input) == {1=>2, 2=>3, 3=>1}
p group_and_count([0,1,1,0]) == {0=>2, 1=>2}


19. WeIrD StRiNg CaSe

Write a function toWeirdCase (weirdcase in Ruby) that accepts a string, and
returns the same string with all even indexed characters in each word upper
cased, and all odd indexed characters in each word lower cased. The indexing
just explained is zero based, so the zero-ith index is even, therefore that
character should be upper cased and you need to start over for each word.

The passed in string will only consist of alphabetical characters and
spaces(' '). Spaces will only be present if there are multiple words. Words will
be separated by a single space(' ').

P:
write a mthod that takes a string and returs the same string with all elements
at an even index uppercase and all elemnets at odd indicies lowercased; for each
for, consider the index number to start over at 0 for the 1st letter of each word

input: string
return: string (problme says same string -- solving for different string object)

rules:
-even indices are uppercased
-odd indices are lowercased
-index positions should start over at 0 with the first letter of each new word
-input string will only contain letters and single spaces

E:
weirdcase( "String" )#=> returns "StRiNg"
weirdcase( "Weird string case" );#=> returns "WeIrD StRiNg CaSe"

D:
-array to hold each word frmo the input string as an element
-emtpy string to hold return value
-nest iterative structure to loop over the word_array and then loop over
  each letter in a word with index

A:
-convert input string to word_array
-iterate over word_array, performing transformation;save as result
  -convert each word to an array of letters
  -iterate over each letter and index, performing transformation
    -if index is even, upcase
    -if index if odd, downcase
  -when iteration is complete, join letters back to a string
-join result back to a string


def weirdcase(string)
  word_array = string.split
  result = word_array.map do |word|
    word.chars.map.with_index do |letter, index|
      index.even? ? letter.upcase : letter.downcase
    end.join
  end
 result.join(' ')
end


def weirdcase(string)
 string.split.map do |word|
    word.chars.map.with_index do |letter, index|
      index.even? ? letter.upcase : letter.downcase
    end.join
  end.join(' ')
end

p weirdcase( "String" ) == "StRiNg"
p weirdcase( "Weird string case" ) == "WeIrD StRiNg CaSe"
p weirdcase('This') == 'ThIs'
p weirdcase('is') == 'Is'
p weirdcase('This is a test') == 'ThIs Is A TeSt'


retrying Transform to Prime 1/11

Given a List [] of n integers , find minimum number to be inserted in a list, so
that sum of all elements of list should equal the closest prime number .

Notes
List size is at least 2 .

List's numbers will only positives (n > 0) .

Repetition of numbers in the list could occur .

The newer list's sum should equal the closest prime number .

P:
write a method that takes an array of integers and returns the integer that
can be added to the sum of array elements to form the nearest prime number

input: array of integer
output: integer

rules:
-a prime number is a number only divisible by 1 and itself
-find sum of array elements and return the integer that must be added to the array sum to form
a prime number
-array will have at least 2 elemets
-all array elements will be positive and greater than 0
-return 0 if input sum is prime

E:
1- minimumNumber ({3,1,2}) ==> return (1)
Explanation:
Since , the sum of the list's elements equal to (6) , the minimum number to be
inserted to transform the sum to prime number is (1) , which will make the sum
of the List equal the closest prime number (7) .
2-  minimumNumber ({2,12,8,4,6}) ==> return (5)
Explanation:
Since , the sum of the list's elements equal to (32) , the minimum number to be
inserted to transform the sum to prime number is (5) , which will make the sum
of the List equal the closest prime number (37) .
3- minimumNumber ({50,39,49,6,17,28}) ==> return (2)
Explanation:
Since , the sum of the list's elements equal to (189) , the minimum number to be
inserted to transform the sum to prime number is (2) , which will make the sum
of the List equal the closest prime number (191) .

D:
-variable nearest_prime to save nearest prime number
-iterative structure to loop over input array sum, increment by 1, and check if prime

A:
-find sum of input array
-if input sum is prime
  -return 0
-initialize nearest_prime to 0
-initialize a loop
  -increment input_sum by 1
  -iterate from 2 up to 1 less than input sum
    - if input sum % all numbers in range do not equal 0
    -continue loop -> back to incrementation
    -else, reassign nearest_prime to current input_sum
    -break out of loop
-subtract the sum of the array input from nearest_prime
-return result


def minimum_number(array)
  sum = array.sum
  nearest_prime = 0
  return 0 if (2..sum-1).all? { |num| !(sum % num == 0) }
  loop do
    sum += 1
    if (2..sum-1).all? { |num| !(sum % num == 0) }
      nearest_prime = sum
      break
    end
  end
  nearest_prime - array.sum
end

p minimum_number([3,1,2]) == 1
p minimum_number([5,2]) == 0
p minimum_number([1,1,1]) == 0
p minimum_number([2,12,8,4,6]) == 5
p minimum_number([50,39,49,6,17,28]) == 2


retrying Largest Product in a Series

Complete the greatestProduct method so that it'll find the greatest product of
five consecutive digits in the given string of digits.

For example:

greatestProduct("123834539327238239583") // should return 3240
The input string always has more than five digits.

P:
write a method that takesa  string of digits and return the largest product that
can be formed by 5 consecutive digits

input: string of numbers
return: integer

rules:
-find greatest product that can be formed with 5 consecutive numbers from input
string
-input string always has more than 5 digits

D:
-helper method to create 5-digit substrings
-array holding the 5-digit substrings
-iterative structure to loop over substring array, convert each substring to
integers, and convert integers to product
-sorting structure to find and return largest product

A:
-invoke get_substrings method  (input string as argument) -> return five_digit_string
-get_product_from_string_numbers (five_digit_string as argument) -> return products
-find and return max value in array returned in above helper method

-get_substrings
  -define helper method, pass in input string
    -initialize five_digit_string to empty array
    -iterate from 0 to array size - 5 (index)
        -take slice from input string starting at current index with a length of 5
        -push slice to five_digit_string
    -return five_digit_string

- convert substrings to integer / product
  -iterate over five_digit_string array performing transformation
    -convert to an array of strings
      -iterate over array of string performing transformation
        -convert current number to integer
      -save result of inner iterate as integers
      -in out iteration, find product of each array of integers
  -save return as products

def get_substrings(string)
  five_digit_strings = []
  (0..string.size - 5).each do |index|
   five_digit_strings << string[index, 5]
  end
  five_digit_strings
end

def get_product_from_string_numbers(array)
  array.map do |number|
  int_arrays = number.chars.map { |num| num.to_i }
  int_arrays.reduce(:*)
  end
end

def greatest_product(string)
 five_digit_strings = get_substrings(string)
  products = get_product_from_string_numbers(five_digit_strings)
  products.max
end

p greatest_product("123834539327238239583") == 3240
p greatest_product("395831238345393272382") == 3240
p greatest_product("92494737828244222221111111532909999") == 5292
p greatest_product("92494737828244222221111111532909999") == 5292
p greatest_product("02494037820244202221011110532909999") == 0


retrying Longest Vowel Chain

The vowel substrings in the word codewarriors are o,e,a,io. The longest of
these has a length of 2. Given a lowercase string that has alphabetic characters
only (both vowels and consonants) and no spaces, return the length of the longest
vowel substring. Vowels are any of aeiou.

P:
write a method that takes a string and returns the length of the longest vowel
substring

input: string
return: integer

rules:
-vowels are only aeiou
-string will have no spaces and only lowercase letters

E:
solve("iuuvgheaae") == 4
solve("ultrarevolutionariees") == 3
solve("strengthlessnesses") == 1

D:
-iterative strucutre to get all substings
-iterative structure to select substrings that only contain vowels
-array of vowels

A:
-get all substrings
  -def helper method get_substrings
    -initialize substrings_array
    -iterate from 0 up to 1 less than size of string (start_index)
      -iterate from current index up to one less than size of string (end_index)
        -take slice from input string starting at start_index and ranging up to end_index
        -push slice to substrings array
    return substrings array
  -in main method, save return value of get_substrings as all_substrings

-select vowel substrings
  -define helper method get_vowel_substrings
  (pass all_substrings as argument)
  -initialize vowels array to %w(aeiou)
  -initialize empty vowel substrings array
  -iterate over all_substrings,
    -split each substring into array of letters
    -iterate over each letter
      -if vowels array includes the current letter, add substring to vowel_substrings array
  -return vowel substrings array
-in main method, save return value as vowel_substrings

-find length of the vowel substrings
  -iterate over vowel substrings, performing transformation
    -find size of each vowel substring
-save return value as vowel_substring_lengths

-return largest length
  -select largest value in the vowel_substring_lengths array

def get_substrings(string)
  substrings_array = []
  (0...string.size).each do |start_index|
    (start_index...string.size).each do |end_index|
     substrings_array << string[start_index..end_index]
   end
 end
 substrings_array
end

def get_vowel_substrings(arr)
  vowels = %w(a e i o u)
  arr.select do |substring|
    substring.chars.all? do |letter|
      vowels.include?(letter)
    end
  end
end

def solve(string)
  all_substrings = get_substrings(string)
  vowel_substrings = get_vowel_substrings(all_substrings)
  vowel_substring_lengths = vowel_substrings.map { |substring| substring.length }
  vowel_substring_lengths.max
end

p solve("codewarriors") == 2
p solve("suoidea") == 3
p solve("iuuvgheaae") == 4
p solve("ultrarevolutionariees") == 3
p solve("strengthlessnesses") == 1
p solve("cuboideonavicuare") == 2
p solve("iiihoovaeaaaoougjyaw") == 8

retrying Repeated Substring 4/12

For a given nonempty string s find a minimum substring t and the maximum number
k, such that the entire string s is equal to t repeated k times.

The input string consists of lowercase latin letters.

Your function should return :

a tuple (t, k) (in Python)
an array [t, k] (in Ruby and JavaScript)
in C, return k and write to the string t passed in parameter
Example #1:

for string

s = "ababab";
the answer is

("ab", 3)
Example #2:

for string

s = "abcde"
the answer is

("abcde", 1)
because for this string "abcde" the minimum substring t, such that s is t
repeated k times, is itself.

P:Write a method that takes a string and returns an array holding two elements:
a string and an integer. The string is the samllest substring that can be repeated to
form the input string, and the integer is the count of the times that substring
must be repeated.

input: string
return: array (holding a string and in integer)

rules:
-input string will only contain lowercase letters and will never be empty
-find smallest substring that can be repeated to create the input string
-find count of number of times the substring must be repeated
-return both values in an array

E:
f("ababab") == ["ab", 3]
f("abcde") == ["abcde", 1]

D:
-helper method to create all substrings
-iterative strucutre to loop over substring array and find smallest substring that
can form the input string

A:
-get substrings
  -define helper method get_substrings
    -initialize empty substrings array
    -iterate from 0 up to one less than length of input string (start_index)
      -iterate from start_index to one less than length of input string (end_index)
        -take slice frmo input string ranging from start_index to end_index
        -add slice to substrings array
    -return substrings array


main method:
  -invoke get_substrings and pass input string as argument
  -save return value as all_substrings
  -sort all substrings by size
  -save return value as sorted_substrings

-find smallest substring to form input string

  -iterate over sorted_substrings array
    -divide input string length by current substring length
    -save as multiplier
    -multiple current substring by multiple and check if equal to input string
      -if equal, return array holidng current substring and current multiplier

def get_substrings(string)
  substrings = []
  (0...string.size).each do |start_index|
    (start_index...string.size).each do |end_index|
     substrings << string[start_index..end_index]
   end
 end
 substrings
end

def sort_substrings(array)
  array.sort_by {|substring| substring.size }
end

def find_return_value(array, string)
  array.each do |substring|
    multiplier = string.size / substring.size
    if substring * multiplier == string
      return [substring, multiplier]
    end
  end
end

def f(string)
  all_substrings = get_substrings(string)
  sorted_substrings = sort_substrings(all_substrings)
  find_return_value(sorted_substrings, string)
end

p f("ababab") == ["ab", 3]
p f("abcde") == ["abcde", 1]


retring sum of pairs
4/16

Sum of Pairs
Given a list of integers and a single sum value, return the first two values
(parse from the left please) in order of appearance that add up to form the sum.

If there are two or more pairs with the required sum, the pair whose second
element has the smallest index is the solution.

sum_pairs([11, 3, 7, 5],         10)
#              ^--^      3 + 7 = 10
== [3, 7]

sum_pairs([4, 3, 2, 3, 4],         6)
#          ^-----^         4 + 2 = 6, indices: 0, 2 *
#             ^-----^      3 + 3 = 6, indices: 1, 3
#                ^-----^   2 + 4 = 6, indices: 2, 4
#  * the correct answer is the pair whose second value has the smallest index
== [4, 2]

example:
 pairs: {
   [0, 2] => [4, 2],
   [1, 3] => [3, 3],
   [2, 4] => [2, 4]

 }

sum_pairs([0, 0, -2, 3], 2)
#  there are no pairs of values that can be added to produce 2.
== None/nil/undefined (Based on the language)

sum_pairs([10, 5, 2, 3, 7, 5],         10)
#              ^-----------^   5 + 5 = 10, indices: 1, 5
#                    ^--^      3 + 7 = 10, indices: 3, 4 *
#  * the correct answer is the pair whose second value has the smallest index
== [3, 7]
Negative numbers and duplicate numbers can and will appear.

P:
-wrtie a method that takes an array of numbers and a sum and returns an array
holding the first pair of numbers from the input array that sums to the input
sum

input: array of integers and integer (sum)
return: array holding 2 integers (selected from the input array)

rules:
-return first pair from array that sums to given sum
-multiple pairs can sum to the sum
-return pair whose second element has smallest index
  -need to keep track of index positions
-if no pairs are present, return nil

E:
l7 = [0, 2, 0]
sum_pairs(l7, 0) == [0, 0]

D:
-hash with array of pair index position as key and array of pair elements as value
-iterative strucure to create all 2-elemnet pairs and check sum
-sorting structure to select correct pair

A:
GET PAIRS
-initialize pairs hash with default value 0
-iterate from 0 up to array size minus 2 (first_num)
  -first_num + 1 upto array size minus 1 (second_num)
    if array[first_num] + array[second_num] == sum
      pairs[first_num, second_num] = [array[first_num], array[second_num]]
    else
    next

SELECT PAIRS
-iterate over hash keys
  -sort by the key with the smallest value at the final array position
  -save returned array as result_indices
-use hash reference to access value of result_indices (pair of array elements

NOTE: did not fully think through handling nil - I set default values to 0, so
return value was 0 rather than nil (although I think sorting would have thrown
an error had the 0 not been there)

NOTE2: this was the final study guide problme I had not solved. Solved easily
this time, but still took a full 30 and does not pass codewars efficiency tests.
Not sure of a better way to solve.


def get_pairs(array, sum)
  pairs = Hash.new(0)
  (0..array.size - 2).each do |first_num|
    (first_num + 1...array.size).each do |second_num|
     if array[first_num] + array[second_num] == sum
       pairs[[first_num, second_num]] = [array[first_num], array[second_num]]
     end
    end
  end
  pairs
end

def sum_pairs(array, sum)
  pairs = get_pairs(array, sum)
  return nil if pairs.empty?
  result_indices = pairs.keys.min_by { |index_pair| index_pair[-1] }
  pairs[result_indices]
end


l1= [1, 4, 8, 7, 3, 15]
l2= [1, -2, 3, 0, -6, 1]
l3= [20, -13, 40]
l4= [1, 2, 3, 4, 1, 0]
l5= [10, 5, 2, 3, 7, 5]
l6= [4, -2, 3, 3, 4]
l7= [0, 2, 0]
l8= [5, 9, 13, -3]

p sum_pairs(l1, 8) == [1, 7]
p sum_pairs(l2, -6) == [0, -6]
p sum_pairs(l3, -7) == nil
p sum_pairs(l4, 2) == [1, 1]
p sum_pairs(l5, 10) == [3, 7]
p sum_pairs(l6, 8) == [4, 4]
p sum_pairs(l7, 0) == [0, 0]
p sum_pairs(l8, 10) == [13, -3]
















