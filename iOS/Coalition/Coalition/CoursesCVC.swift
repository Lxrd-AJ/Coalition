//
//  CoursesCollectionViewController.swift
//  Coalition
//
//  Created by James Nocentini on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import UIKit

let CellIdentifier: String = "CellIdentifier"

class CoursesCollectionViewController: UICollectionViewController, UICollectionViewDelegate {
    var model: Model!
    
    override func loadView() {
        super.loadView()
        
        self.navigationItem.title = "Courses"
        
        // Setup our flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen().bounds) / 2 - 5, CGRectGetWidth(UIScreen.mainScreen().bounds) * 0.4)
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.minimumLineSpacing = 10.0;
        
        let collectionViewRect: CGRect = UIScreen().bounds
        let collectionView = UICollectionView(frame: collectionViewRect, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerClass(CoursesCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier)
        
        self.collectionView = collectionView
        
        
        
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier, forIndexPath: indexPath) as CoursesCollectionViewCell
//        cell.bounds = CGRectMake(0, 0, , 100)
        cell.backgroundColor = UIColor.whiteColor()
        var contents = self.model.courses.objectAtIndex(indexPath.item).chapters!.objectAtIndex(0).contents as NSMutableArray
        cell.thumbnail.image = contents.objectAtIndex(0).thumbnail
        cell.titleLabel.text = self.model.courses.objectAtIndex(indexPath.item).name
        
        return cell as UICollectionViewCell
        
    }
    
    override func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        var courseDetailCVC = CourseDetailCVC(collectionViewLayout: UICollectionViewFlowLayout())
        courseDetailCVC.model = self.model
        courseDetailCVC.selectedModel = indexPath.item
        
        self.navigationController.pushViewController(courseDetailCVC, animated: true)
}
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return self.model.courses.count
    }
    
}