import Foundation

class RequestModel: Request {

    var method: HTTPMethod = .get
    
    var headers: [String : String]? = nil
    var url: URL = URL(string: "https://textures.cardsmobile.ru")!
    
    var parameters: [String : String]? = nil
    
    var contentType: ContentTypeRequestEnum = .applicationURLEncoder
}
