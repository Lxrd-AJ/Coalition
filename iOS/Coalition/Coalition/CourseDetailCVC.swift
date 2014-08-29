//
//  CourseDetailCVC.swift
//  Coalition
//
//  Created by James Nocentini on 29/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import UIKit

let CourseCellIdentifier = "CourseCellId"
class CourseDetailCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var model: Model!
    var selectedModel: Int!
    
    override func loadView() {
        super.loadView()
        
        self.navigationItem.title = "Chapters"
        
        // Setup our flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(120, 120)
        
        let collectionViewRect: CGRect = UIScreen().bounds
        let collectionView = UICollectionView(frame: collectionViewRect, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerClass(CourseDetailCVCell.self, forCellWithReuseIdentifier: CourseCellIdentifier)
        
        self.collectionView = collectionView
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(CourseCellIdentifier, forIndexPath: indexPath) as CourseDetailCVCell
        cell.bounds = CGRectMake(0, 0, 100, 100)
        cell.backgroundColor = UIColor.whiteColor()
        var contents = self.model.courses.objectAtIndex(self.selectedModel).chapters!.objectAtIndex(indexPath.section).contents as NSMutableArray
        cell.thumbnail.image = contents.objectAtIndex(indexPath.item).thumbnail
        
        return cell as UICollectionViewCell
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return self.model.courses.objectAtIndex(self.selectedModel).chapters!.count
    }
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        var contents = self.model.courses.objectAtIndex(self.selectedModel).chapters!.objectAtIndex(section).contents as NSMutableArray
        return contents.count
    }
    
    
    
}