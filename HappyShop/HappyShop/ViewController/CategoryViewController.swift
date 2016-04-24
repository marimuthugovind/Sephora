//
//  FirstViewController.swift
//  HappyShop
//
//  Created by Marimuthu on 4/19/16.
//  Copyright © 2016 Marimuthu. All rights reserved.
//

import UIKit
import MBProgressHUD


class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var categoryList: UITableView!
  
  var allcategories:NSMutableArray!
  var selectedCategoryIndex : Int!
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.title = "Category";
    self.allcategories = NSMutableArray();
    self.makeServiceCallToGetCategories();
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated);
    self.categoryList.contentInset = UIEdgeInsetsMake(-80, 0, 0, 0);
  }
  
  //#MARK: Table view Datasource and Delegate methods
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return self.allcategories.count;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
    let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("categoryCell")! as UITableViewCell
    let category = self.allcategories[indexPath.row] as! Category;
    
    let titleString = category.name+"\t("+String(category.noOfProducts)+")";
    
    cell.textLabel?.text = titleString;
    
    return cell
  }
  
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.selectedCategoryIndex = indexPath.row;
    self.performSegueWithIdentifier("productListSegue", sender: tableView);
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let prodList = segue.destinationViewController as! ProductListViewController;
    prodList.currentCategory = self.allcategories[self.selectedCategoryIndex] as! Category;
  }
  
  //#MARK: websevice invocation method
  
  func makeServiceCallToGetCategories(){
    
    let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    loadingNotification.mode = MBProgressHUDMode.Indeterminate
    loadingNotification.labelText = "Fetching Categories"
    
    NetworkAPI.getCategories(
      { (categories) -> Void in
        self.allcategories = categories as! NSMutableArray;
        self.categoryList.reloadData();
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
      })
      { (error) -> Void in
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        
        CommonUtils.showErrorAlert(error.localizedDescription, inController: self)
        
    };
  }
  
  
}

