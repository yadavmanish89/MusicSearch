//
//  DetailViewController.h
//  MusicSearch
//
//  Created by Yadav, Manish on 2/5/17.
//  Copyright © 2017 Yadav, Manish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackModel.h"

@interface DetailViewController : UIViewController
@property (nonatomic, strong) TrackModel *data;
@end
