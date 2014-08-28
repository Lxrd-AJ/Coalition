//
//  CoursesCVCell.swift
//  Coalition
//
//  Created by James Nocentini on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import UIKit

class CoursesCollectionViewCell: UICollectionViewCell {
    var thumbnail: UIImageView
    
    override init(frame: CGRect) {
        self.thumbnail = UIImageView(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(frame), height: CGRectGetHeight(frame)))
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnail = UIImageView(frame: CGRectZero)
    }
    
}
