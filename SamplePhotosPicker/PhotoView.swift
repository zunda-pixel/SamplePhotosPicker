//
// PhotoView.swift
//


import SwiftUI
import AVKit
import Photos

struct PhotoView: View {
  let photo: Photo

  var body: some View {
    switch photo.item {
      case let livePhoto as PHLivePhoto:
        LivePhotoView(livePhoto: livePhoto)
      case let movie as Movie:
        let player = AVPlayer(url: movie.url)
        VideoPlayer(player: player)
      case let image as ImageData:
        Image(imageData: image)
          .resizable()
          .scaledToFit()
      default:
        fatalError()
    }
  }
}
