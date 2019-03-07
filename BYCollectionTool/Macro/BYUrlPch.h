//
//  BYUrlPch.h
//  WallMeet
//
//  Created by 胡忠诚 on 2018/11/26.
//  Copyright © 2018 huaerjie. All rights reserved.
//Url的pch

#ifndef BYUrlPch_h
#define BYUrlPch_h

//======================================开发环境=========================================================
//测试环境
//#define MAINURL @"http://192.168.1.113:9090"  //开开本地
//#define MAINURL @"http://192.168.1.178:9087" //姜宽本地
//生产环境
#define MAINURL  @"http://47.104.179.33:9087"

//直播播放的环境
#define LIVEPLAYURL @"rtmp://116.196.87.91:1935/live/VC000051"

//======================================接口名称=========================================================
//公共接口
#define INTNAME_uploadPic @"/carpool/upload/pic" //上传图片



#endif /* BYUrlPch_h */
