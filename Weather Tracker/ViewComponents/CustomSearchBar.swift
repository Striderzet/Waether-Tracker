//
//  CustomSearchBar.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import SwiftUI

struct CustomSearchBar: View {
    
    @Binding var searchQuery: String
    var action: () -> ()
    
    var body: some View {
        
        HStack {
            
            TextField(AppConstants.Strings.searchLocation, text: $searchQuery)
                .frame(maxWidth: .infinity)
                .padding()
            
            Spacer()
            
            Button(action: {
                action()
            }, label: {
                Image(systemName: AppConstants.SystemImageName.magGlass)
                    .padding()
                    .foregroundStyle(Color.gray)
            })
            
        }
        .background(RoundedRectangle(cornerRadius: AppConstants.Spacing.spacing12).fill(Color.superLightGrey))
        .padding()
    }
}

#Preview {
    CustomSearchBar(searchQuery: .constant(""), action: { })
}
