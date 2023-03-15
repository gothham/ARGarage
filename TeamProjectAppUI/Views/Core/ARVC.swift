//
//  ARVC.swift
//  TeamProjectAppUI
//
//  Created by sonai-zstch1129 on 23/02/23.
//


import UIKit
import RealityKit
import ARKit
import SwiftMessages

class ARVC: UIViewController {

    @IBOutlet var arView: ARView!

    var activeImage: String?
    var activeModel:String?

    let fetchModel = ["AeroPlaneImage"      : "toy_car",
                       "AirCraftImage"      : "toy_biplane_idle",
                      "CakeImage"           : "cake",
                       "CupSaucerImage"     : "cup_saucer_set",
                       "GramoPhoneImage"    : "gramophone",
                       "GuitarImage"        : "fender_stratocaster",
                       "RadioImage"         : "tv_retro",
                       "RedChairImage"      : "chair_swan",
                       "RobotImage"         : "robot_walk_idle",
                       "ShoeImage"          : "sneaker_airforce",
                       "SportShoeImage"     : "sneaker_pegasustrail",
                       "TeaPotImage"        : "teapot",
                       "ToyImage"           : "toy_drummer_idle",
                       "TulipImage"         : "flower_tulip",
                       "WateringCanImage"   : "wateringcan",
                       "TestChair"          : "Conference_Chair",
                       "ShipImage"          : "Ship_in_a_bottle",
                       "WhiteSofa"          : "White_Sofa",
                       "ThreeSeaterSofa"    : "3_Seated_Sofa",
                       "woodChair"          : "Kid_rocking_chair",
                       "TeaPotTable"        : "Table",
                       "TableLight"         : "Table_Lamp",
                       "SoloCoach"          : "Brown_Sofa",
                       "RomanChair"         : "Roman_Chair",
                       "OldCoach"           : "Old_Sofa"

                    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        imageto3DModel()
        arView.session.delegate = self
        // setting the coaching overlay
        addCoachingOverlay()
        loadARView()
        setupConstraintsForCaptureButton()
        captureBtn.addTarget(self, action: #selector(captureSnapshot), for: .touchUpInside)
    }

    @objc func captureSnapshot() {
        arView.snapshot(saveToHDR: false) { [self] image in
            guard let image = image else { return }
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            print("Image capture, check the photo library in your phone")
            self.showPopUpMsg(title: "Photo Captured", body: "Photo saved to library", iconImage: UIImage(systemName: "camera")!)
        }
    }
    
    func showPopUpMsg(title: String, body: String, iconImage: UIImage) {
        let view = MessageView.viewFromNib(layout: .centeredView)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: title, body: body, iconImage: iconImage)
        SwiftMessages.show(view: view)
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
             // MARK: add popup for no result found
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
    
    let captureBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.layer.cornerRadius = 37.5
        button.backgroundColor = .systemGray6
        return button
    }()
    
    func setupConstraintsForCaptureButton() {
        captureBtn.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(captureBtn)
        let contraints = [
            captureBtn.centerXAnchor.constraint(equalTo: arView.centerXAnchor),
            captureBtn.heightAnchor.constraint(equalToConstant: 75),
            captureBtn.widthAnchor.constraint(equalToConstant: 75),
            captureBtn.bottomAnchor.constraint(equalTo: arView.bottomAnchor, constant: -44)
        ]
        NSLayoutConstraint.activate(contraints)
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

