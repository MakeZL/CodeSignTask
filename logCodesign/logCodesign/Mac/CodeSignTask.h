//
//  CodeSignTask.h
//  logCodesign
//
//  Created by zhanglei on 16/6/20.
//  Copyright © 2016年 leisuro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeSignTask : NSObject

- (BOOL)runProcessAsAdministrator:(NSString*)scriptPath
                     withArguments:(NSArray *)arguments
                            output:(NSString **)output
                  errorDescription:(NSString **)errorDescription;

@end
