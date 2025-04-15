//
//  PhotosPickerViewModelTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 14/04/2025.
//

import Foundation
import PhotosUI
import SwiftUI
import Testing

@testable import JourneyBook

struct PhotosPickerViewModelTests {

    @MainActor @Test
    func testInitialisationSetsDefaultPropertiesCorrectly() {
        let model = PhotosPickerViewModel()

        #expect(model.selectedItem == nil)
        #expect(model.selectedItemText == nil)

    }

    @MainActor @Test
    func setSelectedItemTextManaully() {
        let model = PhotosPickerViewModel()

        model.selectedItemText = "HOWDY!!"

        #expect(model.selectedItemText == "HOWDY!!")

    }

    @MainActor @Test
    func testSelectedItemMockImage() {
        let model = PhotosPickerViewModel()

        let image = mockedImage()
        model.selectedItem = image

        #expect(model.selectedItem == image)
    }


    @MainActor @Test
    func testGetLoadedNoImage() {
        let model = PhotosPickerViewModel()

        model.selectedItem = nil

        #expect(model.selectedItem == nil)
    }


    @MainActor @Test
    func testClearItemResetsSelection() {
        let model = PhotosPickerViewModel()

        let image = mockedImage()
        model.selectedItem = image
        
        model.selectedItemText = "HOWDY!!"
        model.clearItem()

        #expect(model.selectedItemText == nil)
        #expect(model.selectedItem == nil)

    }
    
    
    private func mockedImage(color: UIColor = .purple, size: CGSize = CGSize(width: 52, height: 982)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}
