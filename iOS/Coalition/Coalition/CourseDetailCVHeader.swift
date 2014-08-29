//
//  CourseDetailCVCellHeader.swift
//  Coalition
//
//  Created by James Nocentini on 29/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import UIKit

class CourseDetailCVHeader: UICollectionReusableView {
    var textLabel: UILabel!
    
    override init(frame: CGRect) {
        self.textLabel = UILabel(frame: CGRectInset(CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)), 30, 10))
        self.textLabel.backgroundColor = UIColor.clearColor()
        self.textLabel.textColor = UIColor.whiteColor()
        super.init(frame: frame)
        self.addSubview(self.textLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel.text = ""
    }
}
