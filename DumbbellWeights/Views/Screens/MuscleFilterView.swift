//
//  MuscleFilterView.swift
//  DumbbellWeights
//
//  Created by Didier on 10/25/25.
//

import SwiftUI

struct MuscleFilterView: View {

  var options: [Muscle]
  var selected: Muscle?
  var onChange: (Muscle) -> Void

  var body: some View {
    ScrollView(.horizontal) {
      HStack {
        ForEach(options) { m in
          Button(action: {
            onChange(m)
          }) {
            Text(m.name)
              .foregroundStyle(.primary1)
              .padding()
              .background(m.id == selected?.id ? .primary8 : .primary9)
              .clipShape(.rect(cornerRadius: 12))

          }
        }
      }
    }
    .scrollIndicators(.hidden)

  }
}


#Preview {
  var selected = Muscle("Selected")
  var muscles = [selected] + Array(repeating: Muscle("Muscle"), count: 10)
  MuscleFilterView(
    options: muscles,
    selected: selected) { m in
    }
}

