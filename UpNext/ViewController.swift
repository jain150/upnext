//
//  ViewController.swift
//  UpNext
//
//  Created by Shivan Desai on 3/23/17.
//  Copyright © 2017 Shivan Desai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEnterClicked(_ sender: Any) {
        performSegue(withIdentifier: "enterSegue", sender: nil)
    }

}

