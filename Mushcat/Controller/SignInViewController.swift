//
//  SignInViewController.swift
//  Mushcat
//
//  Created by Hunter Xu on 6/20/19.
//  Copyright © 2019 Hunter Xu. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func toBreedButton(_ sender: UIButton) {
        SVProgressHUD.show()
        //TODO: Set up a new user on our Firbase database
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passWordTextField.text!) {
            (user, error) in
            if (error != nil) {
                SVProgressHUD.dismiss();
                ProgressHUD.showError("Invalid email and/or password");
                print(error!.localizedDescription);
            } else {
                print("Registration successful!");
                SVProgressHUD.dismiss();
                self.performSegue(withIdentifier: "goToBreed", sender: self);
            }
        }
    }
}
