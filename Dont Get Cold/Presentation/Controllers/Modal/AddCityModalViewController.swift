//
//  AddCityModalViewController.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/3/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit
import CoreLocation

protocol AddCityModalViewControllerDelegate: NSObjectProtocol {
    func update(withNewCity city: City)
}

extension AddCityModalViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchedText = searchBar.text {
            self.searchedData = cities.filter { $0.name.contains(searchedText) }
            self.tableView.reloadData()
            
            CLGeocoder().geocodeAddressString("Aleppo") { (pl, error) in
                //print(error)
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let searchedText = searchBar.text {
            self.searchedData = cities.filter { $0.name.contains(searchedText) }
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddCityModalViewController: UISearchDisplayDelegate {
    
}

extension AddCityModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.update(withNewCity: searchedData[indexPath.row])
        }
        searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension AddCityModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        cell.textLabel?.text = searchedData[indexPath.row].name + ", " + searchedData[indexPath.row].country
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedData.count
    }
}

class AddCityModalViewController: UIViewController {

    //MARK: Members
    var cities: [City] = []
    var searchedData: [City] = []
    weak var delegate: AddCityModalViewControllerDelegate?
    
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addBlur(withStyle: .dark)
        self.tableView.separatorStyle = .none
        self.searchBar.becomeFirstResponder()
    }
}
