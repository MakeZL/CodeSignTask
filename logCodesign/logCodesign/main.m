//
//  main.m
//  logCodesign
//
//  Created by zhanglei on 16/6/20.
//  Copyright © 2016年 leisuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodeSignTask.h"
#import "iOSCodeSign.h"

void checkVerifySign(const char *path, const char *argv)
{
    
    NSString * output = nil;
    NSString * processErrorDescription = nil;
    
    CodeSignTask *task = [[CodeSignTask alloc] init];

    BOOL success = [task runProcessAsAdministrator:@"/usr/bin/xcrun" withArguments:@[@"codesign",@"-v",[NSString stringWithUTF8String:argv]] output:&output errorDescription:&processErrorDescription];
    
    if (!success) // Process failed to run
    {
        // ...process output
        NSLog(@"\n **** This is a not complete executable signature file **** \n");
    }
    else
    {
        NSLog(@"\n **** This is a complete executable signature file **** \n");
    }
}

void lookSignAppForPath(const char *path, const char *argv)
{
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/xcrun";
    task.currentDirectoryPath = @".";
    task.arguments = @[@"codesign",@"-vv",@"-d",[NSString stringWithUTF8String:argv]];
    [task launch];
    sleep(1.0);
    NSLog(@" \n ********** === done === ********** \n");
}

int main(int argc, const char * argv[])
{
    if (argv[1] == NULL) {
        NSLog(@"Invalid No App");
        return 0;
    }
    
    if (strlen(argv[1]) == 0)
    {
        NSLog(@"\n **** logCodesign : Invalid path for app execute. **** \n");
        return 0;
    }
    
    NSLog(@"\n **** prepare reading app: [%s] **** \n", argv[1]);
    checkVerifySign(argv[0],argv[1]);
    lookSignAppForPath(argv[0],argv[1]);
    
    // iOS
    CodeSign->bundleTeamIdentifier();
    
    return 0;
}
