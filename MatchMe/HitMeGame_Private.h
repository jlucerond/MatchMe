//
//  HitMeGame_Private.h
//  MatchMe
//
//  Created by Joe Lucero on 6/23/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "HitMeGame.h"

@class Deck;

@interface HitMeGame ()

@property (nonatomic) NSArray *validRanks;
@property (nonatomic) NSArray *validSuits;
@property (nonatomic) NSDictionary *colorForSuit;
@property (nonatomic) Deck *deck;

@end
