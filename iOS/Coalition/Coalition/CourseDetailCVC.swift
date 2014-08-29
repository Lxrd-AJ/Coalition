//
//  CourseDetailCVC.swift
//  Coalition
//
//  Created by James Nocentini on 29/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import UIKit

let CourseCellIdentifier = "CourseCellId"
let HeaderCellIdentifier = "HeaderId"

class CourseDetailCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var model: Model!
    var selectedModel: Int!
    var segmentedControl: UISegmentedControl!
    var collectionViewChapters: UICollectionView!
    var collectionViewChallenges: UICollectionView!
    
    override func loadView() {
        super.loadView()
        
        self.navigationItem.title = "Chapters"
        
        segmentedControl = UISegmentedControl(items: ["Chapters", "Challenges"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "segmentedControlChanged", forControlEvents: UIControlEvents.ValueChanged)
        self.navigationItem.titleView = segmentedControl
        
        //Here we need to create a new collectionview and set it to self.collectionView
        let flowLayoutChallenges = UICollectionViewFlowLayout()
        flowLayoutChallenges.itemSize = CGSizeMake(100, 100)
        //            flowLayoutChallenges.headerReferenceSize = CGSizeMake(60, 80);
        flowLayoutChallenges.minimumInteritemSpacing = 10.0;
        flowLayoutChallenges.minimumLineSpacing = 10.0;
        
        let collectionViewRectChallenges = CGRect(x: 0, y: 60, width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: CGRectGetHeight(UIScreen.mainScreen().bounds))
        let collectionViewChallenges = UICollectionView(frame: collectionViewRectChallenges, collectionViewLayout: flowLayoutChallenges)
        collectionViewChallenges.dataSource = self
        collectionViewChallenges.delegate = self
        
        
        // Setup our flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(120, 120)
        flowLayout.headerReferenceSize = CGSizeMake(60, 80);
        flowLayout.minimumInteritemSpacing = 10.0;
        flowLayout.minimumLineSpacing = 10.0;
        
        let collectionViewRect: CGRect = CGRect(x: 0, y: 60, width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: CGRectGetHeight(UIScreen.mainScreen().bounds))
        collectionViewChapters = UICollectionView(frame: collectionViewRect, collectionViewLayout: flowLayout)
        collectionViewChapters.dataSource = self
        collectionViewChapters.delegate = self
        
        collectionViewChapters.registerClass(CourseDetailCVCell.self, forCellWithReuseIdentifier: CourseCellIdentifier)
        collectionViewChapters.registerClass(CourseDetailCVHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderCellIdentifier)
        
        self.collectionView = collectionViewChapters
    }
    
    func segmentedControlChanged() {
        
        if(self.segmentedControl.selectedSegmentIndex == 1) {
            
            self.collectionView = collectionViewChallenges
            
        } else {
            
            
            
            self.collectionView = collectionViewChapters
            
        }
        
        
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        
        if(self.segmentedControl.selectedSegmentIndex == 1) {
            return UICollectionViewCell()
        } else {
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(CourseCellIdentifier, forIndexPath: indexPath) as CourseDetailCVCell
            cell.bounds = CGRectMake(0, 0, 120, 120)
            cell.backgroundColor = UIColor.whiteColor()
            var contents = self.model.courses.objectAtIndex(self.selectedModel).chapters!.objectAtIndex(indexPath.section).contents as NSMutableArray
            cell.thumbnail.image = contents.objectAtIndex(indexPath.item).thumbnail
            
            return cell as UICollectionViewCell
        }
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        
        if(self.segmentedControl.selectedSegmentIndex == 1) {
            return 0
        } else {
            return self.model.courses.objectAtIndex(self.selectedModel).chapters!.count
        }
        
    }
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        if(self.segmentedControl.selectedSegmentIndex == 1) {
            return 0
        } else {
            var contents = self.model.courses.objectAtIndex(self.selectedModel).chapters!.objectAtIndex(section).contents as NSMutableArray
            return contents.count
        }
    }
    
    
    override func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        var vvc = VideoViewController()
        var contents = self.model.courses.objectAtIndex(self.selectedModel).chapters!.objectAtIndex(indexPath.section).contents as NSMutableArray
        vvc.content = contents.objectAtIndex(indexPath.item) as Content
        self.navigationController.pushViewController(vvc, animated: true)
    }
    
    override func collectionView(collectionView: UICollectionView!, viewForSupplementaryElementOfKind kind: String!, atIndexPath indexPath: NSIndexPath!) -> UICollectionReusableView! {
        if(self.segmentedControl.selectedSegmentIndex == 1) {
            return UICollectionViewCell()
        } else {
            var cell = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderCellIdentifier, forIndexPath: indexPath) as CourseDetailCVHeader
            cell.textLabel.text = self.model.courses.objectAtIndex(self.selectedModel).chapters!.objectAtIndex(indexPath.section).name
            return cell
        }
        
    }
    
    
}