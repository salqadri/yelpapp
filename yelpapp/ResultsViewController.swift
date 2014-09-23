//
//  ResultsViewController.swift
//  yelpapp
//
//  Created by Syed Salman Qadri on 9/22/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!

    var client: YelpClient!

    @IBOutlet weak var searchBar: UISearchBar!
    var businesses: NSArray! = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.client = YelpClient(consumerKey: "TuNMuHUazdKxlO46T1J5-Q", consumerSecret: "VnqsTAPnWlFVTLdjtdS5vahDB-k", accessToken: "g09xHSBTWS0CoC2bfNU_P-MHKVGK-eeu", accessSecret: "btR1H7SoBT0l8B3sli1plfrG1ZE")

        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ResultCell") as ResultCell;
        var result = self.businesses[indexPath.row] as NSDictionary;
        cell.tag = indexPath.row;
        cell.lblAddress.text = ((result["location"] as NSDictionary)["display_address"] as NSArray).componentsJoinedByString(", ");
        var name = result["name"] as NSString;
        
        cell.lblTitle.text = "\(indexPath.row+1): \(name)";
        var image_url = result["image_url"] as NSString!;
        if (image_url != nil) {
            cell.viewImage.setImageWithURL(NSURL(string: image_url));
        }
        cell.lblCuisine.text = ((result["categories"] as NSArray)[0] as NSArray)[0] as NSString
        var rating = result["rating"] as Double
        var numReviews = result["review_count"] as Double
        cell.lblReviews.text = "\(rating)/5.0 from \(numReviews) reviews"

        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()

        return cell;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.businesses = NSArray()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.client.searchWithTerm(searchBar.text, success: { (operation, response) -> Void in
            var results = response as NSDictionary;
            self.businesses = results["businesses"] as NSArray;
            self.tableView.reloadData()
            searchBar.resignFirstResponder()
            }) { (operation, error) -> Void in
                println(error);
        }
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
