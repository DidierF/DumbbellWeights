//
//  helpers.swift
//  DumbbellWeights
//
//  Created by Didier on 10/13/25.
//

import SwiftUI
import UIKit

struct Helpers {
  static func getTitleAttributes() -> [NSAttributedString.Key : Any] {
    let largeTitleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
    let descriptor =
    largeTitleFont
      .fontDescriptor
      .withDesign(.rounded)?
      .withSymbolicTraits(.traitBold
      )
    return [
      .foregroundColor: UIColor.primary1,
      .font: UIFont(
        descriptor: descriptor ?? largeTitleFont.fontDescriptor,
        size: largeTitleFont.pointSize)
    ]
  }
}
