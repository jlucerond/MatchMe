//
//  Deck.h
//  HitMe
//
//  Created by Joe Lucero on 6/14/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlayingCard;

@interface Deck : NSObject

- (NSUInteger) numberOfCardsInDeck;
- (void) addCard: (PlayingCard *) card;
- (PlayingCard *) showNextCard;
- (PlayingCard *) dealNextCard;
- (void) shuffleDeck;

@end
