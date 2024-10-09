import UIKit

let message1 = "391813c092a2d5ac9acb705dfe41be3df08de67d1145cbcc3f"
let message2 = "03adeae2c8c2f2336c8a8d312733c2456e76e0b2d9068adc3f"
let message3 = "72d0954e354045f09461dc4c911d0b58ff8963efb12c34303f"

func hexStringToByteArray(_ hex: String) -> [UInt8] {
    var byteArray: [UInt8] = []
    var index = hex.startIndex

    while index < hex.endIndex {
        let nextIndex = hex.index(index, offsetBy: 2)
        if let byte = UInt8(hex[index..<nextIndex], radix: 16) {
            byteArray.append(byte)
        }
        index = nextIndex
    }

    return byteArray
}

let msgByte1 = hexStringToByteArray(message1)
let msgByte2 = hexStringToByteArray(message2)
let msgByte3 = hexStringToByteArray(message3)
var result = [UInt8](repeating: 0, count: msgByte1.count)

for i in 0..<result.count {
    result[i] = msgByte1[i] ^ msgByte2[i] ^ msgByte3[i]
}

if let decoded = String(bytes: result, encoding: .ascii) {
    print(decoded)
} else {
    print("Failed to decode the message.")
}
