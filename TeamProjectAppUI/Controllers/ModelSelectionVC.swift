//
//  ViewController.swift
//  TeamProjectAppUI
//
//  Created by sonai-zstch1129 on 21/02/23.
//

import UIKit


class ModelSelectionVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var imageView      : UIImageView!
    
    var models = [Model]()
    var selectedImageName : String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        selectedImageName = "RobotImage"
        collectionView.backgroundColor = .systemGray6
        appendingTheModelObject()
        imageAppearance()
        collectionView.delegate     = self
        collectionView.dataSource   = self
        collectionView.register(MyCollectionViewCell.nib() , forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        
    }
    
    
    @IBAction func viewInARAction(_ sender: Any) {
        
        let arvc = self.storyboard?.instantiateViewController(withIdentifier: "ARVC") as! ARVC
        self.navigationController?.pushViewController(arvc, animated: true)
        arvc.activeImage = selectedImageName
    }
    
    @IBAction func quickLookAction(_ sender: Any) {
        let qlvc = self.storyboard?.instantiateViewController(withIdentifier: "QuickLookVC") as! QuickLookVC
        self.navigationController?.pushViewController(qlvc, animated: true)
        qlvc.activeImage = selectedImageName
    }
    fileprivate func appendingTheModelObject() {
        
        models.append( Model(imageName: "RobotImage"))
        models.append( Model(imageName: "RadioImage"))
        models.append( Model(imageName: "WateringCanImage"))
        models.append( Model(imageName: "TeaPotImage"))
        models.append( Model(imageName: "GuitarImage"))
        models.append( Model(imageName: "CakeImage"))
        models.append( Model(imageName: "CupSaucerImage"))
        models.append( Model(imageName: "GramoPhoneImage"))
        models.append( Model(imageName: "AeroPlaneImage"))
        models.append( Model(imageName: "AirCraftImage"))
        models.append( Model(imageName: "RedChairImage"))
        models.append( Model(imageName: "ShoeImage"))
        models.append( Model(imageName: "SportShoeImage"))
        models.append( Model(imageName: "ToyImage"))
        models.append( Model(imageName: "TulipImage"))
    }
    
    
       func imageAppearance(){
           
           imageView.layer.borderColor = .init(red: 125/255, green: 125/255, blue: 125/255, alpha: 0.5)
           imageView.layer.borderWidth = 0.5
           imageView.layer.cornerRadius = 20.0
           guard let selectedImageName = self.selectedImageName else{ return }
           imageView.image = UIImage(named: selectedImageName)
           
       }
       
    // Collectionview
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:MyCollectionViewCell.identifier , for: indexPath) as! MyCollectionViewCell
        cell.configure(with: models[indexPath.row])
        cell.layer.cornerRadius = 20.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let image = models[indexPath.row]
        let nameofTheImage = image.imageName
        print(nameofTheImage)
        imageView.image = UIImage(named: nameofTheImage)
        selectedImageName = nameofTheImage
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130.0, height: 130.0)
    }
    
}

struct Model {
    
    var imageName : String
}
 
