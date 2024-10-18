//
//  PhotoLibrarySaver.swift
//  Project301
//
//  Created by Jack Delaney on 18/10/2024.
//

import Foundation
import UIKit

class PhotoLibrarySaver: NSObject {
    func writeToPhotoLibrary(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(completedTheSave), nil)
    }

    @objc func completedTheSave(_: UIImage, didFinishSavingWithError _: Error?, contextInfo _: UnsafeRawPointer) {
        print("Save done.")
    }
}
