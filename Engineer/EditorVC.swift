//
//  ViewController.swift
//  Engineer
//
//  Created by Edward Day on 21/09/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedElement: UIImage?
    var layers = [UIImageView]()
    var currentActive: Int?
    

    @IBOutlet var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let lightBlack = UIColor(colorLiteralRed: 0.05, green: 0.05, blue: 0.05, alpha: 1)
        collectionView.backgroundColor = lightBlack
        
        canvasView.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return layers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LayerCell
        cell.image.image = layers[indexPath.row].image
        cell.layerLabel.text = "Layer \((String(indexPath.row + 1)))"
        if indexPath.row == currentActive {
            cell.backgroundColor = UIColor.darkGray
        } else {
            cell.backgroundColor = UIColor.gray
        }
        return cell
    }
    

    /*
    @IBAction func addElementBtnTapped(_ sender: AnyObject) {
        if layers.count < 64 {
        let element = UIImageView(frame: CGRect(x: container.bounds.width / 2, y: self.view.bounds.height / 2, width: 400, height: 400))
        element.image = UIImage(named: "demo.png")
        element.center = self.canvasView.center
      /*  let panrecogniser = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan))
        let rotationrecogniser = UIRotationGestureRecognizer(target: self, action: #selector(self.handleRotate))
        let pinchrecogniser = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinch))
        
        element.addGestureRecognizer(rotationrecogniser)
        element.addGestureRecognizer(panrecogniser)
        element.addGestureRecognizer(pinchrecogniser)
        element.isUserInteractionEnabled = true
 */
        
        self.canvasView.addSubview(element)
        self.layers.append(element)
        makeActive(index: layers.count - 1)
        collectionView.reloadData()

        }
    }
    */
    
    
    func addElement(image: UIImage) {
        if layers.count < 64 {
            let element = UIImageView(frame: CGRect(x: container.bounds.width / 2, y: self.view.bounds.height / 2, width: 400, height: 400))
            element.image = image
            element.center = self.canvasView.center
            /*  let panrecogniser = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan))
             let rotationrecogniser = UIRotationGestureRecognizer(target: self, action: #selector(self.handleRotate))
             let pinchrecogniser = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinch))
             
             element.addGestureRecognizer(rotationrecogniser)
             element.addGestureRecognizer(panrecogniser)
             element.addGestureRecognizer(pinchrecogniser)
             element.isUserInteractionEnabled = true
             */
            
            self.canvasView.addSubview(element)
            self.layers.append(element)
            makeActive(index: layers.count - 1)
            collectionView.reloadData()

        }
        
    }

    @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    @IBAction func handleRotate(recognizer : UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    @IBAction func handlePan(recogniser: UIPanGestureRecognizer) {
        
        let translation = recogniser.translation(in: self.view)
        if let view = recogniser.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recogniser.setTranslation(CGPoint.zero, in: self.view)
        
            }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        makeActive(index: indexPath.row)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func makeActive(index: Int) {
        
        if currentActive != nil {
        layers[currentActive!].gestureRecognizers?.removeAll()
        layers[currentActive!].isUserInteractionEnabled = false
        }
        
        let panrecogniser = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan))
        let rotationrecogniser = UIRotationGestureRecognizer(target: self, action: #selector(self.handleRotate))
        let pinchrecogniser = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinch))
        layers[index].addGestureRecognizer(rotationrecogniser)
        layers[index].addGestureRecognizer(panrecogniser)
        layers[index].addGestureRecognizer(pinchrecogniser)
        layers[index].isUserInteractionEnabled = true
        
        currentActive = index
        collectionView.reloadData()
    }
    
    @IBAction func unwindToEditor(sender: UIStoryboardSegue) {
        if sender.source is SelectorVC {
            addElement(image: selectedElement!)
           // layers.append(UIImageView(image: selectedElement!))
            self.collectionView.reloadData()
        }
    }
    
}

