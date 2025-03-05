//
//  UserDetailViewController.swift
//  SevenApps
//
//  Created by Aleyna Işıkdağlılar on 4.03.2025.
//

import UIKit

class UserDetailViewController: UIViewController {
    private let userDetailView = UserDetailView()
    private let user: User

    override func loadView() {
        view = userDetailView
    }
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = user.name
        configureData()
    }
    
    private func configureData() {
        let attributedText = NSMutableAttributedString()
        
        func boldText(_ text: String) -> NSAttributedString {
            return NSAttributedString(
                string: text,
                attributes: [.font: UIFont.boldSystemFont(ofSize: 16)]
            )
        }
        
        func normalText(_ text: String) -> NSAttributedString {
            return NSAttributedString(
                string: text,
                attributes: [.font: UIFont.systemFont(ofSize: 16)]
            )
        }
        
        attributedText.append(boldText("🆔 Username: "))
        attributedText.append(normalText("\(user.username)\n\n"))
        
        attributedText.append(boldText("📧 Email: "))
        attributedText.append(normalText("\(user.email)\n\n"))
        
        attributedText.append(boldText("📞 Phone: "))
        attributedText.append(normalText("\(user.phone)\n\n"))
        
        attributedText.append(boldText("🌍 Website: "))
        attributedText.append(normalText("\(user.website)\n\n"))
        
        attributedText.append(boldText("🏠 Address:\n"))
        attributedText.append(normalText("\(user.address.street), \(user.address.suite), \(user.address.city) - \(user.address.zipcode)\n\n"))
        
        attributedText.append(boldText("🏢 Company: "))
        attributedText.append(normalText("\(user.company.name)\n\n"))
        
        attributedText.append(boldText("💡 CatchPhrase: "))
        attributedText.append(normalText("\(user.company.catchPhrase)\n\n"))
        
        attributedText.append(boldText("📊 Bs: "))
        attributedText.append(normalText("\(user.company.bs)\n\n"))
        
        userDetailView.infoLabel.attributedText = attributedText
    }
}
