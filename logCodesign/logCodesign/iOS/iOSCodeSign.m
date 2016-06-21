//
//  iOSCodeSign.m
//  logCodesign
//
//  Created by zhanglei on 16/6/21.
//  Copyright © 2016年 leisuro. All rights reserved.
//

#import "iOSCodeSign.h"

static NSString *bundleTeamIdentifier(void)
{
    NSString *mobileProvisionPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"embedded.mobileprovision"];
    FILE *fp=fopen([mobileProvisionPath UTF8String],"r");
    char ch;
    if(fp==NULL) {
        printf("file cannot be opened/n");
        exit(1);
    }
    NSMutableString *str = [NSMutableString string];
    while((ch=fgetc(fp))!=EOF) {
        [str appendFormat:@"%c",ch];
    }
    fclose(fp);
    
    NSString *teamIdentifier = nil;
    NSRange teamIdentifierRange = [str rangeOfString:@"<key>com.apple.developer.team-identifier</key>"];
    if (teamIdentifierRange.location != NSNotFound) {
        
        NSInteger location = teamIdentifierRange.location + teamIdentifier.length;
        NSInteger length = [str length] - location;
        if (length > 0 && location >= 0) {
            NSString *newStr = [str substringWithRange:NSMakeRange(location, length)];;
            NSArray *val = [newStr componentsSeparatedByString:@"</string>"];
            NSString *v = [val firstObject];
            NSRange startRange = [v rangeOfString:@"<string>"];
            
            NSInteger newLocation = startRange.location + startRange.length;
            NSInteger newLength = [v length] - newLocation;
            if (newLength > 0 && location >= 0) {
                teamIdentifier = [v substringWithRange:NSMakeRange(newLocation, newLength)];
            }
        }
    }
    return teamIdentifier;
}

static CodeSign_t * util = NULL;

@implementation _CodeSign

+(CodeSign_t *)sharedCodeSign
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = malloc(sizeof(CodeSign_t));
        util->bundleTeamIdentifier = bundleTeamIdentifier;
    });
    return util;
}

+ (void)destroy
{
    util ? free(util): 0;
    util = NULL;
}

@end
