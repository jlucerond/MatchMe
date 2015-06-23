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

@interface PlayingCardController () <PlayingCardCellDataSource>

@property (nonatomic) PlayingCard *playingCard;

@end

@implementation PlayingCardController

- (instancetype) initWithPlayingCard: (PlayingCard *) playingCard{
    self = [super init];
    if (self) {
        _playingCard = playingCard;
    }
    return self;
}

- (instancetype) init {
    return [self initWithPlayingCard:nil];
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


@end
