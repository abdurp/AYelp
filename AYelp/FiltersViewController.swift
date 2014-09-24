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

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersCellDelegate, RadiusCellDelegate, SortByCellDelegate, CategoryCellDelegate {

    var delegate: FiltersViewControllerDelegate?
    @IBOutlet weak var filtersTableView: UITableView!
    
    var categories = ["chinese", "thai", "japanese", "american", "seafood", "indian", "halal", "vegetarian"] as NSArray
    
    var catDisplayMax: Int = 5
    var seeMoreClicked: Bool = false
    var categorySelectionDict:[Int:Bool] = [0: false, 1: false, 2: false, 3: false, 4: false, 5: false, 6: false, 7: false]
    
    var filtersByCategory: [String: Bool] = [String: Bool]()
    
    var filtersDictionary: Dictionary<String, String> = [:]
    
    var isDeals: Bool = false
    var sortByNum: Int = 0
    var distance: Int = 0
    
    var radiusDict:[Int:Int]! = [1:1, 2:5, 3:10, 4:20]
    var radiusSelectionDict:[Int:Bool] = [0: true, 1: false, 2: false, 3: false, 4: false]
    var radiusSwitch: Bool = false
    
    var sortByDict:[Int:String]! = [0: "Best Matched", 1: "Distance", 2: "Highest Rated"]
    var sortBySelectionDict:[Int:Bool] = [0: true, 1: false, 2: false]
    
    var isExpanded:[Int:Bool]!  = [Int:Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filtersTableView.delegate = self
        filtersTableView.dataSource = self
        
        
        filtersTableView.rowHeight = UITableViewAutomaticDimension
        
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
        
        if(sortBySelectionDict[0] == true) {
            sortByNum = 0
        }
        else if(sortBySelectionDict[1] == true)
        {
            sortByNum = 1
        }
        else {
            sortByNum = 2
        }
        
        filtersDictionary["sort"] = String(sortByNum)
        
        if (radiusSelectionDict[1] == true) {
            distance = radiusDict[1]!
        }
        else if (radiusSelectionDict[2] == true) {
            distance = radiusDict[2]!
        }
        else if (radiusSelectionDict[3] == true) {
            distance = radiusDict[3]!
        }
        else if (radiusSelectionDict[4] == true) {
            distance = radiusDict[4]!
        }
        
        if ( distance > 0 ) {
            filtersDictionary["distance"] = String(distance)
        }
        
        
        var filteredCategories = NSMutableArray ()
        
        if(categorySelectionDict[0] == true) {
            filteredCategories.addObject ( categories.objectAtIndex(0) as String)
        }
        if(categorySelectionDict[1] == true) {
            filteredCategories.addObject( categories.objectAtIndex(1) as String)
        }
        if(categorySelectionDict[2] == true) {
            filteredCategories.addObject( categories.objectAtIndex(2) as String)
        }
        if(categorySelectionDict[3] == true) {
            filteredCategories.addObject( categories.objectAtIndex(3) as String)
        }
        if(categorySelectionDict[4] == true) {
            filteredCategories.addObject( categories.objectAtIndex(4) as String)
        }
        if(categorySelectionDict[5] == true) {
            filteredCategories.addObject( categories.objectAtIndex(5) as String)
        }
        if(categorySelectionDict[6] == true) {
            filteredCategories.addObject( categories.objectAtIndex(6) as String)
        }
        if(categorySelectionDict[7] == true) {
            filteredCategories.addObject( categories.objectAtIndex(7) as String)
        }
        
        
        var categoryString = filteredCategories.componentsJoinedByString(",")
        
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
        if let expanded = isExpanded[section] {
            if(expanded) {
                switch(section)
                {
                    case 0: // Deals
                        return 1
                    case 1: // Radius
                        return 5
                    case 2: // Sort By
                        return 3
                    case 3: // Category
                        if (seeMoreClicked) {
                            return categories.count - 1
                        }
                        else {
                            return catDisplayMax+1
                        }
                    default: // Do nothing
                        return 1
                }
            }
            else {
                if(section == 3 && seeMoreClicked) {
                    return categories.count - 1
                }
                else if (section == 3) {
                    return catDisplayMax+1
                }
                else {
                    return 1
                }
            }
        }
        else {
            if(section == 3 && seeMoreClicked) {
                return categories.count - 1
            }
            else if (section == 3) {
                return catDisplayMax+1
            }
            else {
                return 1
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        
        headerView.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        
        var headerLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 320, height: 50))
        
        switch(section)
        {
        case 0:
            headerLabel.text = "Deals"
        case 1:
            headerLabel.text = "Distance"
        case 2:
            headerLabel.text = "Sort By"
        case 3:
            headerLabel.text = "Categories"
        default:
            headerLabel.text = "Other"
        }
        
        //headerLabel.text = "Section \(section)"
        
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
            var cell = filtersTableView.dequeueReusableCellWithIdentifier("RadiusCell") as RadiusCell
            cell.delegate = self

            if(indexPath.row == 0) {
                cell.radiusLabel.text = "Auto"
            }
            else {
                cell.radiusLabel.text = "\(radiusDict[indexPath.row]!) meters"
            }
            cell.radiusSwitch.on = radiusSelectionDict[indexPath.row]!

            return cell
            
        case 2:
            var cell = filtersTableView.dequeueReusableCellWithIdentifier("SortByCell") as SortByCell
            cell.delegate = self
            cell.sortbyLabel.text = "\(sortByDict[indexPath.row]!)"
            
            cell.sortBySwitch.on = sortBySelectionDict[indexPath.row]!
            
            return cell
            
        case 3:
            var cell = filtersTableView.dequeueReusableCellWithIdentifier("CategoryCell") as CategoryCell
            cell.delegate = self
            if(seeMoreClicked == false && indexPath.row == catDisplayMax) {
                cell.categoryLabel.text = "See More"
                cell.categorySwitch.hidden = true
            }
            else {
                cell.categoryLabel.text = "\(categories.objectAtIndex(indexPath.row))"
                cell.categorySwitch.hidden = false
            }
            
            cell.categorySwitch.on = categorySelectionDict[indexPath.row]!

            return cell
            
        default:
            var cell = filtersTableView.dequeueReusableCellWithIdentifier("FiltersCell") as FiltersCell
            cell.delegate = self
            return cell
            
        }
        

    }
    
    func filtersCell(filtersCell: FiltersCell, didChangeValue value: Bool) {
        var indexPath = filtersTableView.indexPathForCell(filtersCell)
        
        isDeals = value
    }
    
    func radiusCell(radiusCell: RadiusCell, didChangeValue value: Bool) {
        var radiusIndexPath = filtersTableView.indexPathForCell(radiusCell)
        
        if let radiusOn = radiusSelectionDict[radiusIndexPath!.row] {
            
            if(radiusOn) {
            
            // Make All False and Auto True
            radiusSelectionDict[0] = true
            
            radiusSelectionDict[1] = false
            radiusSelectionDict[2] = false
            radiusSelectionDict[3] = false
            radiusSelectionDict[4] = false
            
            radiusSelectionDict[radiusIndexPath!.row] = !value
            }
            else {
                
                // Make all false and just the newly selected one true
                radiusSelectionDict[0] = false
                radiusSelectionDict[1] = false
                radiusSelectionDict[2] = false
                radiusSelectionDict[3] = false
                radiusSelectionDict[4] = false
                
                radiusSelectionDict[radiusIndexPath!.row] = true
                
                
            }
        }
        else {
            
            // Make all false and just the newly selected one true
            radiusSelectionDict[0] = false
            radiusSelectionDict[1] = false
            radiusSelectionDict[2] = false
            radiusSelectionDict[3] = false
            radiusSelectionDict[4] = false
            
            radiusSelectionDict[radiusIndexPath!.row] = true
            
            
        }
        
        
        
        isExpanded[radiusIndexPath!.section] = false
        
        filtersTableView.reloadSections(NSIndexSet(index: radiusIndexPath!.section), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func sortByCell(sortByCell: SortByCell, didChangeValue value: Bool) {
        
        var sortByIndexPath = filtersTableView.indexPathForCell(sortByCell)
        
        if let sortByOn = sortBySelectionDict[sortByIndexPath!.row] {

            if(sortByOn) {
            
            // Make All False and Auto True
            sortBySelectionDict[0] = true
            
            sortBySelectionDict[1] = false
            sortBySelectionDict[2] = false
            sortBySelectionDict[3] = false
            sortBySelectionDict[4] = false
            
            sortBySelectionDict[sortByIndexPath!.row] = !value
            }
            else {
                
                // Make all false and just the newly selected one true
                sortBySelectionDict[0] = false
                sortBySelectionDict[1] = false
                sortBySelectionDict[2] = false
                sortBySelectionDict[3] = false
                sortBySelectionDict[4] = false
                
                sortBySelectionDict[sortByIndexPath!.row] = true
                
            }
        }
        else {
            
            // Make all false and just the newly selected one true
            sortBySelectionDict[0] = false
            sortBySelectionDict[1] = false
            sortBySelectionDict[2] = false
            sortBySelectionDict[3] = false
            sortBySelectionDict[4] = false
            
            sortBySelectionDict[sortByIndexPath!.row] = true
            
        }
        
        isExpanded[sortByIndexPath!.section] = false
        
        filtersTableView.reloadSections(NSIndexSet(index: sortByIndexPath!.section), withRowAnimation: UITableViewRowAnimation.Fade)
    

    }
    
    
    func categoryCell(categoryCell: CategoryCell, didChangeValue value: Bool) {
        
        var categoryIndexPath = filtersTableView.indexPathForCell(categoryCell)
        
        if let categoryOn = categorySelectionDict[categoryIndexPath!.row] {
            if(categoryOn) {
                categorySelectionDict[categoryIndexPath!.row] = !value
            }
            else {
                categorySelectionDict[categoryIndexPath!.row] = true
            }

        }
        else {
            categorySelectionDict[categoryIndexPath!.row] = true
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        filtersTableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 3 { // Category

            if (indexPath.row == catDisplayMax && seeMoreClicked == false) {
                seeMoreClicked = true
            
            
                filtersTableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
            
                return
            }
        
        }
        
        
        if let expanded = isExpanded[indexPath.section] {
            isExpanded[indexPath.section] = !expanded
        }
        else {
            isExpanded[indexPath.section] = true
        }
        
        filtersTableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
            

        
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
