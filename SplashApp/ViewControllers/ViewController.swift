//
//  ViewController.swift
//  SplashApp
//
//  Created by Baya Walid on 03/10/2022.
//

import UIKit
import SDWebImage
import IHProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var photos : [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        tableView.rowHeight = 120
        searchBar.delegate = self
    }

    func getDataFrom(key: String?) {
        if let query = key {
            IHProgressHUD.show()
            WebService().searchFor(query: query) { PhotosModel in
                DispatchQueue.main.async {
                    self.photos = PhotosModel?.results ?? []
                    self.tableView.reloadData()
                    IHProgressHUD.dismiss()
                }
            }
        } else {
            self.photos = []
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        getDataFrom(key: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.titleLabel?.text = photos[indexPath.row].description ?? "_"
        cell.imgView.sd_setImage(with: URL(string: photos[indexPath.row].urls?.raw ?? ""), completed: nil)
        cell.descLabel.text = photos[indexPath.row].alt_description ?? "_"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let pict = photos[indexPath.row].urls?.small {
            let mainStory = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainStory.instantiateViewController(withIdentifier: "FullScreenViewController") as! FullScreenViewController
            vc.picUrl = pict
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
}
