//
//  Image.swift
//  Bottle Rocket
//
//  Created by Teodora Mratinkovic on 11/24/21.
//

import UIKit

extension UIImageView {
    func loadImage(fromURL urlString: String) {
        guard let imageURL = URL(string: urlString) else {
            return
        }
        DispatchQueue.global(qos: .userInteractive).async {
            guard let imageObj = Cache.cachedImageFrom(urlString: urlString)
                else {
                    let request = URLRequest(url: imageURL)
                    URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                        if let data = data,
                            let image = UIImage(data: data),
                            urlString == response?.url?.absoluteString {
                            Cache.cacheData(data: data, from: urlString)
                            self.assignImage(image)
                        }
                    }).resume()
                    return
            }
            if imageObj.urlString == urlString {
                self.assignImage(imageObj.image)
            }
        }
    }
    
    fileprivate func assignImage(_ image: UIImage) {
        DispatchQueue.main.async {
            if self.image == nil {
                self.image = image
            }
        }
    }
}
