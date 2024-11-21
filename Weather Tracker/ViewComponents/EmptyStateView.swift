//
//  EmptyStateView.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: AppConstants.Spacing.spacing8) {
            Text(AppConstants.Strings.noCitySelected)
                .font(.largeTitle.bold())
            Text(AppConstants.Strings.searchForCity)
                .font(.headline)
        }
        .padding(.top, AppConstants.Padding.padding200)
    }
}

#Preview {
    EmptyStateView()
}
