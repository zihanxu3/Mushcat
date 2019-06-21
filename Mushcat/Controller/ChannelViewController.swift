//
//  ChannelViewController.swift
//  Mushcat
//
//  Created by Hunter Xu on 6/20/19.
//  Copyright © 2019 Hunter Xu. All rights reserved.
//

import UIKit
import QuartzCore

class ChannelViewController: UIViewController {

    @IBOutlet weak var catRun: UIImageView!
    @IBOutlet weak var mushRun: UIImageView!
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var clickCount: Int = 0;
    let progress = Progress(totalUnitCount: 8)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true;
        clickCount = 0;
        progressView.progress = 0.0
        progress.completedUnitCount = 0
        self.progressLabel.text = "\(Int(self.progress.fractionCompleted * 100)) %"
    }
    
    
    @IBAction func buttonToChat(_ sender: UIButton) {
        clickCount += 1;
        if (clickCount >= 8) {
            UIView.animate(withDuration: 2.5, delay: 0.7, options: .curveEaseInOut, animations: {
                self.mushRun.center.x += 47;
                self.catRun.center.x -= 47;
                self.view.backgroundColor = .orange;
            }, completion: { _ in
                let alert = UIAlertController(title: "提醒", message: "猫猫是傻逼", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("没错！", comment: "Default action"), style: .default, handler: { _ in
                    self.performSegue(withIdentifier: "goToChat", sender: self);
                }))
                self.present(alert, animated: true, completion: nil)
            })
        } else {
            self.progress.completedUnitCount += 1;
            self.progressView.setProgress(Float(self.progress.fractionCompleted), animated: true);
            self.progressLabel.text = "\(Int(self.progress.fractionCompleted * 100)) %"
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                self.view.backgroundColor = .orange;
            })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
