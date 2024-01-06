//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Yunus Emre Berdibek on 27.12.2023.
//

import Foundation
import SwiftUI

final class LocalFileManager {
    static let shared: LocalFileManager = .init()

    private init() {}

    func saveImage(image: UIImage, imageName: String, folderName: String) {
        /// Create folder
        createFolderIfNeeded(folderName: folderName)
        /// Get path for image
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName) else { return }
        /// Save image to path
        do {
            try data.write(to: url)
        } catch {
            print("Error saving image, imageName: \(imageName), with error: \(error.localizedDescription)")
        }
    }

    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path())
        else {
            return nil
        }
        return UIImage(contentsOfFile: url.path())
    }

    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderNname: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func getURLForFolder(folderNname: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderNname, conformingTo: .archive)
    }

    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderNname: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png", conformingTo: .archive)
    }
}
