//
//  StatusViewController.swift
//  Mushcat
//
//  Created by Hunter Xu on 6/20/19.
//  Copyright © 2019 Hunter Xu. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {
    
    @IBOutlet weak var statusImage: UIImageView!
    
    @IBOutlet weak var statusText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: true);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func toWelcomeButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true);
    }
    
}
