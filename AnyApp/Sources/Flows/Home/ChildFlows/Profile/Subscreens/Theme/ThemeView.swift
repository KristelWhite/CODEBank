//
//  ThemeView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 21.04.2024.
//

import UI
import UIKit
import AppIndependent

final class ThemeView: BackgroundPrimary {
    
    override func setup() {
        super.setup()
        body().embed(in: self)
    }
    
    private func body() -> UIView {
        VStack( alignment: .fill, spacing: 21) {
            ImageView(image: Asset.logo.image)
                .size(CGSize(width: 53, height: 59))
            FlexibleSpacer()
        }
        .layoutMargins(.all(16))
    }
}
