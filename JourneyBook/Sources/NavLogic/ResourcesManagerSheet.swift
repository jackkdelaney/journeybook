//
//  ResourcesManagerSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import SwiftUI

protocol MediaPickerView : View {
    associatedtype SomePickerItem : PickerItem
    var sheetTitle : String {get}
    var model : SomePickerItem { get}
}

enum ResourcesManagerSheet : Identifiable {
    var id: Self {
        
        return self
    }
    
    case addPhoto
    case addVideo
}

extension ResourcesManagerSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case .addPhoto: PhotosPickerView()
        case .addVideo: VideosPickerView()
        }
    }
}
