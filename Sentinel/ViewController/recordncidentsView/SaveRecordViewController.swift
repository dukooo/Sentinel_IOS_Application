//
//  SaveRecordViewController.swift
//  Sentinel
//
//  Created by Ran Yang on 2020-03-12.
//  Copyright © 2020 ECE1778. All rights reserved.
//

import UIKit
import Firebase

class SaveRecordViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var eventDesciption: UITextView!
    
    var startTime : Date? = nil
    var endTime : Date? = nil
    var heartRateString : String = ""
    var maxHR : Double = 0.0
    var avgHR : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTargetIsNotEmptyTextFields()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
     saveBtn.isEnabled = false
     name.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                 for: .editingChanged)
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {

     guard let name = name.text, !name.trimmingCharacters(in: .whitespaces).isEmpty
       else {
       self.saveBtn.isEnabled = false
       return }
     self.saveBtn.isEnabled = true
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        
        self.storeIncidentsRecord(name: name.text!, description: eventDesciption.text, hrsData: heartRateString, startTime: Int(startTime!.timeIntervalSince1970), endTime: Int(endTime!.timeIntervalSince1970), maxHR: maxHR, avgHR: avgHR)
    }
    
    
    func storeIncidentsRecord(name: String, description: String, hrsData: String, startTime: Int, endTime:Int, maxHR: Double, avgHR: Double) {
            let db = Firestore.firestore()
            db.collection("incidentsHR").addDocument(data: ["uid": Auth.auth().currentUser!.uid,
                                                            "name": name,
                                                            "description": description,
                                                            "hrsData": hrsData,
                                                            "startTime": startTime,
                                                            "endTime": endTime,
                                                            "maxHR": maxHR,
                                                            "avgHR": avgHR])
            {error in
                if error != nil {
                    print(error?.localizedDescription ?? "Error when storing test result")
                }
                else {
                    print("stored")
                    self.performSegue(withIdentifier: "backToHome", sender: nil)
                    
                }
            }
        }
    
}
