import Foundation

class HammingCode {

    // Encode function
    func encode(_ message: String) -> String {
        var binaryString = ""

        // Step 1: Convert each character to 8-bit ASCII binary
        for char in message.utf8 {
            var byte = String(char, radix: 2)
            byte = String(repeating: "0", count: 8 - byte.count) + byte // Make it 8-bit binary
            binaryString += byte
        }

        // Step 2: Triple each bit
        var tripledBits = ""
        for bit in binaryString {
            tripledBits += String(repeating: bit, count: 3)
        }

        return tripledBits
    }
}

extension HammingCode {

    // Decode function
    func decode(_ encodedMessage: String) -> String {
        var correctedBits = ""

        // Step 1: Split into triplets and correct bit flips
        let triplets = getParts(encodedMessage, size: 3)
        for triplet in triplets {
            let sum = triplet.reduce(0) { $0 + Int(String($1))! }
            correctedBits += sum >= 2 ? "1" : "0" // Majority voting: if 2+ bits are '1', set to '1', else '0'
        }

        // Step 2: Split corrected bits into 8-bit segments
        let bytes = getParts(correctedBits, size: 8)
        var decodedCharacters = ""

        // Step 3: Convert each 8-bit binary string to ASCII character
        for byteString in bytes {
            if let asciiValue = UInt8(byteString, radix: 2) {
                decodedCharacters.append(Character(UnicodeScalar(asciiValue)))
            }
        }

        return decodedCharacters
    }

    // Helper function to split a string into parts of a given size
    private func getParts(_ string: String, size: Int) -> [String] {
        var parts = [String]()
        let length = string.count
        for i in stride(from: 0, to: length, by: size) {
            let start = string.index(string.startIndex, offsetBy: i)
            let end = string.index(start, offsetBy: size, limitedBy: string.endIndex) ?? string.endIndex
            parts.append(String(string[start..<end]))
        }
        return parts
    }
}

let hamming = HammingCode()
let encoded = hamming.encode("Hi")
print("Encoded:", encoded)

let decoded = hamming.decode(encoded)
print("Decoded:", decoded)
