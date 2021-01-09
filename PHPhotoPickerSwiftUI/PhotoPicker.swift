//
//  PhotoPicker.swift
//  PHPhotoPickerSwiftUI
//
//  Created by Kristaps Grinbergs on 02/01/2021.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
  @Binding var pickerResult: [UIImage]
  @Binding var isPresented: Bool
  
  func makeUIViewController(context: Context) -> some UIViewController {
    var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
    configuration.filter = .images // filter only to images
    configuration.selectionLimit = 0 // ignore limit
    
    let photoPickerViewController = PHPickerViewController(configuration: configuration)
    photoPickerViewController.delegate = context.coordinator
    return photoPickerViewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: PHPickerViewControllerDelegate {
    private let parent: PhotoPicker
    
    init(_ parent: PhotoPicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      parent.pickerResult.removeAll()
      
      for image in results {
        if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
          image.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] newImage, error in
            if let error = error {
              print("Can't load image \(error.localizedDescription)")
            } else if let image = newImage as? UIImage {
              self?.parent.pickerResult.append(image)
            }
          }
        } else {
          print("Can't load asset")
        }
      }
      
      parent.isPresented = false
    }
  }
}
