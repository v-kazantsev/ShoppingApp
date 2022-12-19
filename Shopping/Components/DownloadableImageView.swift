//
//  DownloadableImageView.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI

struct DownloadableImageView: View {
    
    var imageURL: String = ""
    var placeholderImage: String = "questionmark.app"
    var body: some View {
        AsyncImage(url: URL(string: imageURL)!) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Image(systemName: placeholderImage)
                        .font(.system(size: 50))
                        
                } else {
                  ProgressView()
                        .font(.largeTitle)
                }
            }
    }
}
