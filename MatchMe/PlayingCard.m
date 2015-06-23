//
//  PlayingCard.m
//  HitMe
//
//  Created by Joe Lucero on 6/14/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (instancetype) init {
    return  [self initWithRank:nil suit:nil color:nil];
}

- (instancetype)initWithRank: (NSString *) rank
                        suit: (NSString *) suit
                       color: (UIColor *) color {
    self = [super init];
    if (self) {
        _cardRank = rank;
        _cardSuit = suit;
        _cardColor = color;
    }
    return self;
}

@end
