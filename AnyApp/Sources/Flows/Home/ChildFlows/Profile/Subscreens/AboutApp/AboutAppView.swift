//
//  AboutAppView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 21.04.2024.
//

import UI
import UIKit
import AppIndependent

final class AboutAppView: BackgroundPrimary {
    
    override func setup() {
        super.setup()
        body().embed(in: self)
    }
    
    private func body() -> UIView {
        VStack(alignment: .center, spacing: 16) {
            ImageView(image: Asset.logoLarge.image)
                .foregroundStyle(.contentAccentTertiary)
//                .size(CGSize(width: 171 , height: 192))
            Label(text: Profile.aboutApp, foregroundStyle: .contentAccentSecondary, fontStyle: .caption2)
            FlexibleSpacer()
        }
        .layoutMargins(.make(vInsets: 99))
    }
}
