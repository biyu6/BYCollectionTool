//
//  BYIconFlowSwiftVC.swift
//  BYCollectionTool
//
//  Created by biyu6 on 2019/3/11.
//  Copyright © 2019 biyu6. All rights reserved.
//不同高度图片布局的VC——swift

import UIKit
class BYIconFlowSwiftVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubView() // 添加子控件
    }
    //瀑布流的处理
    var homeDataArr: Array<String> = [] // 数据源数组
    var iconImages: Array<UIImage> = [] // 头像
    var collectionView: UICollectionView!
    let layout = BYIconFlowSwiftLayout()
    var maskView: UIView!//遮罩view
    var cellRect: CGRect!
    var changeRect: CGRect!
    var btn:BYEnlargeBtn!
    
    private func initSubView() {//瀑布流
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "newHomeCollectionCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        //赋值
        readDataHomeMenuCollection()
    }
    
    //首页数据赋值及刷新
    @objc private func readDataHomeMenuCollection() {//给瀑布流赋值
        iconImages = []
        //获取数据库中的所有数据
        for i in 0..<17 {
            let str = "img_\(i)"
            homeDataArr.append(str)
            let img = UIImage(named: str)!
            iconImages.append(img)
        }
        layout.setSize = {//给瀑布流赋值
            return self.iconImages
        }
        collectionView.reloadData()
    }
    
    //放大图片
    @objc func showPic(btn:UIButton){
        UIView.animate(withDuration: 1, animations: {
            btn.frame = self.cellRect
        }) { (finish) in
            btn.removeFromSuperview()
            self.maskView.removeFromSuperview()
            self.maskView = nil
            self.cellRect = nil
        }
    }
}

extension BYIconFlowSwiftVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {//多少个item
        return homeDataArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {//每个item的内容
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newHomeCollectionCell", for: indexPath as IndexPath)
        //图片
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:cell.bounds.size.width, height: cell.bounds.size.height - 25)) //cell.bounds
        //赋值
        let imgStr = homeDataArr[indexPath.row]
        imageView.image = UIImage(named: imgStr)!
        cell.backgroundView = imageView
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {//点击item
        let cell = collectionView.cellForItem(at: indexPath)
        //cell在veiw的位置
        cellRect = cell!.convert(cell!.bounds, to: view)
        callHomePhoneNum(row: indexPath.row)
    }
    //放大并拨打首页的电话
    func callHomePhoneNum(row: NSInteger){
        maskView = UIView.init(frame: view.bounds)
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.5
        view.addSubview(maskView)
        //添加手势
        //        maskView.addGestureRecognizer(UIPanGestureRecognizer.init(target: self, action: #selector(handleSwipe(swipe:))))
        
        btn = BYEnlargeBtn.init(frame: cellRect)
        let img = iconImages[row]
        btn.wImage = img
        btn.addTarget(self, action: #selector(showPic(btn:)), for: UIControl.Event.touchUpInside)
        view.addSubview(btn)
        //图片长宽的比例与屏幕长宽的比例的对比
        var changeH:CGFloat
        var changeW:CGFloat
        if img.size.width/img.size.height >= view.frame.size.width/view.frame.size.height{
            //对比图片实际宽与屏幕宽
            if img.size.width>view.frame.size.width {
                changeH = img.size.height*view.frame.size.width/img.size.width
                changeRect = CGRect(x: 0, y: (view.frame.size.height-changeH)/2, width:view.frame.size.width, height: changeH)
            }else{
                changeRect = CGRect(x: (view.frame.size.width-img.size.width)/2, y: (view.frame.size.height-img.size.height)/2, width: img.size.width,height: img.size.height)
            }
        }else{
            if img.size.height>view.frame.size.height {
                changeW = img.size.width*view.frame.size.height/img.size.height
                changeRect = CGRect(x: (view.frame.size.width-changeW)/2, y: 0, width: changeW, height: view.frame.size.height)
            }else{
                changeRect = CGRect(x: (view.frame.size.width-img.size.width)/2, y: (view.frame.size.height-img.size.height)/2, width: img.size.width,height: img.size.height)
            }
        }
        UIView.animate(withDuration: 1, animations: {
            self.btn.frame = self.changeRect
        })
    }
}
