=begin
4/4

Problem 1
P:
write a method that takes an array and returns a new array. input array elements
should be replaced with the count of the unique smaller numbers in the input
array

input: array
return: array

rules:
-new array will hold count of unique smaller values for each element in the input
array
-return new array object
-new array will have same number of elements as return array
-only count unique numbers when counting smaller values
-number should be  0 if no values are smaller
-array can hold only 1 element
-test cases show no empty arrays

E:
p smaller_numbers_than_current([8,1,2,2,3]) == [3, 0, 1, 1, 2]
p smaller_numbers_than_current([1,4,6,8,13,2,4,5,4])
                            == [0, 2, 4, 5, 6, 1, 2, 3, 2]
p smaller_numbers_than_current([7,7,7,7]) == [0,0,0,0]
p smaller_numbers_than_current([6,5,4,8]) == [2, 1, 0, 3]
p smaller_numbers_than_current([1]) == [0]

D:
-array of unique values from input array
-new array of counts to return
-iterative structure to find count and populate new array

A:
-initialize uniq_nums to an array of unique elements in input array
-iterate over input array (tranformative - #map)
  -find count of elemnets in uniq_nums that are less than the current element

12 minutes

def smaller_numbers_than_current(array)
  unique_nums = array.uniq
  array.map do |num|
    unique_nums.count { |el| el < num }
  end
end

p smaller_numbers_than_current([8,1,2,2,3]) #== [3, 0, 1, 1, 2]
p smaller_numbers_than_current([1,4,6,8,13,2,4,5,4]) == [0, 2, 4, 5, 6, 1, 2, 3, 2]
p smaller_numbers_than_current([7,7,7,7]) == [0,0,0,0]
p smaller_numbers_than_current([6,5,4,8]) == [2, 1, 0, 3]
p smaller_numbers_than_current([1]) == [0]


Problem 2
P:
write a method that takes an array, finds the sume of every 5 consecutive numbers,
and returns the smallest sum

input: array
return: integer (smallest sum)

rules:
-if array size if less than 5, return nil
-assuming an array size of 5 should simply return sum
-find sum of each group of 5 consecutive numbers
-find and return smallest sum
-smallest sum can appear multiple times
-input array can hold negative numbers
-returns sum can be negative

E:
p minimum_sum([1, 2, 3, 4]) == nil
p minimum_sum([1, 2, 3, 4, 5, 6]) == 15
p minimum_sum([55, 2, 6, 5, 1, 2, 9, 3, 5, 100]) == 16
p minimum_sum([-1, -5, -3, 0, -1, 2, -4]) == -10

D:
-array to hold sums
-iterative structure that creates 5-elemnet subarrays and find the sum of each

A:
-return nil if input aray size is less than five
-initialize empty counts array
-iterate over input array
  -create 5-element consecutive subarray (each_cons)
  -find sum of subarray
  -push to counts array
-find and return minimum count

11 minutes
# retrying below without using each_cons

def minimum_sum(array)
  return nil if array.size < 5
  counts = []
  array.each_cons(5) { |sub_arr| counts << sub_arr.sum }
  counts.min
end

p minimum_sum([1, 2, 3, 4]) == nil
p minimum_sum([1, 2, 3, 4, 5, 6]) == 15
p minimum_sum([55, 2, 6, 5, 1, 2, 9, 3, 5, 100]) == 16
p minimum_sum([-1, -5, -3, 0, -1, 2, -4]) == -10

2nd Alg:
-return nil if input array size is less than five
-initialize empty counts array
-iterate from 0 to one less than the size of the input array
  -take a slice of the input array starting at current index with length of 5
  -find the sum of the slice
  -add to counts array
-find and return minimum count

def minimum_sum(array)
  return nil if array.size < 5
  unique_numbers = array.uniq
  counts = []
  (0...array.size - 5).each do |index|
    counts << array[index, 5].sum
  end
  counts.min
end

p minimum_sum([1, 2, 3, 4]) == nil
p minimum_sum([1, 2, 3, 4, 5, 6]) == 15
p minimum_sum([55, 2, 6, 5, 1, 2, 9, 3, 5, 100]) == 16
p minimum_sum([-1, -5, -3, 0, -1, 2, -4]) == -10


retrying 4/5

P:
write a method that takes an array of integers and returns a new array holding
the count of smaller numbers for each element in the input array

input: array of integers
return: array of integers (counts)

rules:
-for each integer in the input array, find the count of smaller numbers in that
array
-capture the counts in an array and return
-return array will have name number of values as input array
-counts can be 0
-only count unique characters

E:
p smaller_numbers_than_current([8,1,2,2,3]) == [3, 0, 1, 1, 2]
p smaller_numbers_than_current([1,4,6,8,13,2,4,5,4])
                            == [0, 2, 4, 5, 6, 1, 2, 3, 2]
p smaller_numbers_than_current([7,7,7,7]) == [0,0,0,0]
p smaller_numbers_than_current([6,5,4,8]) == [2, 1, 0, 3]
p smaller_numbers_than_current([1]) == [0]

D:
-array of unique characters in the input array
-new array to hold counts
-iterative structure to loop over input array and find the count of unique characters
  that are smaller than the current character

A:
-create a copy of the input array holding only uniq characters
-iterate over input array performing transformation
  -find count of number less than the current number in the unique_numbers array

def smaller_numbers_than_current(array)
  unique_numbers = array.uniq
  array.map do |num|
    unique_numbers.count { |unique_number| unique_number < num }
  end
end

p smaller_numbers_than_current([8,1,2,2,3]) == [3, 0, 1, 1, 2]
p smaller_numbers_than_current([1,4,6,8,13,2,4,5,4]) == [0, 2, 4, 5, 6, 1, 2, 3, 2]
p smaller_numbers_than_current([7,7,7,7]) == [0,0,0,0]
p smaller_numbers_than_current([6,5,4,8]) == [2, 1, 0, 3]
p smaller_numbers_than_current([1]) == [0]

Problem 2
retrying 4/4

P:
write a method that finds the sum of every 5 consecutive elements in an array
and returns the smallest sum

input: array of integers
return: integer (minimum sum)

rules:
-find sum of every 5 consecutive array elements
-return the smallest sum
-return nil if input array has less than 5 elements
-input array can hold negativ integers
-sum can be negative

E:
p minimum_sum([1, 2, 3, 4]) == nil
p minimum_sum([1, 2, 3, 4, 5, 6]) == 15
p minimum_sum([55, 2, 6, 5, 1, 2, 9, 3, 5, 100]) == 16
p minimum_sum([-1, -5, -3, 0, -1, 2, -4]) == -10

D:
subarrays of every 5 consecutive integers

A:
-return nil if input array size is less than 5
-iterate from 0 up to 5 less than the size of the input array (using transformation)
  -take a slice of input array from current index with a length of five
  -find sum of slice
  -save sums in an array
-find an return minimum sum from the sums array

def minimum_sum(array)
  return nil if array.size < 5
  sum = (0..array.size - 5).map do |index|
    sub_array = array[index, 5]
    sub_array.sum
  end
  sum.min
end

p minimum_sum([1, 2, 3, 4]) == nil
p minimum_sum([1, 2, 3, 4, 5, 6]) == 15
p minimum_sum([55, 2, 6, 5, 1, 2, 9, 3, 5, 100]) == 16
p minimum_sum([-1, -5, -3, 0, -1, 2, -4]) == -10

Problem 3
4./4

P:
write a method that takes a string and converts every second (every other)
character in every 3rd word to an uppercase character

input: string
return new string

rules:
-don't modify the capitalization fromthe input string unless it's a selected character
-upcase every second character in every third word
-if third word has no second character, no nothing

E:
p to_weird_case('Lorem Ipsum is simply dummy text of the printing') ==
                'Lorem Ipsum iS simply dummy tExT of the pRiNtInG'
p to_weird_case(
  'It is a long established fact that a reader will be distracted') ==
  'It is a long established fAcT that a rEaDeR will be dIsTrAcTeD'
p to_weird_case('aaA bB c') == 'aaA bB c'
p to_weird_case(
  'Miss Mary Poppins word is supercalifragilisticexpialidocious') ==
  'Miss Mary POpPiNs word is sUpErCaLiFrAgIlIsTiCeXpIaLiDoCiOuS'

D:
-array of words in the input string
-nested iterative structure to perform transformation while looping over
first the word and index and then the letters of a word and index

A:
-create array of words in input string (word_arr)
-iterate over word_arr and index performing transformation
  -next unless index + 1 % 3 == 0
    iterate over letters in word and index, performing transformation
      upcase if index is odd
    -when iteration is compete, join transformed back to a string
-join result array back to a string

def to_weird_case(string)
 word_arr = string.split
 result = word_arr.map.with_index do |word, index|
    if (index + 1) % 3 == 0
      word.chars.map.with_index { |letter, index| index.odd? ? letter.upcase : letter }.join
    else
      word
    end
end
  result.join(' ')
end

p to_weird_case('Lorem Ipsum is simply dummy text of the printing') == 'Lorem Ipsum iS simply dummy tExT of the pRiNtInG'

p to_weird_case(
  'It is a long established fact that a reader will be distracted') ==
  'It is a long established fAcT that a rEaDeR will be dIsTrAcTeD'
p to_weird_case('aaA bB c') == 'aaA bB c'
p to_weird_case(
  'Miss Mary Poppins word is supercalifragilisticexpialidocious') ==
  'Miss Mary POpPiNs word is sUpErCaLiFrAgIlIsTiCeXpIaLiDoCiOuS'


Problem 4
retrying 4/6

P:
write a method that takes an array of integers and returns an array of the 2 integers
with the smallest difference

input: array of integer
return: array of integers (the 2 integer from the input array that are closest together)

rules:
-find the different between all integer paris in the input array
-find the sammlest difference
-return pair with smallest difference

E:
p closest_numbers([5, 25, 15, 11, 20]) == [15, 11]
p closest_numbers([19, 25, 32, 4, 27, 16]) == [25, 27]
p closest_numbers([12, 7, 17]) == [12, 7]

D
-iterative structure to create 2-element arrays (every possible pair of numbers from
input array)
-iterative structure to loop over pairs_array and find the different of each pair

A:
create pairs_array (all 2-element pairs from input array)
-initialize empty pairs array
  -iterate from 0 up to 2 less than the size on the input array (outer_index)
    -iterate from outer_index plus 1 upto one less than the size of the input array (inner_index)
      - create a new subarray holding the input array element at outer_index
        and the input array element at inner index
      -add each new subarry to pairs_array
find the sum of each pair
  -initialie a pair_and_diff hash with default values of 0
  -iterate over pairs array
  -set each pair as the hash key and the absolute difference as hash vale
return pair with smallest difference
  -iterate over pair_and_diff hash
    -filter for minimum vlaue
    -return key (pair) associated with minimum value


def get_all_pairs(arr)
  pairs = []
  (0..arr.size - 2).each do |outer_index|
    (outer_index + 1...arr.size).each do |inner_index|
      pairs << [arr[outer_index], arr[inner_index]]
    end
  end
  pairs
end

def closest_numbers(arr)
  pair_and_difference = Hash.new(0)

  pairs = get_all_pairs(arr)

  pairs.each do |subarray|
    pair_and_difference[subarray] = subarray.reduce(&:-).abs
  end

  pair_and_difference.min_by {|k, v| v}.first
end


p closest_numbers([5, 25, 15, 11, 20]) == [15, 11]
p closest_numbers([19, 25, 32, 4, 27, 16]) == [25, 27]
p closest_numbers([12, 7, 17]) == [12, 7]
