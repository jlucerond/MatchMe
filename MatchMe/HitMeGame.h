//
//  HitMeGame.h
//  HitMe
//
//  Created by Joe Lucero on 6/14/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlayingCard;

@interface HitMeGame : NSObject

- (BOOL) hasNextCard;
- (PlayingCard *) nextCard;
- (void) fillAndShuffle;

@end
