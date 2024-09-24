import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}

let abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let abcLowercase = "abcdefghijklmnopqrstuvwxyz"
var message =  "Oek sqd veeb qbb ev jxu fuefbu iecu ev jxu jycu, qdt iecu ev jxu fuefbu qbb ev jxu jycu, rkj oek sqd'j veeb qbb ev jxu fuefbu qbb ev jxu jycu."
let pattern = #"[6 \'’.,!?:;-]"#

func getIndex(of letter: String.Element, in sequence: String) -> Int {
    for (index,char) in sequence.enumerated() {
        if char == letter {
            return index
        }
    }
    return 0
}


var chars = [String.Element]()
var sortedChars = [String.Element]()
var charCount = [(char: String.Element, count: Int)]()
var editedMessage = message.lowercased()
editedMessage = editedMessage.replacingOccurrences(of: pattern, with: "", options: String.CompareOptions.regularExpression, range: nil)

for char in editedMessage {
    chars.append(char)
}

sortedChars = chars.sorted{$1<$0}
var indexOfRepeatedChar = -1
for (index, char) in sortedChars.enumerated() {
    if index != 0 && char == sortedChars[index - 1] {
        charCount[indexOfRepeatedChar].count += 1
    } else {
        charCount.append((char: char, count: 1))
        indexOfRepeatedChar += 1
    }
}

let sortedCharCount = charCount.sorted{$0.count > $1.count}
//        print(sortedCharCount)
//        print(sortedCharCount.count)
var firstEncodedChar: String.Element!

if sortedCharCount[0].count == sortedCharCount[1].count {
    firstEncodedChar = sortedCharCount[1].char
}
let eRawIndex = abcLowercase.firstIndex(of: "e")! // has a type of String.Index
let eIndex = Int(abcLowercase.distance(from: abcLowercase.startIndex, to: eRawIndex)) // here we get an index of Int type

firstEncodedChar = sortedCharCount[0].char
let firstEncodedCharIndex = abcLowercase.firstIndex(of: firstEncodedChar)!
let chIndex = abcLowercase.distance(from: abcLowercase.startIndex, to: firstEncodedCharIndex)
//print(eIndex)
//print(chIndex)
var shiftNumber = chIndex - eIndex
if shiftNumber < 0 {
    shiftNumber += abcLowercase.count
}

func shiftMessage2(message: String, shiftNumber: Int) -> String {
    var result = ""
    for char in message { // khoor
        if String(char).range(of: pattern, options: .regularExpression) != nil {
            result.append(char)
            continue
        }
        if String(char).range(of: "[a-z]", options: .regularExpression) != nil {
            let abcIndex = getIndex(of: char, in: abcLowercase)
            var index = abcIndex - shiftNumber
            if index < 0 { index += 26}
            result.append(abcLowercase[index])
//                    print(abc[index])
        } else if String(char).range(of: "[A-Z]", options: .regularExpression) != nil {
            let abcIndex = getIndex(of: char, in: abc)
            var index = abcIndex - shiftNumber
            if index < 0 { index += 26}
            result.append(abc[index])
//                    print(abc[index])
        }
    }

    return result
}

let shiftedMessage = shiftMessage2(message: message, shiftNumber: shiftNumber)
print(shiftedMessage)

