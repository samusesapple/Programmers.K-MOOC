import UIKit

class ImageLoader {
    
    private static let imageCache = NSCache<NSString, UIImage>()
    
    static func loadImage(url: String, completed: @escaping (UIImage?) -> Void) {
        // 캐싱 된 이미지 있는지 먼저 확인
        if let cachedImage = imageCache.object(forKey: NSString(string: url)) {
            print("캐싱된 이미지 가져옴")
            DispatchQueue.main.async {
                completed(cachedImage)
            }
        } else {
            // 캐싱된 이미지 없는 경우, 이미지 네크워킹 통해 받기 + 캐싱하기
            guard let url = URL(string: url) else { print("URL ERROR"); return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print(error as Any)
                    return
                }
                guard let dataImage = UIImage(data: data) else { return }
                imageCache.setObject(dataImage, forKey: NSString(string: url.absoluteString))
                DispatchQueue.main.async {
                    completed(dataImage)
                }
            }.resume()
        }
    }
}
