//
//  PlayingCard.m
//  HitMe
//
//  Created by Joe Lucero on 6/14/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "PlayingCard.h"
#import "Constants.h"

//redeclare our isFaceUp property to be readwrite so we can change it in our implementation file
@interface PlayingCard ()
@property (nonatomic, readwrite) BOOL isFaceUp;
@end

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

- (void) showCardFace {
    self.isFaceUp = TRUE;
    NSDictionary *userInfo = @{@"rank":self.cardRank,
                               @"suit":self.cardSuit,
                               @"color":self.cardColor,
                               @"timestamp":[NSDate date]};
    [[NSNotificationCenter defaultCenter] postNotificationName: PlayingCardDidBecomeFaceUpNotification
                                                        object:self
                                                      userInfo:userInfo];
}

- (void) hideCardFace {
    self.isFaceUp = FALSE;
}

@end
