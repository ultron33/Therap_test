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
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "FAVOURITE INFOS"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: Notification.Name(Constants.shared.NEW_USER_SAVED), object: nil)
    }
    
    //MARK: - Functions
    
    // ======== Handle Views ======= //
    func setupViews(){
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(favouriteView)
        favouriteView.tableView.delegate = self
        favouriteView.tableView.dataSource = self
        favouriteView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
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
                self.favNameArray.insert(userName, at: 0)
                self.favDescriptionArray.insert(details, at: 0)
                self.favUrlArray.insert(url, at: 0)
            }
        } catch {
            print("Fetching data Failed")
        }
    }
    
    //======= Refresh =======
    @objc func refreshTableView(){
        self.favNameArray.removeAll()
        self.favDescriptionArray.removeAll()
        self.favUrlArray.removeAll()
        fetchData()
        favouriteView.tableView.reloadData()
    }
    
    //MARK: - BUtton Actions

}


extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favNameArray.count == 0{
            tableView.setEmptyMessage("No Notes saved!")
            return favNameArray.count
        }else{
            tableView.setEmptyMessage("")
            return favNameArray.count
        }
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

