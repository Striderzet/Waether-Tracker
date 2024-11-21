//
//  Image+Extension.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import Foundation
import SwiftUI
import UIKit

extension Image {
    @MainActor
    func getUIImage() -> UIImage? {
        let image = resizable()
            .scaledToFill()
            .clipped()
        return ImageRenderer(content: image).uiImage
    }
}
