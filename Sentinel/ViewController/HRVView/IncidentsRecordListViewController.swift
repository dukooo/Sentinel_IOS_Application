//
//  IncidentsRecordListViewController.swift
//  Sentinel
//
//  Created by Ran Yang on 2020-03-12.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import Firebase

class IncidentsRecordListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var logs : [Log] = []
    let transiton = SlideInTransition()
    
    override func viewDidLoad() {
        self.collectionView.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setUpElements()
        super.viewDidLoad()

    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    func setUpElements() {
        let uid = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        db.collection("incidentsHR").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, err) in
            if (!snapshot!.isEmpty) {
                for document in snapshot!.documents {
                    let logInfo = Log(data: document.data()) ?? nil
                    if logInfo != nil {
                        self.logs.append(logInfo!)
                    }
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                }
                self.logs = self.logs.sorted{$0.startTime > $1.startTime}
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            logs.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "logCell", for: indexPath) as! LogCell
        
        let log = logs[indexPath.item]
        
        let date = Date(timeIntervalSince1970: TimeInterval(log.startTime))
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        
        cell.title = [log.name, formatter.string(from: date)]
        
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "recordLogVC") as? RecordLogViewController        
        let log = logs[indexPath.item]

        vc?.log = log
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }

}

extension IncidentsRecordListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension IncidentsRecordListViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}

    
