//
//  ListViewController.swift
//  Srujan_Project
//
//  Created by Srujan k on 04/03/20.
//  Copyright © 2020 Srujan k. All rights reserved.
// https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json

import UIKit
import Kingfisher

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tableView = UITableView()
    var factsList: FactsList?
    
    
    // MARK: - Controller Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    // MARK: - UIView Methods
    func setupView()  {
        self.view.backgroundColor = UIColor.white
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        getFactsList()
    }
    
    // MARK: - UITableView Delegate, DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.factsList?.rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.cellIdentifier)
        cell.textLabel?.text = self.factsList?.rows?[indexPath.row].title ?? "Empty"
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = self.factsList?.rows?[indexPath.row].description ?? "Empty"
        cell.imageView?.kf.setImage(with: URL(string: self.factsList?.rows?[indexPath.row].imageHref ?? ""))
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    // MARK: - API Methods
    func getFactsList()  {
        let activity = Utils.sharedInstance.StartActivityIndicator(obj: self)
        
        NetworkManager.sharedInstance.getFacts(completion: { (boolValue, object, data) in
            Utils.sharedInstance.StopActivityIndicator(obj: self, indicator: activity)
            guard let data = data else { Utils.sharedInstance.showAlert(viewController: self, text:"Something went wrong") ; return}
            do{
                self.factsList = try JSONDecoder().decode(FactsList.self, from: data)
                DispatchQueue.main.async {
                    self.title = self.factsList?.title
                    self.tableView.reloadData()
                }
            }catch{
                Utils.sharedInstance.showAlert(viewController: self, text: error.localizedDescription)
            }
        }) { (statusCode, error) in
            Utils.sharedInstance.StopActivityIndicator(obj: self, indicator: activity)
            Utils.sharedInstance.showAlert(viewController: self, text: error?.localizedDescription ?? "Something went wrong")
        }
    }
}
