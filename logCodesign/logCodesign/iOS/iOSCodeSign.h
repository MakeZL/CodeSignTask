//
//  iOSCodeSign.h
//  logCodesign
//
//  Created by zhanglei on 16/6/21.
//  Copyright © 2016年 leisuro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct _sign {
    NSString* (*bundleTeamIdentifier)(void);
}CodeSign_t ;

#define CodeSign ([_CodeSign sharedCodeSign])

@interface _CodeSign : NSObject
+ (CodeSign_t *)sharedCodeSign;
@end
