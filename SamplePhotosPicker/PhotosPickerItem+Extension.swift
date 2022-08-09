//
// PhotosPickerItem+Extension.swift
//

import PhotosUI
import SwiftUI

extension PhotosPickerItem {
  func loadPhoto() async throws -> Any {
    if let livePhoto = try await self.loadTransferable(type: PHLivePhoto.self) {
      return livePhoto
    } else if let movie = try await self.loadTransferable(type: Movie.self) {
      return movie
    } else if let data = try await self.loadTransferable(type: Data.self) {
      if let image: ImageData = .init(data: data) {
        return image
      }
    }

    fatalError()
  }
}
