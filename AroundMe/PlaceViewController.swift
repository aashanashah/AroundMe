//
//  PlaceViewController.swift
//  Explore 360
//
//  Created by Aashana on 10/10/17.
//  Copyright © 2017 Aashana. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class PlaceViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var establishment : String!
    var options = [[String:AnyObject]]()
    let cellReuseIdentifier = "PlacesCell"
    let API_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?radius=500"
    let LOCATION_URL = "&location="
    let TYPE_URL = "&type="
    let KEY_URL = "&key="
    let API_KEY = "AIzaSyCn0RcFV5pQyY-KL5opsMbkNcAKH9y9-Ew"
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let final_url:String = API_URL+LOCATION_URL+"\(appDelegate.globalValue.latitude),\(appDelegate.globalValue.longitude)"+TYPE_URL+"\(establishment!)"+KEY_URL+API_KEY
        callPlacesAPI(placesUrl: final_url)
        self.title="List of Options"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func callPlacesAPI(placesUrl: String){
        SVProgressHUD.show()
        DispatchQueue.global(qos: .userInitiated).async
        {
            SVProgressHUD.show()
        }
        Alamofire.request(placesUrl).responseJSON { response in
            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    self.options = resData as! [[String:AnyObject]]
                }
                DispatchQueue.global(qos: .userInitiated).async
                {
                    SVProgressHUD.dismiss()
                }
                if self.options.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PlacesCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! PlacesCell

        if let name = self.options[indexPath.row]["name"]
        {
            cell.name.text = name as? String
        }
        if let vicinity = self.options[indexPath.row]["vicinity"]
        {
            cell.address.text = vicinity as? String
        }
        if let url = self.options[indexPath.row]["icon"]
        {
            DispatchQueue.global().async
            {
                let data = try? Data(contentsOf: URL(string: url as! String)!)
                DispatchQueue.main.async
                {
                    cell.background.image = UIImage(data: data!)
                }
            }
        }
        if let rating = self.options[indexPath.row]["rating"]
        {
            cell.rating.text = "\u{2B51} \(rating)"
        }
        else
        {
                cell.rating.text = "\u{2B51} nil"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 135.0
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        let name = (JSON(self.options[indexPath.row]["name"])).string
        let geom = (JSON(self.options[indexPath.row]["geometry"])).dictionary
        let latitude=geom!["location"]!["lat"].double
        let longitude=geom!["location"]!["lng"].double
        mapViewController.latitude = latitude
        mapViewController.longitude = longitude
        mapViewController.name = name
        
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
