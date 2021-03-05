//
//  HomeView.swift
//  Therap_Test
//
//  Created by Iftiquar Ahmed Ove on 5/3/21.
//
import Foundation
import UIKit

import Foundation
import UIKit

class HomeView: UIView {
    
    //MARK: - Properties
    var tableView: UITableView!
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func commonInit(){
        tableView = UITableView()
        tableView.register(tableViewCell.self, forCellReuseIdentifier: "myCell")
        self.addSubview(tableView)
        tableView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    //MARK: - Button actions
}

class tableViewCell: UITableViewCell {
    //MARK: - Properties
    
    var controller: HomeVC?
    
    let nameLabel : UILabel = {
       let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let DescriptionLabel : UILabel = {
       let label = UILabel()
        label.text = "Server-side Swift. The Perfect core toolset and framework for Swift Developers. (For mobile back-end development, website and API development, and more…"
        label.numberOfLines = 5
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let urlLabel : UILabel = {
       let label = UILabel()
        label.text = "git://github.com/yichengchen/clashX.git"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let favourite_button: UIButton = {
       let btn = UIButton()
        btn.setBackgroundImage(#imageLiteral(resourceName: "favourite"), for: .normal)
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    
    //MARK: - Initializers


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        handleViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - Functions
    
    func handleViews(){
        addSubview(nameLabel)
        addSubview(DescriptionLabel)
        addSubview(urlLabel)
        addSubview(favourite_button)
        
        nameLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        favourite_button.anchor(top: nil, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 30, height: 30)
        favourite_button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        favourite_button.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        
        DescriptionLabel.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: favourite_button.leftAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 5 , width: 0, height: 0)
        
        urlLabel.anchor(top: DescriptionLabel.bottomAnchor, left: DescriptionLabel.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc func favouriteButtonTapped(sender: UIButton){
        controller!.favourite_cell(self)
    }
}
