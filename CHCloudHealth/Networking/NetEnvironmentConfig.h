//
//  NetEnvironmentConfig.h
//  HYQuan
//
//  Created by fqah on 12/7/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#ifndef NetEnvironmentConfig_h
#define NetEnvironmentConfig_h


//start////************************（注释掉下面的代码 切换为 ”线上接口“ ）*/

#ifdef DEBUG

#define IS_OFFLINE_TEST

#endif
//
/************************////end////




//////////////////////////////////
//#define HOTYQ_API_VERSION @"0302" //// API 版本号
//////////////////////////////////

#ifdef IS_OFFLINE_TEST
#define HOTYQ_JAVA_API @"http://123.57.54.62:8081/healthcloud-core/"

#else
#define HOTYQ_JAVA_API @"http://123.57.54.62:8081/healthcloud-core/"
#endif





#endif /* NetEnvironmentConfig_h */
