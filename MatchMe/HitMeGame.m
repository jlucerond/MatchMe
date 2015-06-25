//
//  HitMeGame.m
//  HitMe
//
//  Created by Joe Lucero on 6/14/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "HitMeGame.h"
#import "Deck.h"
#import "HitMeGame_Private.h"

@implementation HitMeGame

- (BOOL) hasNextCard {
    return ([self.deck showNextCard] != nil);
}

- (PlayingCard *) nextCard {
        return [self.deck dealNextCard];
}

#pragma mark - filling and shuffling deck

- (NSArray *) validRanks {
    if (! _validRanks) {
        _validRanks = @[@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    }
    return _validRanks;
}

- (NSArray *) validSuits {
    if (! _validSuits) {
        _validSuits = @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
    }
    return _validSuits;
}

- (NSDictionary *) colorForSuit {
    if (! _colorForSuit) {
        _colorForSuit = @{@"♠︎" : [UIColor blueColor], @"♣︎": [UIColor blueColor], @"♥︎" : [UIColor greenColor], @"♦︎" : [UIColor greenColor]};
    }
    return _colorForSuit;
}

- (void) fillAndShuffle {
    self.deck = [[Deck alloc] init];
    //add 52 cards here
    [self fillDeck];
    
    //then shuffle
    [self shuffleDeck];
}

- (void) fillDeck {
    for (NSString *rank in self.validRanks){
        for (NSString *suit in self.validSuits){
            [self.deck addCardWithRank:rank suit:suit color:self.colorForSuit[suit]];
        }
    }
}

- (void) shuffleDeck {
    [self.deck shuffleDeck];
}

@end
