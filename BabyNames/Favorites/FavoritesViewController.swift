//
//  SecondViewController.swift
//  BabyNames
//
//  Created by Tyler Lafferty on 7/25/18.
//  Copyright © 2018 Tyler Lafferty. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // -- Outlets --
    @IBOutlet var tableView: UITableView!
    
    // -- Vars --
    var favoriteNames: [Name] = []
    var maleFavorites: [Name] = []
    var femaleFavorites: [Name] = []
    var maleExpanded: Bool = false
    var femaleExapanded: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        genderizeArray()
        tableView.reloadData()
    }
}

// MARK: - TableView Delegate, Datasource
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "favoritesHeader") as! FavoritesHeaderCell
        var headerTxt = ""
        if section == 0 {
            headerTxt = "Male (\(maleFavorites.count) liked)"
        } else if section == 1 {
            headerTxt = "Female (\(femaleFavorites.count) liked)"
        }
        header.setupCell(headerTxt: headerTxt, section: section, maleExpanded: maleExpanded, femaleExpanded: femaleExapanded)
        header.contentView.tag = section
        let tap = UITapGestureRecognizer(target: self, action: #selector(FavoritesViewController.toggleHeader(gesture:)))
        header.contentView.addGestureRecognizer(tap)
        return header.contentView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if maleExpanded {
                if maleFavorites.count == 0 {
                    return 1
                }
                return maleFavorites.count
            }
        } else if section == 1 {
            if femaleExapanded {
                if femaleFavorites.count == 0 {
                    return 1
                }
                return femaleFavorites.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var nameArray: [Name] = []
        if indexPath.section == 0 {
            nameArray = maleFavorites
        } else if indexPath.section == 1 {
            nameArray = femaleFavorites
        }
        if nameArray.count == 0 {
            // The array is empty. Display no favorites title
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: "favoritesNameCell", for: indexPath) as! FavoritesNameCell
            emptyCell.nameLbl.text = "No names liked"
            return emptyCell
        }
        let name = nameArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesNameCell", for: indexPath) as! FavoritesNameCell
        cell.nameLbl.text = name.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.section == 0 && maleFavorites.count == 0) || (indexPath.section == 1 && femaleFavorites.count == 0) {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .default, title: "Remove") { (action, indexPath) in
            if indexPath.section == 0 {
                self.showRemoveLikeAlert(name: self.maleFavorites[indexPath.row], section: indexPath.section)
            } else if indexPath.section == 1 {
                self.showRemoveLikeAlert(name: self.femaleFavorites[indexPath.row], section: indexPath.section)
            }
        }
        if indexPath.section == 0 {
            action.backgroundColor = BOY_COLOR
        } else if indexPath.section == 1 {
            action.backgroundColor = GIRL_COLOR
        }
        return [action]
    }
}

// MARK: - Header Cell Delegate
extension FavoritesViewController {
    
    /// Collapse and exapnd the table view header
    @objc func toggleHeader(gesture: UITapGestureRecognizer) {
        if let section = gesture.view {
            if section.tag == 0 {
                maleExpanded = !maleExpanded
            } else if section.tag == 1 {
                femaleExapanded = !femaleExapanded
            }
            tableView.reloadSections(IndexSet(integer: section.tag), with: .automatic)
        }
    }
}

// MARK: - Helpers
extension FavoritesViewController {
    
    /// Pull the most recent favorites and split them into male and female arrays
    func genderizeArray() {
        favoriteNames = BNShared.getFavorites()
        maleFavorites = []
        femaleFavorites = []
        
        for name in favoriteNames {
            if name.gender == .male {
                maleFavorites.append(name)
            } else if name.gender == .female {
                femaleFavorites.append(name)
            }
        }
        
        femaleFavorites = femaleFavorites.sorted { $0.name < $1.name }
        maleFavorites = maleFavorites.sorted { $0.name < $1.name }
    }
    
    /// Prompt an alert confirming to remove the name from the favorites
    func showRemoveLikeAlert(name: Name, section: Int) {
        let alert = UIAlertController(title: "Baby Names", message: "Would you like to remove \(name.name) from your favorites?", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Yes", style: .default) { (action) in
            BNShared.removeFavorite(name: name)
            self.genderizeArray()
            self.tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(confirm)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}












