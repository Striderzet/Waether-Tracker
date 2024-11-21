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
            
            TextField("Search Location", text: $searchQuery)
                .padding()
            
            Spacer()
            
            Button(action: {
                action()
            }, label: {
                Image(systemName: "magnifyingglass")
                    .padding()
                    .foregroundStyle(Color.gray)
            })
            
        }
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.superLightGrey))
        .padding()
    }
}

#Preview {
    CustomSearchBar(searchQuery: .constant(""), action: { })
}
