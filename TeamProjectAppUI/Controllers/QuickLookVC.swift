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
        quickLook.scene?.rootNode.scale = SCNVector3(0.5, 0.5, 0.5)
        quickLook.autoenablesDefaultLighting = true
        quickLook.allowsCameraControl = true
    }
    
    // MARK: unwrap the optionals and fix thew errors to center the image
    
    /*func centerBoundingBox() {
        let node = quickLook.scene?.rootNode
        
        // Calculate the center of the bounding box
        let nodeCenter = SCNVector3(
            x: (nodeBoundingBox.min.x + nodeBoundingBox.max.x) / 2.0,
            y: (nodeBoundingBox.min.y + nodeBoundingBox.max.y) / 2.0,
            z: (nodeBoundingBox.min.z + nodeBoundingBox.max.z) / 2.0
        )
        
        // Calculate the offset required to center the node
        let nodeOffset = SCNVector3(
            x: -nodeCenter.x,
            y: -nodeCenter.y,
            z: -nodeCenter.z
        )
        
        // Apply the offset to the node
        node!.position = nodeOffset
    }*/
}


