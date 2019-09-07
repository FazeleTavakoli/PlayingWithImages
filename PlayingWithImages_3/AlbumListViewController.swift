//
//  AlbumListViewController.swift
//  PlayingWithImages_3
//
//  Created by mblb on 02.09.19.
//  Copyright © 2019 MobiLab. All rights reserved.
//

import UIKit

class AlbumListViewController: UIViewController {
    var albumNumber: Int = 0
    @IBAction func album1(_ sender: Any) {
        albumNumber = 0
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let galleryViewController = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        galleryViewController.albumNumber = albumNumber
        self.navigationController?.pushViewController(galleryViewController, animated: true)
    }
    @IBAction func album2(_ sender: Any) {
        albumNumber =  1
        let storyboard_2 = UIStoryboard(name: "Main", bundle: nil)
        let galleryViewController_2 = storyboard_2.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        galleryViewController_2.albumNumber = albumNumber
        self.navigationController?.pushViewController(galleryViewController_2, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func changeAlbum()->Int{
        
        return albumNumber
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
