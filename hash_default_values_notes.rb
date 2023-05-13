###from Patrick Moran

# 1: Watch out for common name variables... they might be methods in Kernel, Object, BasicObject!
# p hash = {}
# https://docs.ruby-lang.org/en/3.2/Object.html#method-i-hash

# 2: What are hash default values? What happens when we reference a key that doesn't exist?
# test_hash = Hash.new(['meow'])
# p test_hash[45]
# p test_hash["I'm a key!"].push(['s'])
# p test_hash[:key]
# p test_hash

# # 3: What about default values with a block?
# cats = Hash.new { "Meow!" }
# p cats[:tiny]
# p cats[3] << " another meow"
# p cats[4]

# 4: What about default values with a mutable object?
# dogs = Hash.new([])
# p dogs[3]
# p dogs[3] << "woof!"
# p dogs[:sweetie] << "bark!"
# p dogs["sparky"] << "bow_wow!"
# p dogs

# 5: The above, but rewritten....
# single_array_object = []
# dogs = Hash.new(single_array_object)
# p dogs[3]
# p dogs[3] << "woof!"
# p dogs[:sweetie] << "bark!"
# p dogs["sparky"] << "bow_wow!"
# p dogs
# p single_array_object

# 6: A quick diversion to arrays...
# cat = Array.new(5, [])
# p cat
# cat[1] << "Meow"
# p cat

# 7: Let's fix it for arrays!
# cat = Array.new(5) { Array.new }
# p cat
# cat[1] << "Meow"
# p cat
# p cat[7]

# 8: Back to hashes - What's the difference between two below?
# kitty = Hash.new { |hash, key| hash[key] = Array.new }
# p kitty
# p '' << "meow!"
# p kitty
# p kitty[2] += "meow"
# p kitty

# Rebecca working solution (what I remember?)
# LETS FIX IT!!!!!!

def get_char_count(string)
 string = string.downcase.gsub(/[^a-z0-9]/, '')
 chars_array = string.chars


 result = Hash.new([])
 chars_array.uniq.each do |el|
    result[string.count(el)] << el
 end
 p result

end

# https://docs.ruby-lang.org/en/3.2/Hash.html#class-Hash-label-Default+Values

# Patrick solution
# def get_char_count(string)
#   string = string.downcase.gsub(/[^a-z0-9]/, '')
#   uniq_chars = string.chars.uniq
#   uniq_count = uniq_chars.map { |el| string.count(el) }.uniq
#   counts_sorted = uniq_count.sort { |a, b| b <=> a }

#   char_count = {}
#   counts_sorted.each do |count|
#     char_count[count] = []
#     uniq_chars.each do |char|
#       char_count[count] << char if string.count(char) == count
#     end
#   end

#   char_count.each_value { |v| v.sort! }
# end

p get_char_count("Mississippi") #== {4=>["i", "s"], 2=>["p"], 1=>["m"]}
p get_char_count("Hello. Hello? HELLO!!") #== {6=>["l"], 3=>["e", "h", "o"]}
p get_char_count("aaa...bb...c!") #== {3=>["a"], 2=>["b"], 1=>["c"]}
# p get_char_count("aaabbbccc") == {3=>["a", "b", "c"]}
# p get_char_count("abc123") == {1=>["1", "2", "3", "a", "b", "c"]}

=begin
P:
write a method that takes a string and returns a hash with a letter count as key and an array of characters with that count as value

rules:
-only count letters and numbers
-count uppercase letters as lowercase
-hash keys should be sorted in descending numerical order
-hash keys should be sorted in alpabetical order

E:
p get_char_count("Hello. Hello? HELLO!!") == {6=>["l"], 3=>["e", "h", "o"]}

"Hello. Hello? HELLO!!"
1. get array of characters, get unique values, then iterate over each and count occurrence in original array
2. iterate over each char directly, update hash as we go
3. map over characters and transform them to their count
4. Delete all the non_letters, sort as is, then iterate

D:
-input: string
-array of chars from string
-return: hash

A:
-delete all non-letter chars from input string (sort?)
-create an array of all chars from clean string
-initiliaze result hash with default values of 0
-create array of chars
-iterate over uniq chars (sort by count)
  -set count of current character to key in result hash and set value as empty hash
-add unique letters and numbers to hash keys (sort before adding)
  -create array of uniq chars and iterate over
    -take count of current character from input string

*** Notes on splat operator from session with Fallon
p [*'a'..'z']

# https://stackoverflow.com/questions/35747905/a-method-with-an-optional-parameter


def test(**args)
  p args

end

p test(a: 3, b: 3)

# *args = unknown number of input objects
# **args = unknown number of input key/value pairs
=end