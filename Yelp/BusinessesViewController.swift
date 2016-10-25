//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate {
    
    var businesses: [Business]!
    
    var switchStates : [Int:[Int:Bool]]! = [
        0:[0:false],
        1:[0:false],
        2:[0:false],
        3:[0:false]
    ]
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        // Grab refernce to filtersViewController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
        filtersViewController.switchStates = self.switchStates
    }

    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters: [String : AnyObject]) {
        var filters = didUpdateFilters
        var dealBool : Bool
        if(filters["deals"] as? String == "on"){
            dealBool = true
        } else {
            dealBool = false
        }
        var categories = filters["categories"] as! [String]?
        print("categories: \(categories)")
        Business.searchWithTerm(term: "Restaurants", sort: filters["sort"] as? YelpSortMode, categories: filters["categories"] as! [String]? , deals: dealBool) {
            (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didSaveSwitchStates: [Int:[Int:Bool]]) {
        self.switchStates = didSaveSwitchStates
    }
    
    

    
    
}
