//
//  CourseDetailCVChallengeCell.swift
//  Coalition
//
//  Created by James Nocentini on 29/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import UIKit

class CourseDetailCVChallengeCell: UICollectionViewCell {
    var textLabel: UILabel
    var videoButton: UIButton
    
    override init(frame: CGRect) {
        self.textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(frame), height: CGRectGetHeight(frame) - 50))
        self.videoButton = UIButton(frame: CGRect(x: 0, y: CGRectGetHeight(self.textLabel.frame), width: CGRectGetWidth(frame), height: 50))
        videoButton.setTitle("hello", forState: UIControlState.Normal)
        super.init(frame: frame)
        self.addSubview(self.textLabel)
        self.addSubview(self.videoButton)
        self.backgroundColor = UIColor.whiteColor()
        self.textLabel.textColor = UIColor.blackColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel.text = ""
    }
    
}