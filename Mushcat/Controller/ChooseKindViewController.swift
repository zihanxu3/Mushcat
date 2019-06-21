//
//  ChooseKindViewController.swift
//  Mushcat
//
//  Created by Hunter Xu on 6/20/19.
//  Copyright © 2019 Hunter Xu. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ChooseKindViewController: UIViewController {
    
    var wrong: Bool?;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func selectBreedButton(_ sender: UIButton) {
        // Do the avatar first
        var displayName: String = "";
        if (sender.tag == 1) {
            displayName = "Cat";
        } else {
            displayName = "Mushroom";
        }
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.commitChanges { (error) in
            print("Error setting Profile: \(String(describing: error))");
            self.wrong = true;
        }
        
        // perform segue
        performSegue(withIdentifier: "goToStatus", sender: self);
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToStatus" && wrong != nil && wrong!) {
            let destinationVC = segue.destination as! StatusViewController;
            destinationVC.statusImage.image = UIImage(named: "failed");
            destinationVC.statusText.text = "Error";
        }
    }
}
