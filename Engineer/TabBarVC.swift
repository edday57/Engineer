//
//  TabBarVC.swift
//  Engineer
//
//  Created by Edward Day on 25/09/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit

class TabBarVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    var homeViewController: UIViewController!
    var settingsViewController: UIViewController!
    var viewControllers: [UIViewController]!
    
    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC")
        settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsVC")
        viewControllers = [homeViewController, settingsViewController]
        
        buttons[selectedIndex].isSelected = true
        didPressTab(buttons[selectedIndex])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var buttons: [UIButton]!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didPressTab(_ sender: AnyObject) {
        if sender.tag == 2 {
            performSegue(withIdentifier: "showEditor", sender: self)
            return
        }
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        buttons[previousIndex].isSelected = false
        
        let previousVC = viewControllers[previousIndex]
        
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        buttons[selectedIndex].isSelected = true
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        
        vc.didMove(toParentViewController: self)
        
        
        
        
    }

}
