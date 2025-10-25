//
//  WeightChartView.swift
//  DumbbellWeights
//
//  Created by Didier on 10/23/25.
//

import SwiftUI
import Charts

struct WeightChartView: View {

  var datapoints: [Int]
  var showAxis: Bool

  var minWeight: Int = 999

  var maxWeight: Int = 0

  init(datapoints: [Int], showAxis: Bool = false) {
    self.datapoints = datapoints
    self.showAxis = showAxis

    for point in datapoints {
      minWeight = min(minWeight, point)
      maxWeight = max(maxWeight, point)
    }

    if datapoints.count == 0 {
      minWeight = 0
      maxWeight = 100
    }
  }

  var body: some View {
    Chart {
      ForEach(Array(datapoints.enumerated()), id: \.offset) { index, point in
        LineMark(x: .value(showAxis ? "\(point)" : "", index), y: .value("", point))
          .interpolationMethod(.cardinal)
      }
    }
    .padding()
    .foregroundStyle(Color.primary1)
    .background(Color.primary9)
    .chartYScale(domain: [minWeight-10, maxWeight+10])
    .chartYAxis(showAxis ? .visible : .hidden)
    .chartYAxis {
      AxisMarks(values: .automatic(desiredCount: 5))
      AxisMarks {
        AxisValueLabel()
          .foregroundStyle(Color.primary1)

        AxisGridLine()
          .foregroundStyle(Color.primary7)
      }
    }
    .chartXAxis(showAxis ? .visible : .hidden)
    .chartXAxis {
      AxisMarks {
        AxisValueLabel()
          .foregroundStyle(Color.primary1)

        AxisGridLine()
          .foregroundStyle(Color.primary7)
      }
    }
  }
}

#Preview {
  BackgroundView {
    VStack {
      WeightChartView(datapoints: [2, 4, 6, 7, 8, 9, 10], showAxis: false)
      WeightChartView(datapoints: [2, 4, 6, 7, 8, 9, 10], showAxis: true)
    }
  }
}
