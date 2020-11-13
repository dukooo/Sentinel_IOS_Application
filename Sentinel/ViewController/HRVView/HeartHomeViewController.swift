//
//  HeartHomeViewController.swift
//  Sentinel
//
//  Created by Yue Cai on 2020-03-11.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import Firebase

class HeartHomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionlist: UICollectionView!
    let transiton = SlideInTransition()
    var max = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    func setUpElements() {
        collectionlist.collectionViewLayout = HeartHomeCollectionLayout()
        collectionlist.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setUpmax()
    }
    
    func setUpmax() {
        var result = [Int]()
        result = []
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        db.collection("incidentsHR").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, err) in
            if (!snapshot!.isEmpty) {
                for doc in snapshot!.documents {
                    result.append((doc.get("maxHR") as? Int)!)
                }
                self.max = "\((result.reduce(0, +)) / (result.count))"
                self.collectionlist.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Constants.heartHomeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heartHomeCell", for: indexPath) as! HeartHomeCell
        cell.textLabel.text = Constants.heartHomeList[indexPath.item]
        if (indexPath.item > 1) {
            cell.textLabel.text! += self.max
            cell.textLabel.text! += "bpm"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let vc = storyboard?.instantiateViewController(identifier: "incidentsRecordListVC") as? IncidentsRecordListViewController
            view.window?.rootViewController = vc
            view.window?.makeKeyAndVisible()
        }
        if indexPath.item == 1 {
            let vc = storyboard?.instantiateViewController(identifier: "restinghrVC") as? RestingHRViewController
            view.window?.rootViewController = vc
            view.window?.makeKeyAndVisible()
        }
    }

}


extension HeartHomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
