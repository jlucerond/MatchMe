//
//  PlayingCardController.m
//  MatchMe
//
//  Created by Joe Lucero on 6/22/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "PlayingCardController.h"
#import "PlayingCard.h"
#import "PlayingCardCell.h"
#import "Constants.h"

@interface PlayingCardController () <PlayingCardCellDataSource>

@property (nonatomic) PlayingCard *playingCard;
@property (nonatomic) PlayingCardCell *cell;
@property (nonatomic) id didMatchToken;
@property (nonatomic) id didNotMatchToken;

@end

@implementation PlayingCardController

- (instancetype) initWithPlayingCard: (PlayingCard *) playingCard{
    self = [super init];
    if (self) {
        _playingCard = playingCard;
        [self registerForDidIdentifyMatchingCardsNotification];
        [self registerForDidIdentifyNonmatchingCardsNotification];
    }
    return self;
}

- (instancetype) init {
    return [self initWithPlayingCard:nil];

}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self.didNotMatchToken];
    [[NSNotificationCenter defaultCenter] removeObserver:self.didMatchToken];
}

- (NSString *) contentStringForPlayingCardCell: (PlayingCardCell *) playingCardCell {
    return [NSString stringWithFormat:@"%@ %@", self.playingCard.cardRank, self.playingCard.cardSuit];
}

- (UIColor *) colorForPlayingCardCell: (PlayingCardCell *) playingCardCell {
    return self.playingCard.cardColor;
}

- (UIImageView *) imageViewForBackOfPlayingCardCell: (PlayingCardCell *) playingCardCell {
    UIImage *backOfCardImage = [UIImage imageNamed:@"ndLogo"];
    return [[UIImageView alloc] initWithImage:backOfCardImage];
}

- (void) connectToCell: (UICollectionViewCell *) cell {
    if ([cell isKindOfClass:[PlayingCardCell class]]){
        self.cell = (PlayingCardCell *) cell;
        self.cell.dataSource = self;
        [self.cell refreshView];
        [self.playingCard addObserver:self.cell
                           forKeyPath:@"isFaceUp"
                              options:NSKeyValueObservingOptionNew
                              context:NULL];
    }
}

- (void) didTapCell {
    if (self.playingCard.isFaceUp){
        [self.playingCard hideCardFace];
    }
    else {
        [self.playingCard showCardFace];
    }
}

- (void) registerForDidIdentifyMatchingCardsNotification {
    self.didMatchToken = [[NSNotificationCenter defaultCenter] addObserverForName: MatchMeGameDidIdentifyMatchingCardsNotification
                                                                           object: nil
                                                                            queue: [NSOperationQueue mainQueue]
                                                                       usingBlock: ^(NSNotification *notification) {
                                                                           if ([self.playingCard isFaceUp]) {
                                                                              [UIView animateWithDuration:1.0
                                                                                               animations:^{
                                                                                                   self.cell.alpha = 0;
                                                                              }];
                                                                           }
                                                                       }];
}

- (void) registerForDidIdentifyNonmatchingCardsNotification {
    self.didNotMatchToken = [[NSNotificationCenter defaultCenter] addObserverForName: MatchMeGameDidIdentifyNonmatchingCardsNotification
                                                                           object: nil
                                                                            queue: [NSOperationQueue mainQueue]
                                                                       usingBlock: ^(NSNotification *notification) {
                                                                           if ([self.playingCard isFaceUp]) {
                                                                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                                                                                            (int64_t)(1*NSEC_PER_SEC)),
                                                                                                            dispatch_get_main_queue(), ^{
                                                                                                                [self.playingCard hideCardFace];
                                                                                                            });
                                                                           }
                                                                       }];
}


@end
