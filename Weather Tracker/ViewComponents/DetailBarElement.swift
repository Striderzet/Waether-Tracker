//
//  DetailBarElement.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import SwiftUI

struct DetailBarElement: View {
    
    let title: String
    let value: LocalizedStringKey
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(Color.gray)
            Text(value)
                .font(.system(size: 14))
                .foregroundStyle(Color.darkGrey)
        }
        .padding()
    }
}


