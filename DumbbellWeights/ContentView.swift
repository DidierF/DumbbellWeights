//
//  ContentView.swift
//  DumbbellWeights
//
//  Created by Didier on 8/28/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//

  var workout = UpperBodyWorkout()

  @State var baseWeight = 35;
  var weightDiff = 5;

  var numberOfSets = 3;
  @State var currentSet = 0;

  @State var chosenWeights: [[Int]] = [];

  @State var visibleWeights: [Int] = [];

  init() {
    updateWeights();
    chosenWeights = [];
  }

  func updateWeights() {
    visibleWeights = [
      baseWeight + weightDiff*2,
      baseWeight + weightDiff,
      baseWeight,
      baseWeight - weightDiff,
      baseWeight - weightDiff*2
    ];
  }

  var body: some View {
    Text(workout.exercises[currentSet].name)
      .font(.title)
      .fontWeight(.bold)

    Spacer()

    HStack {
      Text("( ")
      if chosenWeights.count > currentSet {
        ForEach(chosenWeights[currentSet], id: \.self) { w in
          Text(String(w))
        }
      }
      Text(" )")
    }

    Spacer()


    Button("+") {
      baseWeight += weightDiff;
      updateWeights();
    }

    VStack(alignment: .center, spacing: 8) {
      ForEach(visibleWeights, id: \.self) { weight in
        WeightButton(title: String(weight), action: {
          print(chosenWeights)
          if (chosenWeights.count <= currentSet) {
            chosenWeights.insert([weight], at: currentSet)
          } else {
            chosenWeights[currentSet].append(weight)
          }
          print(chosenWeights)
        })
      }
    }.onAppear {updateWeights()}


    Button("-") {
      baseWeight -= weightDiff;
      updateWeights();
    }


    Spacer()

    HStack {
      Button("Next exercise", action: {
        print(workout.exercises.count)
        print(currentSet + 1)
        if (workout.exercises.count > currentSet + 1) {
          currentSet += 1;
        }

      })
    }

    Spacer()
  }

//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//#if os(iOS)
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//#endif
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

#Preview {
    ContentView()//.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
