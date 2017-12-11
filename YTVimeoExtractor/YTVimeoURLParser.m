//
//  YTVimeoURLParser.m
//  YTVimeoExtractor
//
//  Created by Soneé Delano John on 12/2/15.
//  Copyright © 2015 Louis Larpin. All rights reserved.
//

#import "YTVimeoURLParser.h"

@implementation YTVimeoURLParser
- (BOOL)validateVimeoURL:(NSString *)vimeoURL{
    
    NSString *vimeoVideoID;
    
    @try{
        //Get the last part of the '/' which will be the videoID
        
       vimeoVideoID = [[vimeoURL componentsSeparatedByString:@"/"] lastObject];
        
    } @catch (NSException *exception) {
        
        NSLog(@"Caught exception %@", exception);
        
        return NO;
    }
    
    //Check if vimeoVideoID is nil
    if (vimeoVideoID == nil) {
        return NO;
    }
    //If not nil check if it is empty e.g @""
    else if ([vimeoVideoID length] == 0){
        return NO;
    }
    
    //Check if videoID contains only digits
    NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:vimeoVideoID];
    
    if ([_NumericOnly isSupersetOfSet: myStringSet]) {
        
        return YES;
        
    } else{
        // In case of url format: /<video_id>/<video> strip the last part and try again
        NSString* newURL = [vimeoURL stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"/%@", vimeoVideoID] withString:@""];

        return [self validateVimeoURL:newURL];
    }

    return NO;

}

-(NSString *)extractVideoIdentifier:(NSString *)vimeoURL{
    
    __block NSString *vimeoVideoID;
    
    @try{
        //Get the last part of the '/' which will be the videoID
        
        vimeoVideoID = [[vimeoURL componentsSeparatedByString:@"/"] lastObject];
        
    } @catch (NSException *exception) {
        
        NSLog(@"Caught exception %@", exception);
        vimeoVideoID = @"";
        return vimeoVideoID;
    }
    
    //Check if vimeoVideoID is nil
    if (vimeoVideoID == nil) {
        vimeoVideoID = @"";
        return vimeoVideoID;
    }
    //If not nil check if it is empty e.g @""
    else if ([vimeoVideoID length] == 0){

        return vimeoVideoID;
    }
    
    //Check if videoID contains only digits
    NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:vimeoVideoID];
    
    if ([_NumericOnly isSupersetOfSet: myStringSet]) {
        
        return vimeoVideoID;
        
    } else{
        vimeoVideoID = @"";
        return vimeoVideoID;
        
    }
    
    return @"";
    
    
}

@end
