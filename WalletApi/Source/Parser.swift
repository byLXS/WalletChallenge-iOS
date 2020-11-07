import Foundation

struct Parser {
    
    static func decode<T: Codable>(_ data: Any, completion: @escaping (Result<T>) -> ()) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            let item = try JSONDecoder().decode(T.self, from: jsonData)
            completion(Result.success(data: item))
            
        } catch let error {
            print(error)
            completion(Result.failure(errorType: .connectionError(message: "")))
        }
    }
    
}
