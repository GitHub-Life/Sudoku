//
//  SingletonMacro.h
//  NiuYan
//
//  Created by 万涛 on 2018/5/16.
//  Copyright © 2018年 niuyan.com. All rights reserved.
//

#ifndef SingletonMacro_h
#define SingletonMacro_h

#define IM_SINGLETON_INTERFACE(_type_) + (instancetype)shared;\
+(instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));\
+(instancetype) new __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) copy __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));

#define IM_SINGLETON_IMPLEMENTATION(_type_) + (instancetype)shared{\
static _type_ *sharedInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
sharedInstance = [[super alloc] init];\
});\
return sharedInstance;\
}

#endif /* SingletonMacro_h */
