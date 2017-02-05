//
//  TrackModel.h
//  MusicSearch
//
//  Created by Yadav, Manish on 2/4/17.
//  Copyright © 2017 Yadav, Manish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackModel : NSObject
@property (nonatomic, strong) NSString *trackName;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic) double trackPrice;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *previewUrl;

-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
