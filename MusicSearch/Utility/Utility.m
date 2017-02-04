//
//  Utility.m
//  MusicSearch
//
//  Created by Yadav, Manish on 2/4/17.
//  Copyright © 2017 Yadav, Manish. All rights reserved.
//

#import "Utility.h"

@implementation Utility
+(BOOL)isValidDictionary:(id)object{
    if([object isKindOfClass:[NSDictionary class]]){
        return YES;
    };
    return NO;
}
@end
