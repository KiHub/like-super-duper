//
//  AccountSummaryCell.swift
//  justBankey
//
//  Created by  Mr.Ki on 12.03.2022.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    enum AccountType: String {
        case Banking
        case CreditCard
        case Investment
    }
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        
        var balanceAttributedString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    let viewModel: ViewModel? = nil
    
    
    let typeLabel = UILabel()
    let underlineViewc = UIView()
    let nameLabel = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    
    let chevronImageView = UIImageView()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 120
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryCell {
    private func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.text = "Account type"
        typeLabel.font  = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(typeLabel)
        
        underlineViewc.translatesAutoresizingMaskIntoConstraints = false
        underlineViewc.backgroundColor = appColor
        contentView.addSubview(underlineViewc)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Account name"
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(nameLabel)
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.adjustsFontSizeToFitWidth = true
        balanceLabel.text = "Some balnce"
        balanceStackView.addArrangedSubview(balanceLabel)
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
       // balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "XXX,XXX", cents: "XX")
        balanceAmountLabel.text = "$XXX,XXX.XX"
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        //MARK: - Set color for sf sumbol
        let chevronImage = UIImage(systemName: "chevron.right")!.withTintColor(appColor, renderingMode: .alwaysOriginal)
        chevronImageView.image = chevronImage
        
        contentView.addSubview(balanceStackView)
        contentView.addSubview(chevronImageView)
        
    }
    private func layout() {
        NSLayoutConstraint.activate([
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            
            underlineViewc.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineViewc.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineViewc.widthAnchor.constraint(equalToConstant: 60),
            underlineViewc.heightAnchor.constraint(equalToConstant: 4),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineViewc.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineViewc.bottomAnchor, multiplier: 0),
            balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
            
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineViewc.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        
        ])
        
        
    }
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
            let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
            let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
            let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
            
            let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
            let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
            let centString = NSAttributedString(string: cents, attributes: centAttributes)
            
            rootString.append(dollarString)
            rootString.append(centString)
            
            return rootString
        }
}


extension AccountSummaryCell {
    func configure(with vm: ViewModel) {
        
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAttributedString
        
        switch vm.accountType {
        case .Banking:
            underlineViewc.backgroundColor = appColor
            balanceLabel.text = "Current balance"
        case .CreditCard:
            underlineViewc.backgroundColor = .systemOrange
            balanceLabel.text = "Current balance"
        case .Investment:
            underlineViewc.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}
