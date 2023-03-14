//
//  QuickStartVC.swift
//  zAR
//
//  Created by Goutham on 14/03/23.
//

import UIKit

class QuickStartVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var gestureDataArr: [Gestures]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerGestureCell()
        collectionView.dataSource = self
        populateGestureArr()
    }

    @IBAction func didTapDoneAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func registerGestureCell() {
        collectionView.register(GestureCollectionViewCell.nib, forCellWithReuseIdentifier: GestureCollectionViewCell.identifier)
    }
    
    func populateGestureArr() {
        gestureDataArr = [
            Gestures(gestureImage: "GestureDummy", gestureType: "Gesture 1"),
            Gestures(gestureImage: "GestureDummy", gestureType: "Gesture 2"),
            Gestures(gestureImage: "GestureDummy", gestureType: "Gesture 3"),
            Gestures(gestureImage: "GestureDummy", gestureType: "Gesture 4")
        ]
    }
}

extension QuickStartVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gestureDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GestureCollectionViewCell.identifier, for: indexPath) as! GestureCollectionViewCell
        cell.setupGestureCell(gestureDataArr[indexPath.row])
        return cell
    }
}
