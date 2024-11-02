import Foundation
import CommonCrypto

let targetHash = "482c811da5d5b4bc6d497ffa98491e38" // із "password123"

// Функція MD5
func md5(string: String) -> String {
    let data = Data(string.utf8)
    var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
    data.withUnsafeBytes {
        _ = CC_MD5($0.baseAddress, CC_LONG(data.count), &hash)
    }
    return hash.map { String(format: "%02hhx", $0) }.joined()
}

// Функція перебору
func bruteForceMD5(targetHash: String) {
    let characters = Array("0123456789")
    let length = 5

    var currentCombination = [Character](repeating: characters[0], count: length)

    while true {
        let attempt = String(currentCombination)
        let hash = md5(string: attempt)

        if hash == targetHash {
            print("Found: \(attempt)")
            return
        }

        for i in stride(from: length - 1, through: 0, by: -1) {
            if currentCombination[i] != characters.last {
                if let index = characters.firstIndex(of: currentCombination[i]) {
                    currentCombination[i] = characters[index + 1]
                    break
                }
            } else {
                currentCombination[i] = characters[0]
            }
        }

        // Якщо перша позиція повернулася до початку, всі комбінації були перевірені
        if currentCombination.allSatisfy({ $0 == characters[0] }) {
            print("No match found")
            break
        }
    }
}

bruteForceMD5(targetHash: targetHash)

//let hash = md5(string: "password123")
