import Foundation
import WalletPresentationData

public class Api {
    
    let proto = "https://"
    var host = "textures.cardsmobile.ru"
    var apiUrl = "textures.cardsmobile.ru/public"
    private let urlSession = URLSession(configuration: .default)
    
    var logs: Bool = true
    
    public init(logs: Bool) {
        self.logs = logs
    }
    
    // MARK: Получения списка карт
    public func getCards<T: Codable>(completion: @escaping (Result<T>) -> ()) {
        requestObject("/kmc.json", method: .get, parameters: nil, headers: nil, completion: completion)
    }
    
}

extension Api {
    
    // MARK: Request
    private func requestObject<T: Codable>(_ url: String, method: HTTPMethod, parameters: [String: String]?, headers: [String : String]?, completion: @escaping (Result<T>) -> ()) {
        
        let fullUrl = proto + apiUrl + url
        guard let url = URL(string: fullUrl) else { return completion(Result.failure(errorType: .connectionError(message: ""))) }
        
        
        // Request Model
        let request = RequestModel()
        request.url = url
        request.parameters = parameters
        request.headers = headers
        request.method = method
        
        if logs {
            print("URL: \(url)")
            if let parameters = parameters {
                print("Parameters:  \(parameters)")
            }
            if let headers = headers {
                print("Headers:  \(headers)")
            }
        }
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            if data == nil, error == nil {
                completion(Result.failure(errorType: .connectionError(message: Strings.noInternetConnection)))
            }
            
            guard let data = data else { return completion(Result.failure(errorType: .connectionError(message: Strings.noInternetConnection))) }
            
            Parser.decode(data, completion: completion)
        }
        
        dataTask.resume()
    }
}
