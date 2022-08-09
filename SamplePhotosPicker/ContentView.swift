//
// ContentView.swift
//


import SwiftUI
import PhotosUI

struct ContentView: View {
  @State var photoPickerItems: [PhotosPickerItem] = []
  @State var photos: [Photo] = []
  @State var error: Error?
  @State var didError = false

  func loadPhotos(with pickers: [PhotosPickerItem]) async throws {
    let oldPhotos = photos
    var newPhotos: [Photo] = []

    for picker in pickers {
      if let foundPhoto = oldPhotos.first(where: { $0.id == picker.itemIdentifier }) {
        newPhotos.append(foundPhoto)
      } else {
        let item = try await picker.loadPhoto()
        let newPhoto = Photo(id: picker.itemIdentifier, item: item)
        newPhotos.append(newPhoto)
      }

      photos = newPhotos
    }

    photos = newPhotos
  }

  var body: some View {
    NavigationStack {
      Group {
        if photos.isEmpty {
          Text("Pick Photo")
        } else {
          TabView {
            ForEach(photos) { photo in
              PhotoView(photo: photo)
              #if os(macOS)
                .tabItem {
                  Label("photo", systemImage: "photo")
                }
              #endif
            }
          }
          #if !os(macOS)
          .tabViewStyle(.page(indexDisplayMode: .always))
          #endif
          .background(.secondary)
        }
      }

      .alert("Error", isPresented: $didError) {
        Button("Close") {
          print(error!)
        }
      }
      .toolbar {
        PhotosPicker(selection: $photoPickerItems,
                     maxSelectionCount: 0,
                     selectionBehavior: .ordered,
                     preferredItemEncoding: .current,
                     photoLibrary: .shared()) {
          Image(systemName: "photo")
        }
      }
      .onChange(of: photoPickerItems) { newPickerItems in
        Task {
          do {
            try await loadPhotos(with: newPickerItems)
          } catch let newError {
            error = newError
            didError.toggle()
          }
        }
      }
    }
  }
}
