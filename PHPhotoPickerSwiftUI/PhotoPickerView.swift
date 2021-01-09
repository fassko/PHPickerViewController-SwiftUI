//
//  PhotoPickerView.swift
//  PHPhotoPickerSwiftUI
//
//  Created by Kristaps Grinbergs on 06/01/2021.
//

import SwiftUI

struct PhotoPickerView: View {
  @State private var photoPickerIsPresented = false
  @State var pickerResult: [UIImage] = []
  
  var body: some View {
    NavigationView {
      ScrollView {
        ForEach(pickerResult, id: \.self) { uiImage in
          ImageView(uiImage: uiImage)
        }
        .padding()
      }
      .edgesIgnoringSafeArea(.bottom)
      .navigationBarTitle("Select Photo", displayMode: .inline)
      .navigationBarItems(trailing: selectPhotoButton)
      .sheet(isPresented: $photoPickerIsPresented) {
        PhotoPicker(pickerResult: $pickerResult,
                    isPresented: $photoPickerIsPresented)
      }
    }
  }
  
  @ViewBuilder
  private var selectPhotoButton: some View {
    Button(action: {
      photoPickerIsPresented = true
    }, label: {
      Label("Select", systemImage: "photo")
    })
  }
}

struct PhotoPickerView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoPickerView()
  }
}
