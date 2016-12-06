//
//  MozaicGuide.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/24/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import ADMozaicCollectionViewLayout
import PromiseKit
import MarqueeLabel
import Dollar

enum ADMozaikLayoutType {
    case portrait
    case landscape
}

class MozaicCollectionViewController: PopularShowObjectiveCViewController, ADMozaikLayoutDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    var  searchButton: UIBarButtonItem!
    var loginButton: UIBarButtonItem!
    var refreshControl = UIRefreshControl()
    
    //    override var nextPage: String!
    //    override var previous: String!
    
    override var popularShows : [Any]! {
        didSet {
            mozCollectionView.reloadData()
        }
    }
    
    
    
    
    //MARK: - Variables
    
    private var context = 0
    
    let columnWidth = UIScreen.main.bounds.size.width / 3
    
    @IBOutlet var mozCollectionView: UICollectionView!
    
    @IBAction func search(_ sender:UIBarButtonItem) {
        if let x = self.navigationController as? SearchNavigationControllerViewController {
            x.search()
        }
    }
    
    @IBOutlet var scrollView: UIScrollView?
    
    @IBAction func goToLogin(_ sender:UIBarButtonItem) {
        Auth0.resetAll()    
        self.performSegue(withIdentifier: "Login", sender: self)
    }
    
    
    //        lazy var refreshControl: UIRefreshControl = {
    //                let refreshControl = UIRefreshControl()
    //                //                refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    //
    //                return refreshControl
    //        }()
    
    
    
    
    fileprivate let ADMozaikCollectionViewLayoutExampleImagesCount = 22
    
    fileprivate var portraitLayout: ADMozaikLayout {
        let columns = [ADMozaikLayoutColumn(width: columnWidth), ADMozaikLayoutColumn(width: columnWidth), ADMozaikLayoutColumn(width: columnWidth)]
        let layout = ADMozaikLayout(rowHeight: columnWidth, columns: columns)
        layout.delegate = self
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        return layout;
    }
    
    fileprivate var landscapeLayout: ADMozaikLayout {
        let columns = [ADMozaikLayoutColumn(width: 110), ADMozaikLayoutColumn(width: 110), ADMozaikLayoutColumn(width: 111), ADMozaikLayoutColumn(width: 111), ADMozaikLayoutColumn(width: 110), ADMozaikLayoutColumn(width: 110)]
        let layout = ADMozaikLayout(rowHeight: 110, columns: columns)
        layout.delegate = self
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        return layout;
    }
    
    //MARK: - Set Up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth0.calledBySubclass = true
        
        searchButton = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: #selector(self.search(_:)))
        searchButton.tintColor = Constants.streamSavvyRed()
        
        loginButton = UIBarButtonItem.init(title: "Login", style: .plain, target: self, action: #selector(self.goToLogin(_:)))
        loginButton.tintColor = Constants.streamSavvyRed()
        
        self.navigationItem.rightBarButtonItems = [loginButton, searchButton]
        
        scrollView?.delegate = self
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(self.reload), for: UIControlEvents.valueChanged)
        self.refreshControl.tintColor = Constants.streamSavvyRed()  
        self.mozCollectionView?.addSubview(refreshControl)
        
        
        mozCollectionView?.infiniteScrollIndicatorStyle = .white
        
        mozCollectionView.infiniteScrollTriggerOffset = 500
        
        mozCollectionView?.addInfiniteScroll { [weak self] (scrollView) -> Void in
            
            _ = Content.getNextPage(url: (self?.nextPage)!)
                .then { the_json -> Void in
                    
                    self?.nextPage = the_json["next"] as? String
                    self?.previous = the_json["previous"] as? String
                    
                    var indexPaths = [IndexPath]()
                    let index = self?.popularShows.count
                    var s = [PopularShow]()
                    
                    for show in the_json["results"] as! [[AnyHashable:Any]] {
                        let count = index!
                        let indexPath = IndexPath(item: count, section: 0)
                        
                        indexPaths.append(indexPath)
                        s.append(PopularShow.init(attributes: show))
                    }
                    
                    var shuffled = [PopularShow]()
                    
                    for _ in 0...s.count {
                        let randomInt1 = Int(arc4random() % UInt32.init(s.count))
                        let randomInt2 = Int(arc4random() % UInt32.init(s.count))
                        
                        s = s.sorted {_, _ in arc4random() % 2 == 0}
                    
                        
    
                    }
                    
                    self?.mozCollectionView.performBatchUpdates({ () -> Void in
                        self?.popularShows = $.merge((self?.popularShows)!, s)
                        self?.mozCollectionView.insertItems(at: indexPaths)
                    }, completion: { (finished) -> Void in
                        self?.mozCollectionView.finishInfiniteScroll()
                    })
            }
            
        }
        
    }
    
    
    //        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    //                print("The shows have been set!")
    //                self.mozCollectionView.reloadData()
    //                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
    //        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth0.loggedIn {
            self.navigationItem.rightBarButtonItems = []
            self.navigationItem.rightBarButtonItem = searchButton
        }
        
        self.setCollectionViewLayout(false, ofType: UIScreen.main.bounds.width > UIScreen.main.bounds.height ? .landscape : .portrait)
    }
    
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        reload()
        mozCollectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    //MARK: - Helpers
    
    fileprivate func setCollectionViewLayout(_ animated: Bool, ofType type: ADMozaikLayoutType) {
        self.mozCollectionView?.setCollectionViewLayout(self.portraitLayout, animated: false)
    }
    
    //MARK: - ADMozaikLayoutDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, mozaikSizeForItemAtIndexPath indexPath: IndexPath) -> ADMozaikLayoutSize {
        if indexPath.item == 0 {
            return ADMozaikLayoutSize(numberOfColumns: 2, numberOfRows: 2)
        }
            
            
        else if indexPath.item % 3 == 0 {
            return ADMozaikLayoutSize(numberOfColumns: 2, numberOfRows: 1)
            
            
        }
        else if indexPath.item % 2 == 0 {
            return ADMozaikLayoutSize(numberOfColumns: 1, numberOfRows: 3)
        }
            
            
            
        else {
            return ADMozaikLayoutSize(numberOfColumns: 1, numberOfRows: 1)
        }
    }
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! OnDemandCollectionViewCell
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContentDetailViewController") as! ContentDetailViewController
        vc.show = cell.popularShow
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let show = popularShows[indexPath.row] as! PopularShow
        let cell = cell as! OnDemandCollectionViewCell
        cell.imgView.sd_setImage(with: URL(string : show.image_link ))
        cell.titleLable.text = show.title
        cell.popularShow = show
        cell.titleLable.type = .leftRight
        
        
        
        
        
        
        //        Constants.addGradient(for: cell.imgView)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let x = popularShows?.count {
            return x
            
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ADMozaikLayoutCell", for: indexPath) as! OnDemandCollectionViewCell
        
        //        Constants.addGradient(for: cell.imgView)
        
        cell.imgView.layer.sublayers?[0].frame = cell.bounds
        
        return cell
    }
    
    //MARK: - Orientation
    
    //        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    //                super.viewWillTransition(to: size, with: coordinator)
    //                coordinator.animate(alongsideTransition: nil) { context in
    //                        self.setCollectionViewLayout(false, ofType: size.width > size.height ? .landscape : .portrait)
    //                }
    //        }
}
