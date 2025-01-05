//
//  DataExtensions.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import AVKit

extension Data {
    func dataToVideoURL() -> URL? {
        let tempDirectory = FileManager.default.temporaryDirectory
        let outputUrl = tempDirectory.appendingPathComponent("\(UUID().uuidString).mp4")

        do {
            try write(to: outputUrl)
            return outputUrl
        } catch {
            return nil
        }
    }
}
