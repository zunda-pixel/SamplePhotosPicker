//
// ImageData.swift
//


import SwiftUI

#if os(macOS)
typealias ImageData = NSImage
#else
typealias ImageData = UIImage
#endif

extension Image {
  init(imageData: ImageData) {
    #if os(macOS)
    self.init(nsImage: imageData)
    #else
    self.init(uiImage: imageData)
    #endif
  }
}
