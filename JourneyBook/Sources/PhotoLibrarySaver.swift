//
//  PhotoLibrarySaver.swift
//  Project301
//
//  Created by Jack Delaney on 18/10/2024.
//

import Foundation
import PhotosUI
import UIKit

class PhotoLibrarySaver: NSObject {
    func writeToPhotoLibrary(image: UIImage) {
        PHPhotoLibrary.shared().performChanges {
            _ = PHAssetChangeRequest.creationRequestForAsset(from: image)

        } completionHandler: { _, _ in
        }
    }
}
