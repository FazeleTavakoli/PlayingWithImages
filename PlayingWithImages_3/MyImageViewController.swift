//
//  MyImageViewController.swift
//  PlayingWithImages_3
//
//  Created by mblb on 20.08.19.
//  Copyright © 2019 MobiLab. All rights reserved.
//

import UIKit

class MyImageViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    var selectedImage: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            let imageUrl = NSURL(string: self.selectedImage)
            let imageData = NSData(contentsOf: imageUrl! as URL)
//            let imageData = UIImage(contentsOfFile: self.selectedImage)
//            if(imageData != nil){
//                self.myImageView.image =  imageData
//            }
            if(imageData != nil){
                self.myImageView.image = UIImage(data: imageData! as Data)
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
