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
    var selectedIndexPath : IndexPath?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        selectedImageName = "RobotImage"
        collectionView.backgroundColor = .systemGray6
        appendingTheModelObject()
        imageAppearance()
        collectionView.delegate     = self
        collectionView.dataSource   = self
        collectionView.register(MyCollectionViewCell.nib() , forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        setUpNavTitle()
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
    

    func setUpNavTitle(){
        
        let label = UILabel()
        label.text = "Models"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        
    }
    
    enum ModelType : String {
        
        case robot          = "RobotImage"
        case radio          = "RadioImage"
        case wateringcan    = "WateringCanImage"
        case teapot         = "TeaPotImage"
        case guitar         = "GuitarImage"
        case cake           = "CakeImage"
        case cupsaucer      = "CupSaucerImage"
        case gramophone     = "GramoPhoneImage"
        case aeroplane      = "AeroPlaneImage"
        case aircraft       = "AirCraftImage"
        case redchair       = "RedChairImage"
        case shoe           = "ShoeImage"
        case sportshoe      = "SportShoeImage"
        case toy            = "ToyImage"
        case tulip          = "TulipImage"
    }
    
    fileprivate func appendingTheModelObject(){
        
        let modelTypes : [ModelType] = [.robot,.radio,.wateringcan,.teapot,.guitar,.cake,.cupsaucer,.gramophone,.aeroplane,.aircraft,.redchair,.shoe,.sportshoe,.toy,.tulip]
        for modelType in modelTypes {
            models.append(Model(imageName: modelType.rawValue))
        }
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
        if (indexPath == selectedIndexPath){
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = UIColor.green.cgColor
        }
        else{
            cell.layer.borderWidth = 0.0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let image = models[indexPath.row]
        let nameofTheImage = image.imageName
        print(nameofTheImage)
        imageView.image = UIImage(named: nameofTheImage)
        selectedImageName = nameofTheImage
        selectedIndexPath = indexPath
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130.0, height: 130.0)
    }
    
}

struct Model {
    
    var imageName : String
}
 
