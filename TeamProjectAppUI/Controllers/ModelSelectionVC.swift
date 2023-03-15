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
    
    var standard            = [Model]()
    var models              = [Model]()
    var selectedImageName   : String?
    var selectedIndexPath   : IndexPath?
    var dropDownOptions     = ["All","Toys","Utensils","Furnitures","Food","Footwear","Instruments"]
    var toysArray           : Array<ModelType> = [.aircraft,.aeroplane,.robot,.toy,.ship]
    var utensilsArray       : Array<ModelType> = [.cupsaucer,.teapot,.wateringcan]
    var furnitureArray      : Array<ModelType> = [.redchair,.test,.sofa,.sofa2,.woodChair,.teaPotTable,.soloCoach,.romanChair,.oldCoach]
    var foodArray           : Array<ModelType> = [.cake,.tulip]
    var footWearArray       : Array<ModelType> = [.shoe,.sportshoe]
    var instrumentsArray    : Array<ModelType> = [.gramophone,.guitar,.radio,.tableLight]
    
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
        case test           = "TestChair"
        case ship           = "ShipImage"
        case sofa           = "WhiteSofa"
        case sofa2          = "ThreeSeaterSofa"
        case woodChair      = "woodChair"
        case teaPotTable    = "TeaPotTable"
        case tableLight     = "TableLight"
        case soloCoach      = "SoloCoach"
        case romanChair     = "RomanChair"
        case oldCoach       = "OldCoach"
        
    }
    
    fileprivate func appendingTheModelObject(){
        
        let modelTypes : [ModelType] = [.robot,.radio,.wateringcan,.teapot,.guitar,.cake,.cupsaucer,.gramophone,.aeroplane,.aircraft,.redchair,.shoe,.sportshoe,.toy,.tulip,.test,.ship,.sofa,.sofa2,.woodChair,.teaPotTable,.tableLight,.soloCoach,.romanChair,.oldCoach]
        for modelType in modelTypes {
            if toysArray.contains(modelType){
                models.append(Model(imageName: modelType.rawValue, type: .toys))
            } else if utensilsArray.contains(modelType){
                models.append(Model(imageName: modelType.rawValue, type: .utensils))
            } else if furnitureArray.contains(modelType){
                models.append(Model(imageName: modelType.rawValue, type: .furnitures))
            } else if foodArray.contains(modelType){
                models.append(Model(imageName: modelType.rawValue, type: .food))
            } else if footWearArray.contains(modelType){
                models.append(Model(imageName: modelType.rawValue, type: .footwear))
            } else {
                models.append(Model(imageName: modelType.rawValue, type: .instruments))
            }
        }
        self.standard = self.models
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        showDropDownBox()
    }
    
    func selectOption(option: String){
        print("The selected option is \(option)")
        
        if option == "All"{
            self.models = self.standard
        }else{
            self.models = self.standard.filter({$0.type == Seggregate(rawValue: option)})
        }
        self.collectionView.reloadData()
    }

    func showDropDownBox(){

        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self

        let alertController = UIAlertController(title: "Select an option", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(pickerView)

        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 50),
            pickerView.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -50)
        ])

        let selectAction = UIAlertAction(title: "Select", style: .default){ (action) in
            let selectedIndex = pickerView.selectedRow(inComponent: 0)
            let selectedOption = self.dropDownOptions[selectedIndex]
            self.selectOption(option: selectedOption)

        }
        alertController.addAction(selectAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
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

extension ModelSelectionVC : UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dropDownOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dropDownOptions[row]
    }
    
}

struct Model {
    
    var imageName : String
    var type : Seggregate
}
 
enum Seggregate : String {
    
    case toys = "Toys"
    case utensils = "Utensils"
    case furnitures = "Furnitures"
    case food = "Food"
    case footwear = "Footwear"
    case instruments = "Instruments"
    
}
