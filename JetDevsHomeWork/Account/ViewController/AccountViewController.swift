//
//  AccountViewController.swift
//  JetDevsHomeWork
//
//  Created by Gary.yao on 2021/10/29.
//

import UIKit
import Kingfisher

class AccountViewController: UIViewController {

	@IBOutlet weak var nonLoginView: UIView!
	@IBOutlet weak var loginView: UIView!
	@IBOutlet weak var daysLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var headImageView: UIImageView!
	override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
		nonLoginView.isHidden = false
		loginView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let user = UserDetails.shared.getUserDetails()
        if user == nil {
            nonLoginView.isHidden = false
            loginView.isHidden = true
        } else {
            nonLoginView.isHidden = true
            loginView.isHidden = false
            
            nameLabel.text = user?.userName
            if let url = URL(string: user?.userProfileURL ?? "") {
                headImageView.kf.setImage(with: url, placeholder: UIImage(named: "Avatar"))
            }
        }
    }
	
	@IBAction func loginButtonTap(_ sender: UIButton) {
        let login = LoginViewController()
        login.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(login, animated: true)
	}
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDetails.shared.removeUserData()
        nonLoginView.isHidden = false
        loginView.isHidden = true
    }
}
