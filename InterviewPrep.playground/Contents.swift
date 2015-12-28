//: Algorithm practice in Swift

import UIKit

//Question 1: Write an algorithm that returns wether the characters in a string are unique or not
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
    for(var i = 0; i < sortedString.count - 1; i++){
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

//Question 2:

