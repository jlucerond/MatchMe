//
//  Deck.m
//  HitMe
//
//  Created by Joe Lucero on 6/14/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "Deck.h"
#import "PlayingCard.h"

// interface
@interface Deck ()

@property (nonatomic) NSMutableArray *cards;

@end

// implementation
@implementation Deck

- (NSMutableArray *) cards {
    if (! _cards) {
        _cards = [[NSMutableArray alloc] initWithCapacity:100];
    }
    return _cards;
}

- (NSUInteger) numberOfCardsInDeck {
    return self.cards.count;
}

- (void) addCardWithRank:(NSString *)rank suit:(NSString *)suit color:(UIColor *)color {
    PlayingCard *card = [[PlayingCard alloc] initWithRank:rank suit:suit color:color];
    [self.cards addObject:card];
}

- (PlayingCard *) showNextCard {
    return [self.cards firstObject];
}

- (PlayingCard *) dealNextCard {
    PlayingCard *nextCard = [self.cards firstObject];
    if (nextCard) {
        [self.cards removeObjectAtIndex:0];
    }
    
    return nextCard;
    
}

- (void) shuffleDeck {
    int numOfCards = (int)self.cards.count;
    if (self.cards.count > 1) {
        NSMutableArray *oldDeckOrder = self.cards;
        NSMutableArray *newDeckOrder = [[NSMutableArray alloc] init];
        for (int i = 0; i < numOfCards; i++){
            int myRandNum = arc4random_uniform((int) oldDeckOrder.count);
            [newDeckOrder addObject: oldDeckOrder[myRandNum]];
            [oldDeckOrder removeObjectAtIndex:myRandNum];
        }
        self.cards = newDeckOrder;
    }
}

@end
