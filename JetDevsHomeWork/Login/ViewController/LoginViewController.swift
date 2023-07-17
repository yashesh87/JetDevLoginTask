//
//  LoginViewController.swift
//  JetDevsHomeWork
//
//  Created by MOB-051119-002 on 17/07/23.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    let disposeBag = DisposeBag()
    let viewModel = LoginViewModel()
    
    var errorMessage: String? {
        didSet {
            if let message = self.errorMessage {
                self.openAlert(message, duration: 2.0, position: .bottom, flag: false)
            }
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()
        manageActivity()
        manageCloseButton()
        self.setupHideKeyboardOnTap()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        viewEmail.borderWithCornerRadius(radius: 5, color: textFieldBorderColor, borderWidth: 1)
        viewPassword.borderWithCornerRadius(radius: 5, color: textFieldBorderColor, borderWidth: 1)
        btnLogin.layer.cornerRadius = 5
    }
    
    private func setupFields() {
        
        viewModel.isLoginButtonEnabled
                        .drive(btnLogin.rx.isEnabled)
                        .disposed(by: disposeBag)
        
        txtEmail.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        txtPwd
            .rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        btnLogin
            .rx.tap
            .do(onNext: {[unowned self] in
                self.view.endEditing(true)
            })
            .subscribe(onNext: {[unowned self] in
                if self.viewModel.validation() {
                    self.viewModel.callLoginAPI()
                } else {
                    self.errorMessage = "\(self.viewModel.errorMsg.value)"
                }
            })
            .disposed(by: disposeBag)
        
        _ = viewModel.loginResponse.asObserver()
            .subscribe { user in
                if let userData = user {
                    UserDetails.shared.storeUserData(user: userData)
                }
                self.errorMessage = user?.userName
                self.navigationController?.popViewController(animated: true)
            } onError: { error in
                print(error)
                self.errorMessage = (error as? APIError)?.errorMessage
            } onCompleted: {
                self.activityIndicator.stopAnimating()
            }
    }
    private func manageActivity() {
        viewModel.isLoading.asObservable()
        .bind{ value in
            if value == true {
                self.activityIndicator.startAnimating()
                self.btnLogin.setTitle("", for: .normal)
            } else {
                self.activityIndicator.stopAnimating()
                self.btnLogin.setTitle(buttonLogin, for: .normal)
            }
        }
    }
    
    private func manageCloseButton() {
        btnClose
            .rx.tap
            .do(onNext: {[unowned self] in
                self.view.endEditing(true)
            })
            .subscribe(onNext: {[unowned self] in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
}
