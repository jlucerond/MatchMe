//
//  PlayingCardCell.h
//  
//
//  Created by Joe Lucero on 6/22/15.
//
//

#import <UIKit/UIKit.h>

@protocol PlayingCardCellDataSource;

@interface PlayingCardCell : UICollectionViewCell

@property (weak, nonatomic) id <PlayingCardCellDataSource> dataSource;

- (void) didReceiveTap;
- (void) refreshView;

@end

@protocol PlayingCardCellDataSource <NSObject>

- (NSString *) contentStringForPlayingCardCell: (PlayingCardCell *) playingCardCell;
- (UIColor *) colorForPlayingCardCell: (PlayingCardCell *) playingCardCell;
- (UIImageView *) imageViewForBackOfPlayingCardCell: (PlayingCardCell *) playingCardCell;

@end