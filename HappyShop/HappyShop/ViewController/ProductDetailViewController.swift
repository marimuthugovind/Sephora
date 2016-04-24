//
//  ProductDetailViewController.swift
//  HappyShop
//
//  Created by Marimuthu on 4/22/16.
//  Copyright © 2016 Marimuthu. All rights reserved.
//

import UIKit
import MBProgressHUD
import CoreData

class ProductDetailViewController: UIViewController {
  

  @IBOutlet weak var productImageView: UIImageView!
  
  @IBOutlet weak var productNameLbl: UILabel!
  @IBOutlet weak var productPriceLbl: UILabel!
  @IBOutlet weak var onSaleLbl: UILabel!
  @IBOutlet weak var addToCartBtn: UIButton!
  @IBOutlet weak var productDescriptionView: UITextView!
  

  var currentProduct:ProductModel!
  
  var detailedProduct:ProductModel!
  

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      self.makeWebserviceCallToGetProductDetail();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated);
    self.title = self.currentProduct.name ;
  }
  
  @IBAction func onTapAddToCart(sender: AnyObject) {
    CoreDataManager.sharedInstance.insertNewProduct(detailedProduct);
    
    
    let alertController: UIAlertController =
      UIAlertController(title: "",
      message: "Product added into Cart!",
      preferredStyle: .Alert)
    
    
    let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel) { action -> Void in
      //Do some stuff
    }
    alertController.addAction(okAction)
    
    
    self.presentViewController(alertController, animated: true, completion: nil)
    
    
  }

  func updateUI(){
    
    self.productNameLbl.text = self.detailedProduct.name;
    self.productPriceLbl.text = NSString(format: "%.2f", self.detailedProduct.price!) as String;
    self.productDescriptionView.text = self.detailedProduct.prodDescription;
  
    if(self.detailedProduct.isUnderSale == true){
      self.onSaleLbl.hidden = false;
    }
    
    let URL = NSURL(string: self.detailedProduct.imageUrl!)!
    self.productImageView.af_setImageWithURL(URL)
  }
  
  func makeWebserviceCallToGetProductDetail(){
    
    let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    loadingNotification.mode = MBProgressHUDMode.Indeterminate
    
    NetworkAPI.getProductDetails(self.currentProduct.productId!, onSuccess: { (product) -> Void in
      self.detailedProduct = product;
      self.updateUI();
      MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
      }) { (error) -> Void in
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        self.addToCartBtn.hidden = true;
        self.productImageView.hidden = true;
        CommonUtils.showErrorAlert(error.localizedDescription, inController: self)
    }
  }

}
