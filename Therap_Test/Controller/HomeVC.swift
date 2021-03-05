//
//  ViewController.swift
//  Therap_Test
//
//  Created by Iftiquar Ahmed Ove on 5/3/21.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    var context:NSManagedObjectContext!
    
    //MARK: - Properties
    
    // ------ Data Source ----- //
    //******************************
    var nameArray = [String]()
    var descriptionArray = [String]()
    var urlArray = [String]()
    
    // ------- Views ----- //
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Home"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var homeView = HomeView()

    //MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        parse_data()
    }
    
    //MARK: - Functions
    
    
    func setup_vews(){
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(homeView)
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    // ====== Networking ===== //
    
    func parse_data(){
        Webservices.shared.getGitInfo { (success, gitinfo) in
            switch success{
            case 200:
                for i in 0 ..< (gitinfo?.items!.count)!{
                    self.nameArray.append(gitinfo?.items![i].name ?? "N/A")
                    self.descriptionArray.append(gitinfo?.items![i].itemDescription ?? "N/A")
                    self.urlArray.append(gitinfo?.items![i].gitURL ?? "N/A")
                    
                    DispatchQueue.main.async {
                        self.setup_vews()
                    }
                }
            case 400: print("failed to parse")
                self.showToast(message: "Something went wrong!", font: UIFont.systemFont(ofSize: 12), cardHight: 50, labelHeight: 50, labelWidth: 200)
            default: break
            }
        }
    }
    
    
    // ======= Data Base ======
    //*************************************

    func saveToDatabase(name: String, details: String, url: String){
        context = Constants.appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        saveData(UserDBObj: newUser, name: name, details: details, url: url)
    }
    
    func saveData(UserDBObj:NSManagedObject , name: String, details: String, url: String){
        UserDBObj.setValue(name, forKey: "name")
        UserDBObj.setValue(details, forKey: "details")
        UserDBObj.setValue(url, forKey: "url")
        
        print("Storing Data..")
        do {
            try context.save()
            NotificationCenter.default.post(name: Notification.Name(Constants.shared.NEW_USER_SAVED), object: nil)
            self.showToast(message: "Saved succesfully!", font: UIFont.systemFont(ofSize: 12), cardHight: 50, labelHeight: 50, labelWidth: 200)
        } catch {
            print("Storing data Failed")
        }
    }


    //MARK: - BUtton Actions
    
    func favourite_cell(_ cell: UITableViewCell){
        let indexPath = homeView.tableView.indexPath(for: cell)
        print("tapped at \(indexPath?.row ?? 0) no cell")
        saveToDatabase(name: nameArray[indexPath!.row], details: descriptionArray[indexPath!.row], url: urlArray[indexPath!.row])
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! tableViewCell
        cell.controller = self
        cell.nameLabel.text = nameArray[indexPath.row]
        cell.DescriptionLabel.text = descriptionArray[indexPath.row]
        cell.bringSubviewToFront(cell.favourite_button)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("okokokokok")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        let deleteAction = UIContextualAction(style: .destructive, title: "Add Note") { (action, view, handler) in
            print("add notes --- > ")
            let vc = WriteNotesVC()
            vc.name = self.nameArray[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        }
        deleteAction.image = #imageLiteral(resourceName: "add note")
        deleteAction.backgroundColor = .gray
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }}

