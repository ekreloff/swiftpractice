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

//Question 2:

