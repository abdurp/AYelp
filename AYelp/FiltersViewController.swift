//
//  FiltersViewController.swift
//  AYelp
//
//  Created by admin on 9/21/14.
//  Copyright (c) 2014 abdi. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate {
    func searchTermDidChange(NSDictionary)
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersCellDelegate {

    var delegate: FiltersViewControllerDelegate?
    @IBOutlet weak var filtersTableView: UITableView!
    
    var categories = ["chinese", "thai", "japanese"] as NSArray
    var filtersByCategory: [String: Bool] = [String: Bool]()
    
    var filtersDictionary: Dictionary<String, String> = [:]
    
    var isDeals: Bool = false
    var sortByNum: Int = 0
    var distance: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filtersTableView.delegate = self
        filtersTableView.dataSource = self
        
        
        filtersTableView.rowHeight = 120 //UITableViewAutomaticDimension
        
        filtersDictionary["term"] = "restaurants"
        filtersDictionary["location"] = "San Francisco"
    }

    @IBAction func onCancelButton(sender: AnyObject) {
         dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSearchButton(sender: AnyObject) {
        
        if(isDeals)
        {
            filtersDictionary["deals_filter"] = "true"
        }
        
        filtersDictionary["sort"] = String(sortByNum)
        
        if(distance > 0) {
            filtersDictionary["distance"] = String(distance)
        }
        
        filtersByCategory["Chinese"] = true
        
        var categoryString = categories.componentsJoinedByString(",")
        
        filtersDictionary["category_filter"] = categoryString
        
        //filtersDictionary["category_filter"] = "chinese,thai,japanese"
        delegate?.searchTermDidChange(filtersDictionary)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        
        headerView.backgroundColor = UIColor.grayColor()
        
        var headerLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 320, height: 50))
        
        headerLabel.text = "Section \(section)"
        
        headerView.addSubview(headerLabel)
        
        return headerView
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        
        switch(indexPath.section) {
        
        case 0: // Deals
            var cell = filtersTableView.dequeueReusableCellWithIdentifier("FiltersCell") as FiltersCell
            cell.delegate = self
            cell.dealsSwitch.setOn(isDeals, animated: true)
            return cell
            
        case 1:
            println("radius")
            var cell = filtersTableView.dequeueReusableCellWithIdentifier("RadiusCell") as RadiusCell
            return cell
        case 2:
            println("sort by")
            var cell = filtersTableView.dequeueReusableCellWithIdentifier("SortByCell") as SortByCell
            return cell
        case 3:
            println("category")
            var cell = filtersTableView.dequeueReusableCellWithIdentifier("CategoryCell") as CategoryCell
            return cell
        default:
            println("should not come here")
            var cell = filtersTableView.dequeueReusableCellWithIdentifier("FiltersCell") as FiltersCell
            return cell
            
        }
        
        //return cell
    }
    
    func filtersCell(filtersCell: FiltersCell, didChangeValue value: Bool) {
        var indexPath = filtersTableView.indexPathForCell(filtersCell)
        
        isDeals = value
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
