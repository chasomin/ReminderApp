//
//  FileManager+Extension.swift
//  ReminderApp
//
//  Created by 차소민 on 2/19/24.
//

import UIKit

extension UIViewController {
    func saveImageToDocument(image: UIImage, filename: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(filename, conformingTo: .jpeg)
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        do {
            try data.write(to: fileURL)
        } catch {
            print("File save error", error)
        }
    }
    
    func loadImageToDocument(filename: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentDirectory.appendingPathComponent(filename, conformingTo: .jpeg)
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return nil
        }
    }
    
    func deleteImageToDocument(filename: String) {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(filename, conformingTo: .jpeg)
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            do {
                try fileManager.removeItem(at: fileURL)
            } catch {
                print(error)
            }
        }
    }
}

