//
//  SelectorVC.swift
//  Engineer
//
//  Created by Edward Day on 24/09/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit

class SelectorVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var headerView: UIView!
    var selectedPath: Int?
    var selectedElement: UIImage?
    var elements = [#imageLiteral(resourceName: "1Circle.png"), #imageLiteral(resourceName: "2Square.png"), #imageLiteral(resourceName: "3Rectangle.png"), #imageLiteral(resourceName: "4Triangle.png"), #imageLiteral(resourceName: "5Pentagon.png"), #imageLiteral(resourceName: "6Semicircle.png"), #imageLiteral(resourceName: "7Arc.png"), #imageLiteral(resourceName: "8RoundedRect.png"), #imageLiteral(resourceName: "9Pointer.png"), #imageLiteral(resourceName: "10Shape1.png"), #imageLiteral(resourceName: "11CutOval.png"), #imageLiteral(resourceName: "12CutCircle.png"), #imageLiteral(resourceName: "13Star.png"), #imageLiteral(resourceName: "14HalfStar.png"), #imageLiteral(resourceName: "15Trapesium.png")]

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let segAttributes: NSDictionary = [
            NSForegroundColorAttributeName: UIColor.white
        ]
        
        segmentedControl.setTitleTextAttributes(segAttributes as [NSObject : AnyObject], for: UIControlState.selected)
        collectionView.reloadData()
        // Do any additional setup after loading the view.
        
        headerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOpacity = 1.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SelectorCell
        cell.image.image = elements[indexPath.row]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedElement = elements[indexPath.row]
        
        performSegue(withIdentifier: "unwindEditor", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! ViewController
        destinationViewController.selectedElement = selectedElement!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
