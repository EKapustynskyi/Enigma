import Foundation

let operation = "ENCODE"
let randomNumber = 9
let message = "EVERYONEISWELCOMEHERE"
let abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let rotors = [
    "BDFHJLCPRTXVZNYEIWGAKMUSQO",
    "AJDKSIRUXBLHWTMCQGZNPYFVOE",
    "EKMFLGDQVZNTOWYHXUSPAIBRCJ"
]

//let rotors: [String] = {
//    var rotors = [String]()
//    for i in 0...2 {
//        let rotor = readLine()!
//        rotors.append(rotor)
//    }
//    return rotors
//}()


// AAA -> EFG
func shiftMessage(_ msg: String, with number: Int) -> String {
    var shiftedMessage = ""
    var additionalShift = 0
    for m in msg {//AAA
        for (abcIndex,a) in abc.enumerated() {
            if a == m {
                var rawIndex = abcIndex + number + additionalShift//A->E
                if rawIndex > 51 {
                    rawIndex = rawIndex - 52
                } else if rawIndex > 25 {
                    rawIndex = rawIndex - 26
                }
                // print("rawIndex: \(rawIndex)")
                let index = abc.index(abc.startIndex, offsetBy: rawIndex)
                shiftedMessage.append(abc[index])
                additionalShift += 1//A->F
            }
        }
    }

    return shiftedMessage//EFG
}

func shiftBack(_ msg: String, with number: Int) -> String {
    var shiftedMessage = ""
    var additionalShift = 0
    for m in msg {
        for (abcIndex,a) in abc.enumerated() {
            if a == m {
                var rawIndex = abcIndex - number - additionalShift
                if  rawIndex < -52 {
                    rawIndex = rawIndex + 78
                } else if rawIndex < -26 {
                    rawIndex = rawIndex + 52
                } else if rawIndex < 0 {
                    rawIndex = rawIndex + 26
                }
                let index = abc.index(abc.startIndex, offsetBy: rawIndex)
                shiftedMessage.append(abc[index])
                additionalShift += 1
            }
        }
    }

    return shiftedMessage
}

func map(_ string: String, toRotors rotor: String) -> String {//EFG -> JLC
    var result = ""
    var mappedMessage = ""
    for char in string {//EFG
        let abcIndex = getIndex(of: char, in: abc)
        let index = rotor.index(rotor.startIndex, offsetBy: abcIndex)
        let charToSubstitute = rotor[index]
        mappedMessage.append(charToSubstitute)//E -> J
    }
    // print("abc: \(abc)")
    // print("rot: \(rotor)")
    // print(mappedMessage)
    result = mappedMessage

    return result
}

func mapBack(_ string: String, toRotors rotor: String) -> String {
    var result = ""
    var mappedMessage = ""
    for char in string {
        let rotorIndex = getIndex(of: char, in: rotor)
        let index = abc.index(abc.startIndex, offsetBy: rotorIndex)
        let charToSubstitute = abc[index]
        mappedMessage.append(charToSubstitute)
    }
    result = mappedMessage

    return result
}

 func getIndex(of letter: String.Element, in sequence: String) -> Int {
     for (index,char) in sequence.enumerated() {
         if char == letter {
             return index
         }
     }
     print("Error occured - no index was found!")
     return 0
 }

func encode(_ string: String, with rotors: [String], and randNum: Int) -> String {
    //shift
    let shiftedMessage = shiftMessage(string, with: randNum)

    //Map to rotors
    let mappedRot1 = map(shiftedMessage, toRotors: rotors[0])
    let mappedRot2 = map(mappedRot1, toRotors: rotors[1])
    let mappedRot3 = map(mappedRot2, toRotors: rotors[2])

    return mappedRot3
}

func decode(_ string: String, with rotors: [String], and randNum: Int) -> String {
    //Map to rotors
    let mappedRot3 = mapBack(string, toRotors: rotors[2])
    let mappedRot2 = mapBack(mappedRot3, toRotors: rotors[1])
    let mappedRot1 = mapBack(mappedRot2, toRotors: rotors[0])

    //shift
    let decodedMessage = shiftBack(mappedRot1, with: randNum)
    return decodedMessage
}

// print("operation: \(operation)")
// print("N: \(randomNumber)")
// print("message: \(message)")
// print(shiftedMessage)
if randomNumber >= 0 && randomNumber < 26 && message.count >= 1 && message.count < 50 {
    if operation == "ENCODE" {
        let encodedMessage = encode(message, with: rotors, and: randomNumber)
        print(encodedMessage)
    } else if operation == "DECODE" {
        let decodedMessage = decode(message, with: rotors, and: randomNumber)
        print(decodedMessage)
    }
}
