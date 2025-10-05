//
//  ExercisesView.swift
//  DumbbellWeights
//
//  Created by Didier on 10/1/25.
//

import SwiftUI
import SwiftData

struct ExercisesView: View {
  @Query(sort: [SortDescriptor(\Exercise.name)]) var exercises: [Exercise]
  @State var selected: [Exercise] = []

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
            ForEach(exercises, id: \.id) { ex in
              let isSelected = selected.contains(ex)
              ExerciseButton(
                title: ex.name,
                isSelected: isSelected) {
                  if isSelected {
                    selected.remove(at: selected.firstIndex(of: ex)!)
                  } else {
                    selected.append(ex)
                  }
                  print(selected)
                }
            }
          }
        }
        .scrollIndicators(.hidden)
      }
      .overlay(alignment: .bottomTrailing) {
        NavigationLink {
          WorkoutView(exercises: $selected)
            .navigationBarBackButtonHidden()
        } label: {
          Image(systemName: "arrow.right")
            .resizable()
            .scaledToFit()
            .tint(.white)
            .frame(width: 28)
            .frame(width: 44, height: 44)
            .padding(8)
            .background(.primary2)
            .clipShape(
              Circle()
            )
            .padding(.init(top: 0, leading: 0, bottom: 8, trailing: 16))
        }
        .disabled(selected.isEmpty)
      }
      .navigationTitle("Exercises")
      .onAppear {
        selected = []
      }
    }
  }
}

#Preview {
  ExercisesView()
    .modelContainer(DataController.previewContainer)
}
