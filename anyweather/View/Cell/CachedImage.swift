//
//  CachedImage.swift
//  anyweather
//
//  Created by Loi Tran on 12/16/21.
//

import SwiftUI
import Kingfisher

struct CachedImage: View {
    var imageName: String
    var body: some View {
        KFImage(URL(string: APIEndpoint.imageBaseUrl + imageName + "@2x.png")!)
    }
}

struct CachedImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedImage(imageName: SampleData.sampleIcon)
    }
}
