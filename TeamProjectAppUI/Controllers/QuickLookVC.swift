//
//  QuickLookVC.swift
//  zAR
//
//  Created by sonai-zstch1129 on 01/03/23.
//

import UIKit
import SceneKit

//MARK: - VC for Quick Look -
class QuickLookVC: UIViewController {

//MARK: - IBOutlet for Scenekit View -
    @IBOutlet weak var quickLook: SCNView!
    
//MARK: - Properties for Getting images from ModelSelectionVC -
    var activeImage: String?
    var activeModel:String?
    
//MARK: - Here converting the imageName to modelName -
    let fetchModel = ["AeroPlaneImage": "toy_car.usdz",
                       "AirCraftImage": "toy_biplane_idle.usdz",
                       "CakeImage": "cake.usdz",
                       "CupSaucerImage": "cup_saucer_set.usdz",
                       "GramoPhoneImage": "gramophone.usdz",
                       "GuitarImage": "fender_stratocaster.usdz",
                       "RadioImage": "tv_retro.usdz",
                       "RedChairImage": "chair_swan.usdz",
                       "RobotImage": "robot_walk_idle.usdz",
                       "ShoeImage": "sneaker_airforce.usdz",
                       "SportShoeImage": "sneaker_pegasustrail.usdz",
                       "TeaPotImage": "teapot.usdz",
                       "ToyImage": "toy_drummer_idle.usdz",
                       "TulipImage": "flower_tulip.usdz",
                       "WateringCanImage": "wateringcan.usdz"
    ]
    
//MARK: - viewDidLoad Func -
    override func viewDidLoad() {
        super.viewDidLoad()
        imageto3DModel()
        viewingObject()
    }
    
//MARK: - Giving name -
    func imageto3DModel() {
        activeModel = fetchModel[activeImage!]
        print("Model name is \(String(describing: activeModel))")
    }
    
//MARK: - Viewing Models from the sceneView - 
    func viewingObject (){
        quickLook.scene = SCNScene(named: activeModel!)
        quickLook.autoenablesDefaultLighting = true
        quickLook.allowsCameraControl = true
    }
}


