//
//  ExplorePlanetsPickerView.swift
//  Space Explorer
//
//  Created by Novus on 11/12/2025.
//
import SwiftUI

struct ExplorePlanetsPickerView: View {
  @Binding var currentSelection: ResultsType
  
  init(_ currentSelection: Binding<ResultsType>) {
    self._currentSelection = currentSelection
  }
  
  var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .leading) {
        backgroundView(proxy: proxy)
        pickerView
      }
      .background(
        RoundedRectangle(cornerRadius: AppCornerRadius.button.value)
          .foregroundStyle(Color.appTheme.cellBackground.opacity(0.4))
      )
      .shadow(.regular)
    }
    .frame(height: 40)
  }
  
  private func select(_ type: ResultsType) {
    withAnimation {
      currentSelection = type
    }
  }
}

private extension ExplorePlanetsPickerView {
  @ViewBuilder
  func backgroundView(proxy: GeometryProxy) -> some View {
      let selectedIndex = ResultsType.allCases.firstIndex(of: currentSelection) ?? 0
    let buttonWidth = proxy.size.width / CGFloat(ResultsType.allCases.count)
    let backgroundOffset = CGFloat(selectedIndex) * buttonWidth
    RoundedRectangle(cornerRadius: AppCornerRadius.button.value)
      .foregroundStyle(Color.appTheme.cellBackground)
      .frame(width: buttonWidth)
      .offset(x: backgroundOffset)
      .animation(.spring(response: 0.5, dampingFraction: 0.7), value: currentSelection)
  }
  
  var pickerView: some View {
    HStack(spacing: 0) {
        ForEach(ResultsType.allCases) { type in
        OptionButton(type: type, isSelected: currentSelection == type) {
          select(type)
        }
      }
    }
  }
}

extension ExplorePlanetsPickerView {
  struct OptionButton: View {
    let type: ResultsType
    let isSelected: Bool
    let action: () -> ()
    
    var body: some View {
      Button { action() } label: {
        Text("\(type.description)")
          .font(.callout.weight(.medium))
          .minimumScaleFactor(0.4)
          .padding(8)
          .foregroundColor(isSelected ? Color.appTheme.text : Color.appTheme.text.opacity(0.7))
          .frame(maxWidth: .infinity, alignment: .center)
      }
    }
  }
}

extension ExplorePlanetsPickerView {
  enum ResultsType {
    case solarSystem
    case planetsList
  }
}

extension ExplorePlanetsPickerView.ResultsType: Identifiable {
  var id: UUID { .init() }
}

extension ExplorePlanetsPickerView.ResultsType: CustomStringConvertible {
    var description: String {
        switch self {
        case .solarSystem:
            "Solar System"
        case .planetsList:
            "Planets"
        }
    }
}

extension ExplorePlanetsPickerView.ResultsType: CaseIterable { }

#Preview {
  Preview()
}

fileprivate struct Preview: View {
    @State private var resultsType: ExplorePlanetsPickerView.ResultsType = .solarSystem
  
  var body: some View {
      ExplorePlanetsPickerView($resultsType)
      .padding()
      .infinityFrame()
      .background(Color.appTheme.viewBackground)
  }
}

