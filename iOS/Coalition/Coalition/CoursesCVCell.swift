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
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        self.thumbnail = UIImageView(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(frame), height: CGRectGetHeight(frame) - 50))
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: CGRectGetHeight(frame) - 50, width: CGRectGetWidth(frame), height: 50))
        self.titleLabel.frame.inset(dx: 10.0, dy: 10.0)
        super.init(frame: frame)
        self.addSubview(self.thumbnail)
        self.addSubview(self.titleLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnail = UIImageView(frame: CGRectZero)
    }
    
}
