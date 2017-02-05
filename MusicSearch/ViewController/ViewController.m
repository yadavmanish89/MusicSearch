//
//  ViewController.m
//  MusicSearch
//
//  Created by Yadav, Manish on 2/4/17.
//  Copyright © 2017 Yadav, Manish. All rights reserved.
//

#import "ViewController.h"
#import "TrackTableViewCell.h"
#import "APIManager.h"

#define MIN_CHAR 3
#define TRACK_CELL_IDENTIFIER @"TrackCell"
#define LAST_SEARCH_KEY @"lastSearch"
@interface ViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLastSearch];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)loadLastSearch{
    NSString *lastSearch = [[NSUserDefaults standardUserDefaults] objectForKey:@"last"];
    if(!lastSearch){
        lastSearch = @"ABC";
    }
    [self getSongDataForText:lastSearch];
}

#pragma mark SearchBar Delegate
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    [window setBackgroundColor:[UIColor redColor]];

    NSCharacterSet *alphaNumericSet = [NSCharacterSet alphanumericCharacterSet];
    if([text rangeOfCharacterFromSet:alphaNumericSet].location != NSNotFound || [text isEqualToString:@""]){
        return YES;
    }
    NSString *lastCharStr = [searchBar.text substringWithRange:NSMakeRange(range.location-1, 1)];
    if([text isEqualToString:@" "] && ![lastCharStr isEqualToString:@" "]){
        return YES;
    }
    return NO;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchBar.text.length>MIN_CHAR-1){
        [self getSongDataForText:searchBar.text];
    }
}

#pragma mark API Call
-(void)getSongDataForText:(NSString*)searchText{
    APIManager *manager = [APIManager new];
    [manager getDataFromURL:URL_SEARCH withParameters:@{@"search":searchText} completionBlock:^(id response) {
        if([response isKindOfClass:[NSError class]]){
            [self showAlert];
        }
        else{
            NSError *error;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:response options: NSJSONReadingAllowFragments error:&error];
            if([Utility isValidDictionary:responseDict]){
                NSInteger resultCount = [[responseDict objectForKey:@"resultCount"] integerValue];
                if(resultCount){
                    NSArray *results = [responseDict objectForKey:@"results"];
                    [self parseResponseWithArray:results];
                    [self.tableView reloadData];
                    [[NSUserDefaults standardUserDefaults] setObject:self.searchBar.text forKey:LAST_SEARCH_KEY];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                else{
                   // [self showAlert];
                }
            }
        }
    }];
}

-(void)parseResponseWithArray:(NSArray*)response{
    self.dataSource = nil;
    self.dataSource = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in response) {
        TrackModel *model = [[TrackModel alloc]initWithDictionary:dict];
        [self.dataSource addObject:model];
    }
}

-(void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please Try Again" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert removeFromParentViewController];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TrackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TRACK_CELL_IDENTIFIER];
    cell.data = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
