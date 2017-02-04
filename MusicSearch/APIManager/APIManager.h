//
//  APIManager.h
//  MusicSearch
//
//  Created by Yadav, Manish on 2/4/17.
//  Copyright © 2017 Yadav, Manish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject
-(void)getDataFromURL:(NSString*)url withParameters:(NSDictionary*)dictionary completionBlock:(void(^)(id))completion;
    
@end
