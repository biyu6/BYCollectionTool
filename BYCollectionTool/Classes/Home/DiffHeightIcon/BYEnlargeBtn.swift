//
//  BYEnlargeBtn.swift
//  IconPhone
//
//  Created by 胡忠诚 on 2018/9/10.
//  Copyright © 2018年 biyu6. All rights reserved.
//放大图片

import UIKit

class BYEnlargeBtn: UIButton {
    
    var wImage:UIImage!{
        didSet{
            wImageView.image = wImage
        }
    }
    private var wImageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        wImageView = UIImageView(frame:bounds)
        addSubview(wImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        wImageView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("初始化(coder:) 尚未实施")
    }
}
