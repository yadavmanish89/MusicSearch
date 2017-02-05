//
//  DetailViewController.m
//  MusicSearch
//
//  Created by Yadav, Manish on 2/5/17.
//  Copyright © 2017 Yadav, Manish. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *longDescription;
@property (strong, nonatomic) IBOutlet UILabel *trackPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *collectionPriceLabel;
@property (strong, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.playButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self setScreenTitle];
    [self populateData];
}

-(void)setScreenTitle{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
    [titleLabel setText:@"Details"];
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:17]];
    [titleLabel setTextColor:[UIColor grayColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = titleLabel;
}

-(void)populateData{
    [self.longDescription setText:[NSString stringWithFormat:@"%@\n%@",self.data.trackName,self.data.artistName]];
    [self.trackPriceLabel setText:[NSString stringWithFormat:@"%0.2f",self.data.trackPrice]];
    [self.collectionPriceLabel setText:[NSString stringWithFormat:@"%0.2f",self.data.collectionPrice]];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)trackViewButtonAction:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:self.data.trackViewUrl];
    [[UIApplication sharedApplication]openURL:url options:@{UIApplicationLaunchOptionsURLKey:@1} completionHandler:nil];
}

- (IBAction)collectionViewButtonAction:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:self.data.collectionViewUrl];
    [[UIApplication sharedApplication]openURL:url options:@{UIApplicationLaunchOptionsURLKey:@1} completionHandler:nil];
}
- (IBAction)playButtonAction:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:self.data.previewUrl];
    [[UIApplication sharedApplication]openURL:url options:@{UIApplicationLaunchOptionsURLKey:@1} completionHandler:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
