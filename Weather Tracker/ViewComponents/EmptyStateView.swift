//
//  EmptyStateView.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("No City Selected")
                .font(.largeTitle.bold())
            Text("Please Search For A City")
                .font(.headline)
        }
        .padding(.top, 200)
    }
}

#Preview {
    EmptyStateView()
}
