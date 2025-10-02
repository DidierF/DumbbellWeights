//
//  ExercisesView.swift
//  DumbbellWeights
//
//  Created by Didier on 10/1/25.
//

import SwiftUI

struct ExercisesView: View {
  var exercises = [
    "Chest Press",
    "Rows",
    "Biceps Curl",
    "Triceps Extensions",
    "Military Press",
    "Bent Over Flies"
  ]

  init() {
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

    UINavigationBar.appearance().barTintColor = UIColor.background
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
  }

  var body: some View {
    NavigationStack {
      ZStack {
        Color
          .background
          .ignoresSafeArea(.all)

        ScrollView() {
          VStack {
            ForEach(exercises, id: \.self) { ex in
              Text(ex)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding()
            }
            //        .padding()
            .frame(minWidth: 300, minHeight: 75)
            .background(.primary2)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerSize: .init(width: 5, height: 5)))
            .padding()
          }
        }

      }
      .navigationTitle("Exercises")
//      .foregroundStyle(.white)
    }
//    .foregroundStyle(.white)
//    .tint(.white)
  }
}

#Preview {
  ExercisesView()
}
