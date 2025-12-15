//
//  SegmentedPickerView.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//
import SwiftUI

struct SegmentedPickerView<Option: CaseIterable & Hashable & CustomStringConvertible>: View {
    @Binding var selection: Option
    
    private var allOptions: [Option] {
        Array(Option.allCases)
    }
    
    init(_ selection: Binding<Option>) {
        self._selection = selection
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
    
    private func select(_ option: Option) {
        withAnimation {
            selection = option
        }
    }
}

private extension SegmentedPickerView {
    @ViewBuilder
    func backgroundView(proxy: GeometryProxy) -> some View {
        if let selectedIndex = allOptions.firstIndex(of: selection) {
            let buttonWidth = proxy.size.width / CGFloat(allOptions.count)
            let backgroundOffset = CGFloat(selectedIndex) * buttonWidth

            RoundedRectangle(cornerRadius: AppCornerRadius.button.value)
                .foregroundStyle(Color.appTheme.cellBackground)
                .frame(width: buttonWidth)
                .offset(x: backgroundOffset)
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: selection)
        } else {
            EmptyView()
        }
    }
    var pickerView: some View {
        HStack(spacing: 0) {
            ForEach(allOptions, id: \.self) { option in
                OptionButton(
                    title: option.description,
                    isSelected: selection == option
                ) {
                    select(option)
                }
            }
        }
    }
}

extension SegmentedPickerView {
    struct OptionButton: View {
        let title: String
        let isSelected: Bool
        let action: () -> ()
        
        var body: some View {
            Button(action: action) {
                Text(title)
                    .font(.callout.weight(.medium))
                    .minimumScaleFactor(0.4)
                    .padding(8)
                    .foregroundColor(
                        isSelected
                        ? Color.appTheme.text
                        : Color.appTheme.text.opacity(0.7)
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
