//
//  PlayingCard.h
//  HitMe
//
//  Created by Joe Lucero on 6/14/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PlayingCard : NSObject

@property (nonatomic, readonly) BOOL isFaceUp;
@property (readonly, nonatomic) NSString *cardRank;
@property (readonly, nonatomic) NSString *cardSuit;
@property (readonly, nonatomic) UIColor *cardColor;

- (instancetype)initWithRank: (NSString *) rank
                        suit: (NSString *) suit
                       color: (UIColor *) color;

- (void) showCardFace;
- (void) hideCardFace;

@end
