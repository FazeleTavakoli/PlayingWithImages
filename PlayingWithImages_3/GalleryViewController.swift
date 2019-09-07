//
//  ViewController.swift
//  PlayingWithImages_3
//
//  Created by mblb on 19.08.19.
//  Copyright © 2019 MobiLab. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    var albumNumber:Int = 0
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var flowersLabels: [String] = ["flower 1", "flower 2", "flower 3"]
//    var flowerImages: [UIImage] = [
//        UIImage(named: "img1")!,
//        UIImage(named: "img2")!,
//        UIImage(named: "img3")!,
//    ]
    
//        var flowerImages: [String] = [
//            "/Users/mblb/Desktop/mobilab/mobilabGitRepo/PlayingWithImages_3/PlayingWithImages_3/Assets.xcassets/img1.imageset/img1.png",
//            "/Users/mblb/Desktop/mobilab/mobilabGitRepo/PlayingWithImages_3/PlayingWithImages_3/Assets.xcassets/img2.imageset/img2.png",
//            "/Users/mblb/Desktop/mobilab/mobilabGitRepo/PlayingWithImages_3/PlayingWithImages_3/Assets.xcassets/img3.imageset/img3.png",
//            ]
    
    var imgurImages: [String] = []
    
            
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        loadImages()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
//        return flowersLabels.count
        return imgurImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let myCell: MyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
        let imageSring = self.imgurImages[indexPath.row]
        myCell.myImageView.imageFromServerURL(imageSring, placeHolder: nil)
//        myCell.myImageLabel
        
        return myCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("user tapped on # \(indexPath.row)")
        let myImageViewPage: MyImageViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyImageViewController") as! MyImageViewController
        
        myImageViewPage.selectedImage = self.imgurImages[indexPath.row]
    self.navigationController?.pushViewController(myImageViewPage, animated: true)
    }
    
    func loadImages(){
//        var albumList: AlbumListViewController?
//        var query = albumList?.changeAlbum()
        guard let imageURL = URL(string: "https://api.imgur.com/3/gallery/hot/viral/\(albumNumber)") else{return}
        
        var request = URLRequest(url: imageURL)
        request.setValue("Client-ID 959fb0d50bacbdc", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                
                if let jsonDictionary = try! JSONSerialization.jsonObject(with: data) as? [String:Any] {
                print("dataString \(jsonDictionary)")
                
                let galleryImages = try! JSONDecoder().decode(GalleryData.self, from: data)
                    
                    let filteredImages = galleryImages.data.filter({ !$0.isAlbum })
                    
                self.imgurImages = filteredImages.flatMap({ $0.link })
                    
                    //I added recently for checking whether description is null or not


//                    if (filteredImages.filter({$0.description}) is String){
                    
                    
                        self.imgurImages = filteredImages.filter({return $0.description != nil})
                    
//                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
        task.resume()
    }
}

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(error)")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}

