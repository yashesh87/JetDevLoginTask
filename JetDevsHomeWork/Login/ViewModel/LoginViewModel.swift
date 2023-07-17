//
//  LoginViewModel.swift
//  JetDevsHomeWork
//
//  Created by MOB-051119-002 on 17/07/23.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class LoginViewModel {
    
    var email = BehaviorRelay(value: "")
    var password = BehaviorRelay(value: "")
    var errorMsg = BehaviorRelay(value: "")
    let loginResponse = PublishSubject<User?>()
    
    var isLoginButtonEnabled: Driver<Bool> {
        return Observable.combineLatest(email, password)
            .map { email, password in
                // Check if email and password are valid, and return a boolean indicating whether the button should be enabled or not
                return !email.isEmpty && !password.isEmpty
            }
            .asDriver(onErrorJustReturn: false)
    }
    let isLoading : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func validation() -> Bool {
        if email.value.isEmpty {
            errorMsg.accept(enterEmailID)
            return false
        } else if !(validateEmail()) {
            errorMsg.accept(enterProperEmailID)
            return false
        } else if password.value.isEmpty {
            errorMsg.accept(enterPassword)
            return false
        }
        return true
    }
    
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email.value)
    }
    
    func callLoginAPI() {
        
        var request = LoginRequest()
        request.email = email.value
        request.password = password.value
        let parameters = try? request.asDictionary()
        isLoading.accept(true)
        
        APIService.sharedInstance.wsCall(apiEndPoint: .login(parameters ?? [:]), model: LoginResponse.self) { [weak self] resp in
            
            guard let self = self else {
                return
            }
            self.isLoading.accept(false)
            DispatchQueue.main.async {
                if resp.result == 1 {
                    self.loginResponse.onNext(resp.data?.user)
                    self.loginResponse.onCompleted()
                } else {
                    self.loginResponse.onError(APIError(errorMessage: resp.errorMessage ?? ""))
                }
            }
        } failure: { error in
            self.isLoading.accept(false)
            DispatchQueue.main.async {
                self.loginResponse.onError(APIError(errorMessage: error.localizedDescription))
            }
        }
    }
}

struct APIError: Error {
    let errorMessage: String
}
