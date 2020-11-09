import Foundation
import UIKit.UIImage
import Kingfisher

public final class ImageLoader {
    public static let shared = ImageLoader()

    public func loadImage(from url: URL, completion: @escaping (UIImage?) -> ()) {
        KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
            completion(image)
        })
        
    }
}
