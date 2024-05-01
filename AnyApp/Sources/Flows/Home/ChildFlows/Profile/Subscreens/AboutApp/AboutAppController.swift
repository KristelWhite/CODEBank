//
//  AboutAppController.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 21.04.2024.
//

import UI
import UIKit

final class AboutAppController: TemplateViewController<AboutAppView> {

    override func setup() {
        super.setup()
        self.navigationItem.title = Profile.aboutApp
    }
}
