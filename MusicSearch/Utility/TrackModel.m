//
//  TrackModel.m
//  MusicSearch
//
//  Created by Yadav, Manish on 2/4/17.
//  Copyright © 2017 Yadav, Manish. All rights reserved.
//

#import "TrackModel.h"

@implementation TrackModel
-(id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        self.trackName = [Utility replaceNullStringWithNil:[dictionary objectForKey:@"trackName"]];
        self.artistName = [Utility replaceNullStringWithNil:[dictionary objectForKey:@"artistName"]];
        self.trackPrice = [[dictionary objectForKey:@"trackPrice"] doubleValue];
        self.currency = [Utility replaceNullStringWithNil:[dictionary objectForKey:@"currency"]];
        self.previewUrl = [Utility replaceNullStringWithNil:[dictionary objectForKey:@"previewUrl"]];
    }
    return self;
}
@end
