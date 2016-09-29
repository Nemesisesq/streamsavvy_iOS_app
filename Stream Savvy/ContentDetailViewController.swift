//
//  ContentDetailViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 9/25/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit

class ContentDetailViewController: UIViewController  {
    
    var hello = "Detailed World"
    
    var content: Content!
    
    
    @IBOutlet var test: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var addFavoriteButton: UIButton!
    
    @IBAction func addContentToFavorites(_ sender: UIButton) {
        Favorites.addContentToFavorites(content: content)
            .then { _ -> Void in
//                self.performSegue(withIdentifier: "ContentAdded", sender: sender)
                
                
                let fvc = self.storyboard?.instantiateViewController(withIdentifier: "FavoritesViewController")
                self.present(fvc!, animated: true, completion: nil)
                 
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test.text = content.title
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
