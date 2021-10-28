import Foundation

class FileReader {
    static func read<T: Codable>(filename: String) -> [T] {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Could not find the \(filename) file")
        }
        
        do {
            let data = try Data(contentsOf: file)
            return try JSONDecoder().decode([T].self, from: data)
        }
        catch {
            fatalError("Failed to read from file: \(error)")
        }
    }
    
}

struct CodableContact: Codable {
    let name: String
    let dob: String
    let phone: String
    let email: String
    let address: String
}
