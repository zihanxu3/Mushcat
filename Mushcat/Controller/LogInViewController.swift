//
//  LogInViewController.swift
//  Mushcat
//
//  Created by Hunter Xu on 6/20/19.
//  Copyright © 2019 Hunter Xu. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {

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
    @IBAction func buttonToChannel(_ sender: UIButton) {
        SVProgressHUD.show()
        //TODO: Log in the user
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passWordTextField.text!) { (user, error) in
            if (error != nil) {
                SVProgressHUD.dismiss();
                ProgressHUD.showError("Invalid email and/or password");
                print(error!.localizedDescription);
            } else {
                print("Login Successful");
                SVProgressHUD.dismiss();
                self.performSegue(withIdentifier: "goToChannel", sender: self)
            }
        }
    }
    
}
