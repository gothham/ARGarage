//
//  ARVC.swift
//  TeamProjectAppUI
//
//  Created by sonai-zstch1129 on 23/02/23.
//


import UIKit
import RealityKit
import ARKit

class ARVC: UIViewController {

    @IBOutlet var arView: ARView!

    var activeImage: String?
    var activeModel:String?

    let fetchModel = ["AeroPlaneImage": "toy_car",
                   "AirCraftImage": "toy_biplane_idle",
                   "CakeImage": "cake",
                   "CupSaucerImage": "cup_saucer_set",
                   "GramoPhoneImage": "gramophone",
                   "GuitarImage": "fender_stratocaster",
                   "RadioImage": "tv_retro",
                   "RedChairImage": "chair_swan",
                   "RobotImage": "robot_walk_idle",
                   "ShoeImage": "sneaker_airforce",
                   "SportShoeImage": "sneaker_pegasustrail",
                   "TeaPotImage": "teapot",
                   "ToyImage": "toy_drummer_idle",
                   "TulipImage": "flower_tulip",
                   "WateringCanImage": "wateringcan"
                ]


    override func viewDidLoad() {
        super.viewDidLoad()
        imageto3DModel()
        arView.session.delegate = self
        // setting the coaching overlay
        addCoachingOverlay()
        loadARView()
    }

    func loadARView() {
        alertBox(title: "Place Object", message: "Tap a location to place the object and scale down the object.")
        setUpARView()
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
    }
    func imageto3DModel() {
        activeModel = fetchModel[activeImage!]
        print("Model name is \(String(describing: activeModel))")
    }

   // MARK: Setup methods
    func setUpARView() {
        
        arView.automaticallyConfigureSession = false
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
    }

   

   // MARK: Object placement when tapped
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
         let location = recognizer.location(in: arView)
         let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
         if let firstResult = results.first {
             let anchor = ARAnchor(name: activeModel!, transform: firstResult.worldTransform)
             arView.session.add(anchor: anchor)
         }
         else {
//             MARK: add popup for no result found
//    print("Unable to find a surface. Try moving to the side or repositioning your phone.")
             alertBox(title: "Detection Failed", message: "Try to move iPhone closer.")
         }
     }

    // MARK: placeObject function
    func placeObject(named entityName: String, for anchor: ARAnchor) {
        // MARK: unwrap the ModelEntity properly
        let modelEntity = try! ModelEntity.loadModel(named: entityName)
        modelEntity.generateCollisionShapes(recursive: true)
        arView.installGestures([.all], for: modelEntity)
        let anchorEntity = AnchorEntity(anchor: anchor)
        anchorEntity.addChild(modelEntity)
        arView.scene.addAnchor(anchorEntity)
    }
    
    func alertBox(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ARVC: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchorName = anchor.name, anchorName == activeModel! {
                placeObject(named: anchorName, for: anchor)
            }
        }
    }
}


extension ARVC {
    func addCoachingOverlay() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [
          .flexibleWidth, .flexibleHeight
        ]
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(coachingOverlay)
        //Setup contraints to the coachingView
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coachingOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            coachingOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = arView.session
        /*Set the delegate for any callbacks
        coachingOverlay.delegate = self*/
      }

    /*func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        addCoachingOverlay()
    }
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        coachingOverlayView.activatesAutomatically = false
        self.loadARView()
    }*/
}

