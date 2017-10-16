//
//  ViewController.swift
//  AroundMe
//
//  Created by Aashana on 10/9/17.
//  Copyright © 2017 Aashana. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var options: Array<Dictionary<String, String>>=[[:]]
    let cellReuseIdentifier = "PlacesCell"
    
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Choice List"
        
        let optionsDict1 = ["text": "Restaurants",
                           "apiKey": "restaurant",
                            "icon": "restaurant"]
        let optionsDict2 = ["text": "Shopping malls",
                            "apiKey": "shopping_mall",
                            "icon":"shopping"]
        let optionsDict3 = ["text": "Gas Stations",
                            "apiKey": "gas_station",
                            "icon":"gasstation"]
        let optionsDict4 = ["text": "Casino",
                            "apiKey": "casino",
                            "icon":"casino"]
        let optionsDict5 = ["text": "Police",
                            "apiKey": "police",
                            "icon":"police"]
        let optionsDict6 = ["text": "Doctor",
                            "apiKey": "doctor",
                            "icon":"doctor"]
        let optionsDict7 = ["text": "Train Station",
                            "apiKey": "train_station",
                            "icon":"trainstation"]
        let optionsDict8 = ["text": "Transit Station",
                            "apiKey": "transit_station",
                            "icon":"trainstation"]
        let optionsDict9 = ["text": "Grocery Store",
                            "apiKey": "store",
                            "icon":"grocerystore"]
        let optionsDict10 = ["text": "Bank",
                            "apiKey": "bank",
                            "icon":"bank"]
        
    options=[optionsDict1,optionsDict2,optionsDict3,optionsDict4,optionsDict5,optionsDict6,optionsDict7,optionsDict8,optionsDict9,optionsDict10]
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        // create a new cell if needed or reuse an old one
        
        let cell:PlacesCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! PlacesCell
        
        if let name = self.options[indexPath.row]["text"]
        {
            cell.rating.text = name
        }
        cell.name.isHidden = true
        cell.address.isHidden = true
        cell.background.image = UIImage(named: self.options[indexPath.row]["icon"]!)
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeViewController = self.storyboard?.instantiateViewController(withIdentifier: "PlaceViewController") as! PlaceViewController
        
        placeViewController.establishment = options[indexPath.row]["apiKey"]
    self.navigationController?.pushViewController(placeViewController, animated: true)
    }
 


}

