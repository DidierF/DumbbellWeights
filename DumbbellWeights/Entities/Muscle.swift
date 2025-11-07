//
//  Muscle.swift
//  DumbbellWeights
//
//  Created by Didier on 11/7/25.
//

import Foundation
import SwiftData

@Model
class Muscle {
  var name: String
  var exercises: [Exercise]?

  init(_ name: String) {
    self.name = name
  }
}
