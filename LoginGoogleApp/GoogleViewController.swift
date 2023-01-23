//
//  ViewController.swift
//  LoginGoogleApp
//
//  Created by Osmar Juarez on 19/11/22.
//

import UIKit
import GoogleSignIn

class GoogleViewController: UIViewController {

    var googleButton = GIDSignInButton(frame: .zero)
    var logoutButton = UIButton(type: .system)
    var tvInfo = UITextView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var flagSession = false
        GIDSignIn.sharedInstance.restorePreviousSignIn{
            user, error in
            guard let signInUser = user else {
                print("Ocurrio un error al autenticar")
                return
            }
            var info = "Nombre: " + (signInUser.profile?.givenName ?? "") + "\n"
            self.tvInfo.text = info
            flagSession = true
        }
        
        
        
        let stack = UIStackView(frame: self.view.bounds.insetBy(dx: 50, dy: 50))
        stack.axis = .vertical
        stack.spacing = 50
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        self.view.addSubview(stack)
        
        googleButton.style = GIDSignInButtonStyle.wide
        googleButton.addTarget(self, action: #selector(googleButtonTouch), for: .touchUpInside)
        stack.addArrangedSubview(googleButton)
        
        tvInfo.frame.size = CGSize(width: 200, height: 100)
        tvInfo.backgroundColor = .lightGray
        stack.addArrangedSubview(tvInfo)
        
        logoutButton.setTitle("Cerrar sesión", for: .normal)
        logoutButton.frame.size = CGSize(width: 200, height: 100)
        logoutButton.addTarget(self, action: #selector(logoutButtonTouch), for: .touchUpInside)
        logoutButton.isEnabled = false
        stack.addArrangedSubview(logoutButton)
    }
    
    @objc func googleButtonTouch() {
        let configuration = GIDConfiguration(clientID: "475264433001-vsc6f2bosb3gqqte84lb9uhe1qg3pv08.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: self) {
            user, error in
            guard let signInUser = user else {
                print("Ocurrio un error al autenticar")
                return
            }
            var info = "Nombre: " + (signInUser.profile?.givenName ?? "") + "\n"
            self.tvInfo.text = info
        
        }
        //let gsin =
    }

    @objc func  logoutButtonTouch() {
        
    }
}

