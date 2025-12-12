//
//  View+InfinityFrame.swift
//  Space Explorer
//
//  Created by Novus on 25/11/2025.
//

import SwiftUI

extension View {
  func infinityFrame() -> some View {
    self
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
