//
//  CenteredScrollView.swift
//  DumbbellWeights
//
//  Created by Didier on 9/13/25.
//

import SwiftUI

struct CenteredScrollView<Content: View>: View {
  let content: Content
  let onCenterChange: (_ newCenter: Double) -> Void
  @Binding var centeredItem: Int
  @Binding var isScrolling: Bool

  init(
    onCenterChange: @escaping (Double) -> Void = {_ in },
    initialItem: Binding<Int>,
    isScrolling: Binding<Bool> = .constant(false),
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
    self.onCenterChange = onCenterChange
    self._centeredItem = initialItem
    self._isScrolling = isScrolling
  }

  var body: some View {
    GeometryReader { outerGeoProxy in
      ScrollViewReader { proxy in
        ScrollView {
          content
        }
        .onScrollGeometryChange(for: Double.self, of: { scrollGeo in
          let scrollY = outerGeoProxy.frame(in: .global).minY
          let scrollH = scrollGeo.bounds.height

          return scrollY + (scrollH / 2)
        }, action: { _, newValue in
          onCenterChange(newValue)
        })
        .defaultScrollAnchor(.center)
        .scrollTargetLayout()
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
        .onChange(of: centeredItem, initial: true) {
          if !isScrolling {
            proxy.scrollTo(centeredItem, anchor: .center)
          }
        }
        .frame(width: outerGeoProxy.size.width)
        .onScrollPhaseChange { oldPhase, newPhase in
          isScrolling = newPhase != .idle
          if !isScrolling {
            proxy.scrollTo(centeredItem, anchor: .center)
          }
        }
      }

    }
  }
}

struct ItemGeometryReader: View {
  private let coordinateSpaceName: String = "scrollView"

  let onChange: (_: CGRect) -> Void

  var body: some View {
    GeometryReader { innerGeoProxy in
      Color.clear
        .onChange(of: innerGeoProxy.frame(in: .named(self.coordinateSpaceName))) {_, nv in
          onChange(nv)
        }
    }
  }
}

#Preview {
  CenteredScrollView(initialItem: .constant(0)) { }
}
