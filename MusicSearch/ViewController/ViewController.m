//
//  ViewController.m
//  MusicSearch
//
//  Created by Yadav, Manish on 2/4/17.
//  Copyright © 2017 Yadav, Manish. All rights reserved.
//

#import "ViewController.h"
#import "SongTableViewCell.h"
#import "APIManager.h"

#define MIN_CHAR 3
@interface ViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchBar.text.length>MIN_CHAR-1){
        [self getSongDataForText:searchBar.text];
    }
}

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
                if(resultCount == 0){
                    [self showAlert];
                }
            }
        }
    }];
}

-(void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please Try Again" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert removeFromParentViewController];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songCell"];
    [cell.artistLabel setText:@"hi"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
