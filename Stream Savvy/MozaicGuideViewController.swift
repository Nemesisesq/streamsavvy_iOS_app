//
//  MozaicGuide.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/24/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import ADMozaicCollectionViewLayout

enum ADMozaikLayoutType {
        case portrait
        case landscape
}

class MozaicCollectionViewController: UIViewController, ADMozaikLayoutDelegate, UICollectionViewDataSource {
        
        let columnWidth = UIScreen.main.bounds.size.width / 4
        
        @IBOutlet var mozCollectionView: UICollectionView!
        
        
        fileprivate let ADMozaikCollectionViewLayoutExampleImagesCount = 22

        fileprivate var portraitLayout: ADMozaikLayout {
                let columns = [ADMozaikLayoutColumn(width: columnWidth), ADMozaikLayoutColumn(width: columnWidth), ADMozaikLayoutColumn(width: columnWidth),ADMozaikLayoutColumn(width: columnWidth)]
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
        
//        @IBOutlet var collectionView: UICollectionView!
        
        override func viewDidLoad() {
                super.viewDidLoad()
        }
        
        override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                
                self.setCollectionViewLayout(false, ofType: UIScreen.main.bounds.width > UIScreen.main.bounds.height ? .landscape : .portrait)
        }
        
        //MARK: - Helpers
        
        fileprivate func setCollectionViewLayout(_ animated: Bool, ofType type: ADMozaikLayoutType) {
                self.mozCollectionView?.collectionViewLayout.invalidateLayout()
                if type == .landscape {
                        self.mozCollectionView?.setCollectionViewLayout(self.landscapeLayout, animated: true)
                }
                else {
                        self.mozCollectionView?.setCollectionViewLayout(self.portraitLayout, animated: true)
                }
        }
        
        //MARK: - ADMozaikLayoutDelegate
        
        func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, mozaikSizeForItemAtIndexPath indexPath: IndexPath) -> ADMozaikLayoutSize {
                if indexPath.item == 0 {
                        return ADMozaikLayoutSize(numberOfColumns: 1, numberOfRows: 1)
                }
                if indexPath.item % 10 == 0 {
                        return ADMozaikLayoutSize(numberOfColumns: 4, numberOfRows: 1)
                }
                if indexPath.item % 8 == 0 {
                        return ADMozaikLayoutSize(numberOfColumns: 3, numberOfRows: 1)
                }
                else if indexPath.item % 6 == 0 {
                        return ADMozaikLayoutSize(numberOfColumns: 2, numberOfRows: 1)
                }
                else if indexPath.item % 4 == 0 {
                        return ADMozaikLayoutSize(numberOfColumns: 1, numberOfRows: 3)
                }
                else {
                        return ADMozaikLayoutSize(numberOfColumns: 1, numberOfRows: 1)
                }
        }
        
        //MARK: - UICollectionViewDataSource
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
                return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return 10000
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ADMozaikLayoutCell", for: indexPath) as! GuideCollectionViewCell
                cell.imgView.image = #imageLiteral(resourceName: "marks_favicon")
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
