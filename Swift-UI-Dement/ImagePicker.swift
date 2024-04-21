//
//  ImagePicker.swift
//  Swift-UI-Dement
//
//  Created by Vasav Srivastava on 4/20/24.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Binding var showImagePicker: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .photoLibrary
      imagePicker.delegate = context.coordinator
      
    return imagePicker
  }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent: ImagePicker
    
    init(_ picker: ImagePicker) {
        self.parent = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Image Selected")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.parent.selectedImage = image
            }
        }
        parent.showImagePicker = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancelled")
        
        parent.showImagePicker = false
    }
}
