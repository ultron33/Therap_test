//
//  FavouritesVC.swift
//  Therap_Test
//
//  Created by Iftiquar Ahmed Ove on 5/3/21.
//

import UIKit
import CoreData

class FavouritesVC: UIViewController {
    
    //MARK: - Properties
    
    //------ Views -----//
    var favouriteView = HomeView()
    
    //------ Coredata -----//
    var context:NSManagedObjectContext!
    
    //------ Data Source -----//
    var favNameArray = [String]()
    var favDescriptionArray = [String]()
    var favUrlArray = [String]()

    //MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        openDatabse()
        setupViews()
    }
    
    //MARK: - Functions
    
    // ======== Handle Views ======= //
    func setupViews(){
        view.addSubview(favouriteView)
        favouriteView.tableView.delegate = self
        favouriteView.tableView.dataSource = self
        favouriteView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    
    // ============= Fetch from Database ========== //
    
    func openDatabse(){
        context = Constants.appDelegate.persistentContainer.viewContext
        fetchData()
    }
    
    func fetchData(){
        print("Fetching Data..")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let userName = data.value(forKey: "name") as! String
                let details = data.value(forKey: "details") as! String
                let url = data.value(forKey: "url") as! String
                print("User Name is : "+userName+" and url is : "+url+"details is : "+details)
                self.favNameArray.append(userName)
                self.favDescriptionArray.append(details)
                self.favUrlArray.append(url)
            }
        } catch {
            print("Fetching data Failed")
        }
    }

    
    //MARK: - BUtton Actions

}


extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! tableViewCell
        cell.controller = nil
        cell.nameLabel.text = favNameArray[indexPath.row]
        cell.DescriptionLabel.text = favDescriptionArray[indexPath.row]
        cell.urlLabel.text = favUrlArray[indexPath.row]
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

