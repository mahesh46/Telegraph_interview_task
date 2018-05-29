//
//  ViewController.swift
//  Telegraph_Test
//
//  Created by Administrator on 05/04/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var articles: [CollectionViewModel] =  (UIApplication.shared.delegate as! AppDelegate).articles
    @IBOutlet weak var tableView: UITableView!
        let  imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishDownloading), name: Notification.Name("didFinishDownloading"), object: nil)
        
        let nib = UINib(nibName: "ArticleCell", bundle: nil);
        tableView.register(nib, forCellReuseIdentifier: "ArticleCell")
        self.tableView.delegate = self
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //    let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
      
        let articleViewModel = articles[indexPath.row]
        cell.tag = indexPath.row
        print(indexPath.row)
        
        cell.headlineLabel.text = articleViewModel.headline
        cell.descriptionLabel.text = articleViewModel.description
        cell.synopsisTextView.text = articleViewModel.synopsis
        cell.imageView?.image = UIImage()
              if let url = URL(string: articleViewModel.pictureUrl! ) {
                
                if let image =    self.imageCache.object(forKey:  url as AnyObject  )  as? UIImage {
              cell.pictureImageView?.image = image
          }  else {
  
        
        DispatchQueue.global().async {
            guard  let data = try? Data(contentsOf: url) else {return}
             let image =   UIImage(data: data)
            self.imageCache.setObject(image!, forKey: url as AnyObject )

            DispatchQueue.main.async {
                cell.pictureImageView?.image = image
               }
            
           }
            }
        } else {
            cell.pictureImageView?.image  = UIImage()
        }
        
        
        cell.actorsLabel.text =  "Actors:" + listWithCommaSeparation(list: articleViewModel.actors!)
        cell.ratingLabel.text =  "Rating:\n \(articleViewModel.ratings!)"
        cell.releaseDateLabel.text = "Released \n" + articleViewModel.releaseDate!
        cell.durationLabel.text =  "Duration: \n" + articleViewModel.duration!
        cell.genreLabel.text =  "Genre:\n" + listWithCommaSeparation(list: articleViewModel.genre!)
        
        let author = articleViewModel.author
        cell.twitterLabel.text = "Twitter: " + (author?.twitter)!
        cell.nameLabel.text = "Author: " +  (author?.name)!
        
        cell.headShotImage.layer.cornerRadius = 25
        cell.headShotImage.layer.masksToBounds = true
        if let url = URL(string: (author?.headshot)! ) {
                 if let image =    self.imageCache.object(forKey:  url as AnyObject  )  as? UIImage {
           cell.headShotImage?.image
                 } else {
               
                    DispatchQueue.global().async {
                        guard     let data = try? Data(contentsOf: url)  else {return}
                        let image =   UIImage(data: data)
                        self.imageCache.setObject(image!, forKey: url as AnyObject )
                        DispatchQueue.main.async {
                            cell.headShotImage?.image = image
                        }
                        
                    }
                    
            }
       
            
            
        } else {
             cell.headShotImage?.image  = UIImage()
        }
        
        return cell
    }

    func listWithCommaSeparation( list : [String]) -> String {
    
        let comma = ", "
        var  newList  = ""
        for item in list {
            newList += ( item + comma)
        }
     
        var truncated  =  String(newList[..<newList.index(newList.endIndex, offsetBy: -2)]) + "."
        return truncated
    }
    
    @objc func didFinishDownloading(_ sender: NSNotification) {
         articles =  (UIApplication.shared.delegate as! AppDelegate).articles
        self.tableView.reloadData()
        print(articles.count)
    }

}

