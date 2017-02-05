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
@property (nonatomic) double collectionPrice;
@property (nonatomic, strong) NSString *previewUrl;
@property (nonatomic, strong) NSString *collectionViewUrl;
@property (nonatomic, strong) NSString *trackViewUrl;

-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
