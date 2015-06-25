//
//  MatchMeGame.m
//  MatchMe
//
//  Created by Joe Lucero on 6/23/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "MatchMeGame.h"
#import "HitMeGame_Private.h"
#import "Deck.h"
#import "PlayingCard.h"

// class extension
@interface MatchMeGame ()

@property (nonatomic) NSInteger pairs;

@end


// implementation
@implementation MatchMeGame

- (instancetype)initWithPairs:(NSInteger)pairs {
    self = [super init];
    if (self) {
        _pairs = pairs;
    }
    return self;
}

- (instancetype)init {
    return [self initWithPairs:0];
}

- (NSArray *) ranksForMatchGame {
    NSMutableArray *ranksForMatchGame = [self.validRanks mutableCopy];
    while ([ranksForMatchGame count] > self.pairs) {
        int randomRank = arc4random()%[ranksForMatchGame count];
        [ranksForMatchGame removeObjectAtIndex:randomRank];
    }
    return ranksForMatchGame;
}

- (NSArray *) suitsForRank {
    NSMutableArray *suitsForRank = [self.validSuits mutableCopy];
    while ([suitsForRank count] > 2){
        int randomSuit = arc4random()%[suitsForRank count];
        [suitsForRank removeObjectAtIndex:randomSuit];
    }
    return suitsForRank;
}

- (void) fillDeck {
    self.deck = [[Deck alloc] init];
    [[self ranksForMatchGame] enumerateObjectsUsingBlock:^(NSString *rank,
                                                           NSUInteger indexRank,
                                                           BOOL *stopRank) {
        [[self suitsForRank] enumerateObjectsUsingBlock:^(NSString *suit,
                                                         NSUInteger indexSuit,
                                                         BOOL *stopSuit) {
            [self.deck addCard:[[PlayingCard alloc] initWithRank:rank suit:suit color:self.colorForSuit[suit]]];
        }];
    }];
}

@end
