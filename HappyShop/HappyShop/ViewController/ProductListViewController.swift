//
//  ProductListViewController.swift
//  HappyShop
//
//  Created by Marimuthu on 4/21/16.
//  Copyright © 2016 Marimuthu. All rights reserved.
//

import UIKit
import AlamofireImage
import MBProgressHUD

class ProductListViewController: UIViewController,
  UICollectionViewDataSource,
  UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {
  
  var currentCategory:Category!
  var allProducts:NSMutableArray!
  var selectedCategoryIndex : Int!
  var pageNo : Int!
  
  @IBOutlet weak var productsListView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.allProducts = NSMutableArray();
    self.pageNo = 1;
    self.makeServiceCallToGetProducts();
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated);
    self.title = self.currentCategory.name ;
  }
  
  //#MARK: Collection view delegates and Datasource
  
  func collectionView(collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
    return self.allProducts.count;
  }
  
  func collectionView(collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("productThumbnailCell", forIndexPath: indexPath) as! ProductCell;
    //Making border for the cell
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor=UIColor.blackColor().CGColor;

    // Populating data
    let product = self.allProducts[indexPath.item] as! ProductModel;
    
    cell.productName.text? = product.name!;
    cell.price.text? = NSString(format: "%.2f", product.price!) as String
    
    if(product.isUnderSale == true ){
      cell.onSaleLabel.hidden = false;
    }
    
    let URL = NSURL(string: product.imageUrl!)!
    cell.thumbnailImg.af_setImageWithURL(URL)
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView,
    didSelectItemAtIndexPath indexPath: NSIndexPath) {
    self.selectedCategoryIndex = indexPath.row;
    self.performSegueWithIdentifier("productDetailSegue", sender: collectionView);
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let prodDetail = segue.destinationViewController as! ProductDetailViewController;
    prodDetail.currentProduct = self.allProducts[self.selectedCategoryIndex] as! ProductModel;
  }

  func makeServiceCallToGetProducts(){
    let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    loadingNotification.mode = MBProgressHUDMode.Indeterminate
    loadingNotification.labelText = "Fetching Produts"
    
    NetworkAPI.getProductListForCategories(self.pageNo,
      category: self.currentCategory.name,
      onSuccess: { (products) -> Void in
        var myArray : NSMutableArray!
        myArray = products as AnyObject as! NSMutableArray
        self.allProducts.addObjectsFromArray(myArray as [AnyObject])
  
        self.productsListView.reloadData();
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
      }, onError: { (error) -> Void in
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        CommonUtils.showErrorAlert(error.localizedDescription, inController: self)
    });
  }
  
  //#MARK: Scroll view delegate method
  func scrollViewDidScroll(scrollView: UIScrollView) {
    // Logic to get the paginated data
    let offset:CGPoint = scrollView.contentOffset;
    let bounds: CGRect = scrollView.bounds;
    let size:CGSize = scrollView.contentSize;
    let inset:UIEdgeInsets = scrollView.contentInset;
    let y = offset.y + bounds.size.height - inset.bottom;
    let h = size.height;
    
    if(y > h)
    {
      
            let totalPages = Int(ceil(Float(self.currentCategory.noOfProducts)/10.0));
            if(self.pageNo<totalPages){
              self.pageNo = self.pageNo + 1;
              self.makeServiceCallToGetProducts();
              print("summa");
            }


  }
  
  }
  
}
