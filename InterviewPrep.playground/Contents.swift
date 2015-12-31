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
                    }else{
                        array1.insert(array2[i], atIndex: i)
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
//oneEditDifference("pale", s2: "pales") //SO CLOSE, ARRAY IS OUT OF BOUNDS WHEN CHECKING THE LAST ELEMENT WHEN ALL PREVIOUS ELEMENTS MATCH, BECAUSE ONE ARRAY IS LONGER

//Question 3.3 Implement a class that is a stack made up of stacks that have a capacity limit. Should have normal stack functions.

class SetOfStacks{
    let threshold: Int
    var currentIndex: Int = 0
    var counts: [Int] = [0]
    var stacks: [[Int]] = []
    
    init(threshold capacity: Int) {
        threshold = capacity
        stacks.append([])
    }
    
    func push (data: Int){
        if counts[currentIndex] == threshold {
            let stack: [Int] = []
            counts.append(0)
            stacks.append(stack)
            currentIndex++
        }
        stacks[currentIndex].append(data)
        ++counts[currentIndex]
    }
    
    func pop() -> Int? {
        if counts[currentIndex] == 0 {
            return nil
        }
        let data = stacks[currentIndex].removeLast()
        --counts[currentIndex]
        if counts[currentIndex] == 0 && currentIndex > 0 {
            stacks.removeLast()
            currentIndex--
            counts.removeLast()
        }
        return data
    }
    
    func printStack() -> String {
        var output = ""
        if counts[currentIndex] != 0{
            output += "Stack capacity: \(threshold)\nCurrent stack: \(currentIndex)\nNumber of elements in each stack:\n"
            var i = 0
            for count in counts {
                output += "Stack \(i) has \(count) element(s).\n"
                i++
            }
            output += "\nStack contents:\n"
            i = 0
            for _ in counts {
                output += "Stack \(i): "
                for element in (stacks[i].count - 1).stride(through: 0, by: -1) {
                    output += "\(stacks[i][element])|"
                }
                output += "\n"
                i++
            }

        }else{
            output += "SetOfStacks is empty."
        }
        output += "\n"
        return output
    }
}

let pushes = 50
let pops = 50
let multiStack = SetOfStacks(threshold: 5)

print(multiStack.printStack())
multiStack.pop()
for push in 1...pushes {
    multiStack.push(random()%1000)
    print("Push number \(push):\n\(multiStack.printStack())")
}
for pop in 1...pops {
    multiStack.pop()
    print("Pop number \(pop):\n\(multiStack.printStack())")
}
multiStack.push(20)
print(multiStack.printStack())

//Question 4.2 Given a sorted array with unique elements return a binary search tree with minimal height

class BinaryNode {
    var data: Int
    var leftChild: BinaryNode? = nil
    var rightChild: BinaryNode? = nil
    
    init(data number: Int){
        data = number
    }
    
    class func DFSPrint(node: BinaryNode?){
        if node == nil {
            return
        }
        
        print(node!.data)
        DFSPrint(node?.leftChild)
        DFSPrint(node?.rightChild)
        return
    }
}

func sortedArrayToBST(var array: [Int]) -> BinaryNode? {
    if array.count == 0 {
        return nil
    }
    
    if array.count == 1 {
        return BinaryNode(data: array.last!)
    }
    
    let midpoint = array.removeAtIndex(array.count/2)
    let node = BinaryNode(data: midpoint)
    var leftArray: [Int] = []
    var rightArray: [Int] = []
    for i in 0...((array.count - 1)/2) {
        leftArray.append(array[i])
    }
    
    if array.count > 1 {
        for i in ((array.count - 1)/2 + 1)...(array.count - 1){
            rightArray.append(array[i])
        }
    }
    
    
    print(leftArray)
    print("\(rightArray)\n")
    node.leftChild = sortedArrayToBST(leftArray)
    node.rightChild = sortedArrayToBST(rightArray)
    return node
}


let testArray: [Int] = []
let testArray1 = [1]
let testArray2 = [1, 2]
let testArray3 = [1, 2, 3]
let testArray4 = [1, 2, 3, 4]
let testArray5 = [1, 2, 3, 4, 5, 6]
let testRootNode = sortedArrayToBST(testArray)
let testRootNode1 = sortedArrayToBST(testArray1)
let testRootNode2 = sortedArrayToBST(testArray2)
let testRootNode3 = sortedArrayToBST(testArray3)
let testRootNode4 = sortedArrayToBST(testArray4)
let testRootNode5 = sortedArrayToBST(testArray5)

BinaryNode.DFSPrint(testRootNode)
print("")
BinaryNode.DFSPrint(testRootNode1)
print("")
BinaryNode.DFSPrint(testRootNode2)
print("")
BinaryNode.DFSPrint(testRootNode3)
print("")
BinaryNode.DFSPrint(testRootNode4)
print("")
BinaryNode.DFSPrint(testRootNode5)
print("")
