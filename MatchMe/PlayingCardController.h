//
//  PlayingCardController.h
//  MatchMe
//
//  Created by Joe Lucero on 6/22/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PlayingCard;

@interface PlayingCardController : NSObject

- (instancetype) initWithPlayingCard: (PlayingCard *) playingCard;
- (void) connectToCell: (UICollectionViewCell *) cell;
- (void) didTapCell;

@end
