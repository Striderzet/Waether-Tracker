//
//  ImageCache.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import Foundation
import SwiftUI
import UIKit

struct ImageCache {
    
    @MainActor
    static func showImage(withURL urlString: String) -> any View {
        
        let url = URL(string: urlString) ?? URL(fileURLWithPath: "")
        
        if let cachedImage = loadImage(fromKey: urlString) {
            
            return Image(uiImage: cachedImage)
                .resizable()
            
        } else {
            
            return AsyncImage(url: url, content: { image in
                image
                    .resizable()
                    .onAppear(perform: {
                        let newImage = image.getUIImage()!
                        saveImage(forImage: newImage, withKey: urlString)
                    })
            }, placeholder: {
                Image(systemName: AppConstants.SystemImageName.rainbow)
                    .resizable()
            })
            
        }
        
    }
    
    private static func saveImage(forImage image: UIImage, withKey key: String) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: key)
        }
    }
    
    private static func loadImage(fromKey key: String) -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: key) {
            return UIImage(data: imageData)
        }
        return nil
    }
    
}
