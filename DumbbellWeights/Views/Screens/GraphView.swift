//
//  GraphView.swift
//  DumbbellWeights
//
//  Created by Didier on 10/20/25.
//

import SwiftUI
import Charts

enum GraphType: String, CaseIterable, Identifiable {
  case max = "Max"
  case average = "Average"

  var id: Self { self }
}

struct GraphView: View {

  @State var currentGraph: GraphType = .max

  var body: some View {
    BackgroundView {
      VStack {

        HStack {
          ForEach(GraphType.allCases) { type in
            let title = type.rawValue.prefix(1).capitalized + type.rawValue.dropFirst()
            Button {
              currentGraph = type
            } label: {
              Text(title)
                .foregroundStyle(Color.primary1)
            }
            .padding()
            .background(currentGraph == .average ? Color.primary4 : Color.primary8)
            .clipShape(RoundedRectangle(cornerRadius: 12))
          }
        }

        Chart {
          LineMark(x: .value("", 5), y: .value("", 5))
            .interpolationMethod(.cardinal)
          LineMark(x: .value("", 6), y: .value("", 5))
          LineMark(x: .value("", 7), y: .value("", 6))
          LineMark(x: .value("", 8), y: .value("", 6))
          LineMark(x: .value("", 9), y: .value("", 7))
          LineMark(x: .value("", 10), y: .value("", 6))
          LineMark(x: .value("", 12), y: .value("", 12))
          LineMark(x: .value("", 14), y: .value("", 15))
          LineMark(x: .value("", 16), y: .value("", 16))
          LineMark(x: .value("", 18), y: .value("", 13))
          LineMark(x: .value("", 20), y: .value("", 18))
        }
        .foregroundStyle(Color.primary1)
        .background(Color.primary9)
        .frame(height: 300)
        .chartYAxisLabel("Weight")
        .chartYScale(domain: [0, 20])
        .chartYAxis {
          AxisMarks(values: .automatic(desiredCount: 5))
          AxisMarks {
            AxisValueLabel()
              .foregroundStyle(Color.primary1)

            AxisGridLine()
              .foregroundStyle(Color.primary7)
          }
        }
        .chartXAxis {
          AxisMarks {
            AxisValueLabel()
              .foregroundStyle(Color.primary1)

            AxisGridLine()
              .foregroundStyle(Color.primary7)
          }
        }

        Spacer()
      }
//      .padding(.horizontal)
    }
  }
}

#Preview {
  GraphView()
}
