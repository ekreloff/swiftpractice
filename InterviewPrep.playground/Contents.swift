//: Algorithm practice in Swift

import UIKit

//Question 1.1: Write an algorithm that returns wether the characters in a string are unique or not
//Solution with smaller space complexity is to use a bit mask that has enough bits to cover the amount of characters in a character set, determine the int value of a char in the String and shift the bit vector over to set it to 1, unless its already set to 1 in which case you can return false as that is the second occurence of the character. Also could use array of bools.
func uniqueChar(s: String) -> Bool{
    var counts: [Character:Int] = [:]
    for c in s.characters{
        counts[c] = (counts[c] ?? 0) + 1
        if counts[c] == 2{
            return false
        }
    }
    return true
}

uniqueChar("Hello")
uniqueChar("World")
uniqueChar("left")
uniqueChar("total")
uniqueChar("a")
uniqueChar("")
uniqueChar("aaa")

//Part B: What if you can't use additional data structures?
//Technically uses an array, but don't want to manually implement a String sorting function in Swift
func uniqueChar2(s: String) -> Bool{
    let sortedString = s.characters.sort()
    for var i = 0; i < sortedString.count - 1; i++ {
        if sortedString[i] == sortedString[i + 1]{
            return false
        }
    }
    return true
}

uniqueChar2("Hello")
uniqueChar2("World")
uniqueChar2("left")
uniqueChar2("total")
uniqueChar2("a")
uniqueChar2("")
uniqueChar2("aaa")

//Question 1.2: Check if one string is a permutation of the other
func stringPermutation(s1: String, s2: String) -> Bool{
    if s1.characters.count != s2.characters.count{return false}
    var counts: [Character:Int] = [:]
    
    for c in s1.characters {
        counts[c] = (counts[c] ?? 0) + 1
    }
    
    for c in s2.characters {
        if var count = counts[c]{
            if count == 0{
                return false
            }else{
                counts[c] = --count
            }
        }else{
            return false
        }
    }
    
    return true
}

stringPermutation("dog", s2: "god")
stringPermutation("ddog", s2: "godd")
stringPermutation("a", s2: "b")
stringPermutation(" ", s2: "  ")
stringPermutation("aab", s2: "aaa")
stringPermutation(" ", s2: " ")
stringPermutation("a", s2: "")
stringPermutation("", s2: "")
stringPermutation("DOG", s2: "dog")
stringPermutation("aaa", s2: "baa")

//Question 1.5: Check if two string are one edit away (insert, delete, add)
func oneEditDifference(s1: String, s2: String) -> Bool{
    if s1 == s2 {return true}
    let lengthDifference = abs(s1.characters.count - s2.characters.count)
    if lengthDifference > 1 {return false}
    var array1 = [Character](s1.characters)
    var array2 = [Character](s2.characters)
    var firstDifference = true
    if lengthDifference == 0{
        for var i = 0; i < s1.characters.count; i++ {
            if array1[i] != array2[i]{
                if firstDifference{
                    firstDifference = false
                }else{
                    return false
                }
            }
        }
    }else{
        var length = 0
        var s1Longer: Bool
        if s1.characters.count > s2.characters.count{
            length = s1.characters.count
            s1Longer = true
        }else{
            length = s2.characters.count
            s1Longer = false
        }
        
        for var i = 0; i < length; i++ {
            //if i == length - 1 {return true}
            if array1[i] != array2[i]{
                if firstDifference{
                    if s1Longer{
                        array2.insert(array1[i], atIndex: i)
                        print(array2)
                    }else{
                        array1.insert(array2[i], atIndex: i)
                        print(array1)
                    }
                    firstDifference = false
                }else{
                    return false
                }
            }
        }
    }
    return true
}

oneEditDifference("pale", s2: "bale")
oneEditDifference("pale", s2: "pa")
oneEditDifference("pale", s2: "pool")
oneEditDifference("pale", s2: "spale")
oneEditDifference("pale", s2: "spald")
oneEditDifference("pale", s2: "pales") //SO CLOSE, ARRAY IS OUT OF BOUNDS WHEN CHECKING THE LAST ELEMENT WHEN ALL PREVIOUS ELEMENTS MATCH, BECAUSE ONE ARRAY IS LONGER

