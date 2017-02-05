//
//  TrackTableViewCell.m
//  MusicSearch
//
//  Created by Yadav, Manish on 2/4/17.
//  Copyright © 2017 Yadav, Manish. All rights reserved.
//

#import "TrackTableViewCell.h"
@interface TrackTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *trackLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;

@end
@implementation TrackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(TrackModel *)data{
    _data = data;
    [self.trackLabel setText:data.trackName];
    [self.artistLabel setText:data.artistName];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:data.artworkUrl]];
        UIImage *image = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.logoImageView setImage:image];
        });
    });
}

- (IBAction)previewButtonAction:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:self.data.previewUrl];
    [[UIApplication sharedApplication]openURL:url options:@{UIApplicationLaunchOptionsURLKey:@1} completionHandler:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
