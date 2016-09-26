//
//  ViewController.swift
//  Engineer
//
//  Created by Edward Day on 21/09/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var layersLabel: UILabel!
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedElement: UIImage?
    var layers = [UIImageView]()
    var currentActive: Int?
    
    
    
    @IBOutlet var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        canvasView.clipsToBounds = true
        
        headerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOpacity = 1.0
        
        
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOpacity = 1.0
        collectionView.layer.shadowRadius = 2
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
            cell.bg.image = UIImage(named: "CellBGLightx1.png")
        } else {
            cell.bg.image = UIImage(named: "CellBGx1.png")
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
        pinchrecogniser.delegate = self
        rotationrecogniser.delegate = self
        layers[index].addGestureRecognizer(rotationrecogniser)
        layers[index].addGestureRecognizer(panrecogniser)
        layers[index].addGestureRecognizer(pinchrecogniser)
        layers[index].isUserInteractionEnabled = true
        
        currentActive = index
        collectionView.reloadData()
        layersLabelUpdate()
    }
    
    @IBAction func unwindToEditor(sender: UIStoryboardSegue) {
        if sender.source is SelectorVC {
            addElement(image: selectedElement!)
           // layers.append(UIImageView(image: selectedElement!))
            self.collectionView.reloadData()
        }
    }
    
    func layersLabelUpdate() {
        layersLabel.text = "Layers: \(layers.count) / 64"
    }
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

