//
//  writeNotesVC.swift
//  Therap_Test
//
//  Created by Iftiquar Ahmed Ove on 5/3/21.
//

import Foundation
import UIKit
import CoreData

class WriteNotesVC: UIViewController {
    
    //MARK: - Properties
    
    var context: NSManagedObjectContext!
    var name: String?
    
    let doneButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Done", for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    let notesTextField = UITextField().textField(title: "", textColor: .black, fontStyle: UIFont.systemFont(ofSize: 12), placeholderText: "Add notes here", placeHolderColor: .darkGray)
    
    //MARK: - Initializers
    
    override func viewDidLoad() {
        setup_views()
    }
    
    //MARK: - Functions
    func setup_views(){
        view.backgroundColor = .white
        view.addSubview(doneButton)
        
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        doneButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 80, height: 40)
        
        view.addSubview(notesTextField)
        notesTextField.anchor(top: doneButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 300)
    }
    
    // ======= Data Base ======
    //*************************************

    func saveToDatabase(name: String, notes: String){
        context = Constants.appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        saveData(UserDBObj: newUser, name: name, notes: notes)
    }
    
    func saveData(UserDBObj:NSManagedObject , name: String, notes: String){
        UserDBObj.setValue(name, forKey: "name")
        UserDBObj.setValue(notes, forKey: "note")
        
        print("Storing Data..")
        do {
            try context.save()
            NotificationCenter.default.post(name: Notification.Name(Constants.shared.NEW_NOTES_SAVED), object: nil)
            self.showToast(message: "Saved succesfully!", font: UIFont.systemFont(ofSize: 12), cardHight: 50, labelHeight: 50, labelWidth: 200)
        } catch {
            print("Storing data Failed")
        }
    }
    
    //MARK: - Button Actions
    
    @objc func doneButtonTapped(){
        if notesTextField.text?.isReallyEmpty == true {
            self.dismiss(animated: true, completion: nil)
        }else{
            saveToDatabase(name: name!, notes: "\(notesTextField.text ?? "N/A")")
            self.showToast(message: "note saved succesfully!", font: UIFont.systemFont(ofSize: 12), cardHight: 50, labelHeight: 50, labelWidth: 200)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
