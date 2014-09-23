//
//  ViewController.swift
//  AYelp
//
//  Created by admin on 9/20/14.
//  Copyright (c) 2014 abdi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, FiltersViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var client: AYelpClient!
    

    let yelpConsumerKey = "rFXijaLgxyiD-anY7OAOmQ"
    let yelpConsumerSecret = "Aj3VBoBXEKSx51jWjb0HjqQlV6k"
    let yelpToken = "qv0Ywv5Uaqh86JaP-ki4ZjLTiCTKdcCn"
    let yelpTokenSecret = "u8FoNNI4A7rpnkIDW5d61ZjAeoQ"
    
    var restaurants: [NSDictionary] = []
    var filteredRestaurants: [NSDictionary] = []
    var filtersDictionary: Dictionary<String, String> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.redColor()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.showsScopeBar = true
        searchBar.delegate = self
        
        client = AYelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("restaurants", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            var biz = response as NSDictionary
            //let dictionary = NSJSONSerialization.JSONObjectWithData(response as NSData, options: nil, error: nil) as NSDictionary
            self.restaurants = biz["businesses"] as [NSDictionary]
            self.tableView.reloadData()
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //println("dictionary: \(dictionary)")
        


    }
    
    @IBAction func onTap(sender: AnyObject) {
        
        view.endEditing(true)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("I'm at row: \(indexPath.row), section: \(indexPath.section)")
        
        
        var restaurant: NSDictionary
        
        if tableView == self.searchDisplayController!.searchResultsTableView {
            restaurant = filteredRestaurants[indexPath.row]
        } else {
            restaurant = restaurants[indexPath.row]
        }
        
        var cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell") as RestaurantCell
        
        var rname = restaurant["name"] as? String
        cell.rnameLabel.text = "\(indexPath.row + 1). " + rname!
        
        var location = restaurant["location"] as NSDictionary
        //println(location)
        var raddress = location["display_address"] as NSArray
        var addressString: String
        addressString = raddress.componentsJoinedByString(", ")
        println("Address:\(addressString)")
        cell.raddressLabel.text = addressString
        
        var categories = restaurant["categories"] as NSArray
        
        if(indexPath.row == 18) {
          println("18")
        }
        var category: NSArray
        var catString: NSString
        var cuisinesString: NSString
        
        cuisinesString = ""
        for category in categories {
        
            catString = category.objectAtIndex(0) as NSString
            
            if cuisinesString.length == 0 {
                cuisinesString = catString
            }
            else {
                cuisinesString = cuisinesString + ", " + catString
            }

        }

        println(cuisinesString)
        cell.rcuisinesLabel.text = cuisinesString
        
        if restaurant["image_url"] != nil {
            var posterUrl = restaurant["image_url"] as String

            cell.posterView.setImageWithURL(NSURL(string: posterUrl))
        }
        
        var ratingsUrl: String
    
        if restaurant["rating_img_url_large"] != nil {
            ratingsUrl = restaurant["rating_img_url_large"] as String
        }
        else
        {
            ratingsUrl = restaurant["rating_img_url"] as String
        }
        cell.ratingsView.setImageWithURL(NSURL(string:ratingsUrl))
        
        var reviewsNum =  String(restaurant["review_count"] as NSInteger)
        
        cell.rreviewsLabel.text = reviewsNum + " Reviews"
        
        return cell
    }
    
//    func filterContentForSearchText(searchText: String)
//    {
//        client.searchWithTerm(searchText, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
//            //println(response)
//            var biz = response as NSDictionary
//            //let dictionary = NSJSONSerialization.JSONObjectWithData(response as NSData, options: nil, error: nil) as NSDictionary
//            self.filteredRestaurants = biz["businesses"] as [NSDictionary]
//            self.tableView.reloadData()
//            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
//                println(error)
//        }
//
//        
//    }
//    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        println("in search bar: \(searchBar.text)")
        
        client.searchWithTerm(searchBar.text, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            var biz = response as NSDictionary

            self.restaurants = biz["businesses"] as [NSDictionary]
            self.tableView.reloadData()
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
    }
    

    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        
        if range.location == 0 {
            client.searchWithTerm("restaurants", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println(response)
                var biz = response as NSDictionary
                
                self.restaurants = biz["businesses"] as [NSDictionary]
                self.tableView.reloadData()
                }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println(error)
            }
            
            //view.endEditing(true)
            
        }
        return true
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let filtersViewController = segue.destinationViewController.viewControllers![0] as FiltersViewController
        
        filtersViewController.delegate = self


        
    }
    
    func searchTermDidChange(filtersDictionary: NSDictionary) {
        
        //if(isDeals) {
            
        //    filtersDictionary["deals_filter"] = "true"
            
        //}
        
        client.searchWithFilters(filtersDictionary, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            var biz = response as NSDictionary
            
            self.restaurants = biz["businesses"] as [NSDictionary]
            self.tableView.reloadData()
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

