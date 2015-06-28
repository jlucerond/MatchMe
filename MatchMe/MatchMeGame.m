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
#import "Constants.h"

typedef enum MatchMePairMatchState:NSUInteger {
    NotReadyToMatch,
    ReadyToMatch,
    TwoCardsMatch,
    TwoCardsDoNotMatch
} MatchMePairMatchState;

// class extension
@interface MatchMeGame ()

@property (nonatomic) NSInteger pairs;
@property (nonatomic) NSString *rankToMatch;
@property (nonatomic) MatchMePairMatchState matchState;

@end


// implementation
@implementation MatchMeGame

- (instancetype)initWithPairs:(NSInteger)pairs {
    self = [super init];
    if (self) {
        _pairs = pairs;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playingCardDidGetTurnedFaceUp:)
                                                     name:PlayingCardDidBecomeFaceUpNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playingCardDidCompleteAnimatingToFaceUp:)
                                                     name:PlayingCardDidFinishFlippingNotification
                                                   object:nil];
    }
    return self;
}

- (instancetype)init {
    return [self initWithPairs:0];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:PlayingCardDidBecomeFaceUpNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:PlayingCardDidFinishFlippingNotification
                                                  object:nil];
}

- (void) playingCardDidGetTurnedFaceUp : (NSNotification *) notification {
    NSString *rank = notification.userInfo[@"rank"];
    if (!self.rankToMatch) {
        self.rankToMatch = rank;
        self.matchState = ReadyToMatch;
    }
    else {
        if ([self.rankToMatch isEqualToString:rank]){
            self.matchState = TwoCardsMatch;
        }
        else {
            self.matchState = TwoCardsDoNotMatch;
        }
        self.rankToMatch = nil;
    }
}

//- (void)playingCardDidCompleteAnimatingToFaceUp:(NSNotification *)notification {
//    if (self.matchState == SCSTwoCardsMatch) {
//        [[NSNotificationCenter defaultCenter]
//         postNotificationName:SCSMatchMeGameDidIdentifyMatchingCardsNotification


- (void) playingCardDidCompleteAnimatingToFaceUp : (NSNotification *) notification {
    if (self.matchState == TwoCardsMatch) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MatchMeGameDidIdentifyMatchingCardsNotification
                                                            object:self];
    }
    else if (self.matchState == TwoCardsDoNotMatch) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MatchMeGameDidIdentifyNonmatchingCardsNotification
                                                            object:self];
    }
        self.matchState = NotReadyToMatch;
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
            [self.deck addCardWithRank:rank
                                  suit:suit
                                 color:self.colorForSuit[suit]];
        }];
    }];
}

@end
