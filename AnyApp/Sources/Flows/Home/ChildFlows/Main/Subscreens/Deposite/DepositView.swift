//
//  DepositeView.swift
//  AnyApp
//
//  Created by Кристина Пастухова on 24.04.2024.
//

import UI
import UIKit
import AppIndependent

final class DepositView: BackgroundPrimary {


    private let tableView = BaseTableView()
    private let switchView = SwitchView()
    private lazy var dataSource = DepositDataSource(tableView: tableView)
    
    var props: Props?

    override func setup() {
        super.setup()
        setupBindings()
//        guard let props = props else { return }
//        body(with: props).embed(in: self)
    }

    private func body(with props: Props) -> UIView {
        ScrollView(axis: .vertical) {
            VStack {
                VStack( alignment: .center, distribution: .fill ) {
                    BackgroundView {
                        ImageView( foregroundStyle: .contentAccentTertiary)
                            .image(props.currency.imageValue)
                    }
                    .cornerRadius(26)
                    .backgroundStyle(.contentSecondary)
                    .size(CGSize(width: 52, height: 52))
                    Spacer(.px16)
                    Label(foregroundStyle: .textPrimary, fontStyle: .body15)
                        .text(props.name)
                    Spacer(.px4)
                    Label(foregroundStyle: .textSecondary, fontStyle: .caption1)
                        .text(props.cardNumber)
                    Spacer(.px8)
                    Label(foregroundStyle: .textPrimary, fontStyle: .title28)
                        .text(String(props.value))
                }
                .layoutMargins(.make(vInsets: 16))
                switchView
                tableView
            }
        }
    }
    
    func setupBindings() {
        switchView.onEvent = { event in
            switch event {
            case .tapHistory:
                break
            case .tapAction:
                break
            case .tapPayment:
                break
            }
        }
    }
}

extension DepositView: ConfigurableView {
    typealias Model = DepositViewProps
    
    struct Props: Hashable {
        let id: Int
        let name: String
        let cardNumber: String
        let currency: Currency
        let value: Int

        var onTap: StringHandler?

        public static func == (lhs: DepositView.Props, rhs: DepositView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
            hasher.combine(cardNumber)
            hasher.combine(currency.textValue)
            hasher.combine(value)
        }
    }

    func configure(with model: DepositViewProps) {
        dataSource.apply(sections: model.sections)
    }
    func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)

    }
    
}

