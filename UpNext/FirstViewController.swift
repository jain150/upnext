//
//  FirstViewController.swift
//  UpNext
//
//  Created by Shivan Desai on 3/23/17.
//  Copyright © 2017 Shivan Desai. All rights reserved.
//

import UIKit
import Alamofire

struct post{
    let mainImage : UIImage!
    let name : String!
    let artistName : String!
}


class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var mySearchBar: UISearchBar!
    
    var searchURL = String()
    
    var posts = [post]()
//    var allImages = [UIImage]()
  //  var names = [String]()
    //var artistsArray = [String]()
    
    typealias JSONStandard = [String : AnyObject]
    
    @IBOutlet weak var tableView: UITableView!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        posts.removeAll()
        let keywords = mySearchBar.text
        let finalKeywords = keywords?.replacingOccurrences(of: " ", with: "+")
        searchURL = "https://api.spotify.com/v1/search?q=\(finalKeywords!)&market=US&type=track"
        callAlamo(url: searchURL)
        self.view.endEditing(true)
        self.tableView.reloadData()
        
    }

/*    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        posts.removeAll()
        let keywords = searchText
        let finalKeywords = keywords.replacingOccurrences(of: " ", with: "+")
        searchURL = "https://api.spotify.com/v1/search?q=\(finalKeywords)&market=US&type=track"
        callAlamo(url: searchURL)
        self.view.endEditing(true)
        self.tableView.reloadData()
    }
*/
    override func viewDidLoad() {
        
        //NavBar color, matched to icon color
        navigationController?.navigationBar.barTintColor = UIColor(red:131/255, green: 185/255 , blue: 37/255, alpha: 1)
        //NavBar title color
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        super.viewDidLoad()
        
        
        tableView.separatorColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        cell.Song.text = posts[indexPath.row].name
        cell.Description.text = posts[indexPath.row].artistName
        cell.CoverImage.image = posts[indexPath.row].mainImage
        
        
        return cell
    }
    
    func callAlamo(url: String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.ParseData(JSONData: response.data!)
            
        })
    }
    
    func ParseData(JSONData : Data){
        do{
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let tracks = readableJSON["tracks"] as? JSONStandard{
                if let items = tracks["items"] as? [JSONStandard]{
                    for i in 0..<items.count{
                        var artist : String
                        let item = items[i] 
                        let name = item["name"] as! String
//names.append(name)
                        let artists = item["artists"] as? [JSONStandard]
                        let artist1 = (artists?[0])! as JSONStandard
                        artist = artist1["name"] as! String
//artistsArray.append(artist)
                        
                        if let album = item["album"] as? JSONStandard{
                            if let images = album["images"] as? [JSONStandard]{
                                let imageData = images[0]
                                let mainImageURL = URL(string: imageData["url"] as! String)
                                let mainImageData = NSData(contentsOf: mainImageURL!)
                                let mainImage = UIImage(data: mainImageData as! Data)
//allImages.append(mainImage!)
                                posts.append(post.init(mainImage: mainImage, name: name, artistName: artist))
                                self.tableView.reloadData()
                            }
                        }
                    
//self.tableView.reloadData()
                    }
                }
            }
            print(readableJSON)
        }
        catch{
            print(error)
        }
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
