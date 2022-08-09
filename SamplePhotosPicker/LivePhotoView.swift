//
// LivePhotoView.swift
//


import SwiftUI
import PhotosUI

#if os(macOS)
typealias ViewRepresentable = NSViewRepresentable
#else
typealias ViewRepresentable = UIViewRepresentable
#endif

struct LivePhotoView: ViewRepresentable {
  let livePhoto: PHLivePhoto

  #if os(macOS)
  func makeNSView(context: Context) -> some NSView {
    let livePhotoView = PHLivePhotoView(frame: .zero)
    livePhotoView.livePhoto = livePhoto
    return livePhotoView
  }

  func updateNSView(_ nsView: NSViewType, context: Context) { }
  #else
  func makeUIView(context: Context) -> PHLivePhotoView {
    let livePhotoView = PHLivePhotoView(frame: .zero)
    livePhotoView.livePhoto = livePhoto
    return livePhotoView
  }

  func updateUIView(_ livePhotoView: PHLivePhotoView, context: Context) { }
  #endif
}
