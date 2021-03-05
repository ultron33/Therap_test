//
//  NotesVC.swift
//  Therap_Test
//
//  Created by Iftiquar Ahmed Ove on 5/3/21.
//

import UIKit
import CoreData

class NotesVC: UIViewController {
    
    //MARK: - Properties
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Notes"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    //------ Views -----//
    var NotesView = HomeView()
    
    //------ Coredata -----//
    var context:NSManagedObjectContext!
    
    //------ Data Source -----//
    var notesNameArray = [String]()
    var noteArray = [String]()

    //MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        openDatabse()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(refresh_tableView), name: Notification.Name(Constants.shared.NEW_NOTES_SAVED), object: nil)
    }
    
    //MARK: - Functions
    
    // ======== Handle Views ======= //
    func setupViews(){
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(NotesView)
        NotesView.tableView.delegate = self
        NotesView.tableView.dataSource = self
        NotesView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    // ============= Fetch from Database ========== //
    
    func openDatabse(){
        context = Constants.appDelegate.persistentContainer.viewContext
        fetchData()
    }
    
    func fetchData(){
        print("Fetching Data..")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let userName = data.value(forKey: "name") as! String
                let note = data.value(forKey: "note") as! String
               
                self.notesNameArray.insert(userName, at: 0)
                self.noteArray.insert(note, at: 0)
            }
        } catch {
            print("Fetching data Failed")
        }
    }


    
    //MARK: - refresh tableView
    
    @objc func refresh_tableView(){
        self.notesNameArray.removeAll()
        self.noteArray.removeAll()
        fetchData()
        NotesView.tableView.reloadData()
    }
}

extension NotesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notesNameArray.count == 0{
            tableView.setEmptyMessage("No Notes saved!")
            return notesNameArray.count
        }else{
            tableView.setEmptyMessage("")
            return notesNameArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! tableViewCell
        cell.controller = nil
        cell.nameLabel.text = notesNameArray[indexPath.row]
        cell.DescriptionLabel.text = noteArray[indexPath.row]
        cell.favourite_button.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("okokokokok")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
