import Foundation

enum ContentTypeRequestEnum: String {
    case applicationJson = "application/json"
    case applicationURLEncoder
    case none
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case head = "HEAD"
}

protocol Request {
    var url: URL { get set }
    var method: HTTPMethod { get set }
    var headers: [String: String]? { get set }
    var parameters: [String: String]? { get set }
    var contentType: ContentTypeRequestEnum { get set }
}

extension String: Request {
    var contentType: ContentTypeRequestEnum {
        get {
            return .none
        }
        set {}
    }
    
    var headers: [String : String]? {
        get {
            return nil
        }
        set {}
    }
    
    var method: HTTPMethod {
        get {
            return .get
        }
        set {}
    }
    
    var parameters: [String : String]? {
        get {
            return nil
        }
        set {}
    }
    
    var url: URL {
        get {
            return URL(string: self)!
        }
        set {}
    }
}

extension URLSession {
    func dataTask(with request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: prepareUrlRequest(from: request), completionHandler: completionHandler)
    }
    
    func dataTask<T: Decodable>(with request: Request, decoder: JSONDecoder, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: prepareUrlRequest(from: request)) { (data, response, error) in
            if let data = data {
                do {
                    let json = try decoder.decode(T.self, from: data)
                    completionHandler(json, response, error)
                } catch {
                    completionHandler(nil, response, error)
                }
            } else {
                completionHandler(nil, response, error)
            }
        }
    }
    
    func dataTask(with request: Request, completionHandler: @escaping (Any?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: prepareUrlRequest(from: request)) { (data, response, error) in
            if let data = data {
                do {
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    completionHandler(json, response, error)
                }
            } else {
                completionHandler(nil, response, error)
            }
        }
    }
    
    private func prepareUrlRequest(from request: Request) -> URLRequest {
        guard var urlComponents = URLComponents(url: request.url, resolvingAgainstBaseURL: true) else {
            fatalError("Couldn't create url components from url: \(request.url.absoluteString)")
        }
        
        var queryItems: [URLQueryItem] = []
        
        if request.method == .get {
            request.parameters?.forEach{ (key, value) in
                queryItems.append(URLQueryItem(name: key, value: value))
            }

            urlComponents.queryItems = queryItems
        }

        
        guard let url = urlComponents.url else {
            fatalError("Couldn't create url with these parameters")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(request.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = request.method.rawValue
        
        if request.method == .post, let parameters = request.parameters, request.contentType == .applicationURLEncoder {
            urlRequest.httpBody = parameters.map { key, value in
                let keyString = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                let valueString = value.stringByAddingPercentEncodingToData()!
                return keyString + "=" + valueString
            }.joined(separator: "&").data(using: .utf8)
        }
        
        if request.method == .post, let parameters = request.parameters, request.contentType == .applicationJson {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
            } catch {
            }
        }
        
        request.headers?.forEach{ (key, value) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}

extension String {
    func stringByAddingPercentEncodingToData() -> String? {
        let finalString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)?.replacingOccurrences(of: "&", with: "%26").replacingOccurrences(of: "+", with: "%2B")
        return finalString
    }
}
