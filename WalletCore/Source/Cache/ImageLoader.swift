import Foundation
import UIKit.UIImage

public final class ImageLoader {
    public static let shared = ImageLoader()

    private let cache: ImageCacheType

    public init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }

    public func loadImage(from url: URL, completion: @escaping (UIImage?) -> ()) {
        if let image = cache[url] {
            completion(image)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, let mimeType = response?.mimeType, mimeType.hasPrefix("image"), let data = data, error == nil, let image = UIImage(data: data) else { return completion(nil) }
                self.cache[url] = image
                DispatchQueue.main.async() {
                    completion(image)
                }
            }.resume()
        }
        
    }
}
