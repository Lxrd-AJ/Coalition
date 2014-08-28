//
//  CoursesCollectionViewController.swift
//  Coalition
//
//  Created by James Nocentini on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import UIKit

class CoursesCollectionViewController: UICollectionViewController, UICollectionViewDelegate {
    
    override func loadView() {
        super.loadView()
        
        self.navigationItem.title = "Courses"
        
        // Setup our flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(120, 120)
        
        let collectionViewRect: CGRect = UIScreen().bounds
        let collectionView = UICollectionView(frame: collectionViewRect, collectionViewLayout: flowLayout)
        
        self.collectionView = collectionView
        
    }
    
}