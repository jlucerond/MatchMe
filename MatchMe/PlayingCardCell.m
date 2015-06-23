//
//  PlayingCardCell.m
//  
//
//  Created by Joe Lucero on 6/22/15.
//
//

#import "PlayingCardCell.h"

@interface PlayingCardCell ()

@property (strong, nonatomic) IBOutlet UILabel *playingCardLabel;

@end

@implementation PlayingCardCell

- (void) refreshView {
    self.layer.cornerRadius = self.frame.size.width/16;
    [self customizeLabel];
    [self configureBackOfCard];
}

- (void) configureBackOfCard {
    self.backgroundView = [self.dataSource imageViewForBackOfPlayingCardCell:self];
}

- (CGRect) innerRectForRect : (CGRect)rect {
    CGFloat margin = rect.size.width/15;
    return CGRectMake(margin, margin, rect.size.width - 2 * margin, rect.size.height - 2 * margin);
}

- (UIColor *) accentColor {
    return [UIColor colorWithRed:204.0/255 green:204.0/255 blue:50.0/255 alpha:1.0];
}

- (void) drawRect:(CGRect)rect {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:[self innerRectForRect:rect]
                                                          cornerRadius:3];
    bezierPath.lineWidth = 2;
    [[self accentColor] setStroke];
    [bezierPath stroke];
}

- (void) customizeLabel {
    self.playingCardLabel.attributedText = [[NSAttributedString alloc] initWithString:[self labelContentString]
                                                                           attributes:[self labelAttributes]];
}

- (NSString *) labelContentString {
    if (self.dataSource){
        return [self.dataSource contentStringForPlayingCardCell:self];
    }
    else return @"";
}

- (NSDictionary *) labelAttributes {
    return @{NSFontAttributeName: [UIFont boldSystemFontOfSize:20], NSStrokeColorAttributeName: [self accentColor], NSForegroundColorAttributeName: [self labelContentColor], NSStrokeWidthAttributeName:@(-5)};
}

- (UIColor *) labelContentColor {
    if (self.dataSource) {
        return [self.dataSource colorForPlayingCardCell:self];
    }
    
    else return [UIColor blackColor];
}

#pragma mark - didReceiveTap and subordinate methods

- (void) didReceiveTap {
    [UIView animateWithDuration: 0.15
                     animations: [self flipHalfway]
                     completion: ^(BOOL finished) {
                         [self reverseCard];
                         [self animateFlipTheRestOfTheWay];
                     }];
}

- (void(^)(void)) flipHalfway {
    return ^{
        self.transform = CGAffineTransformMakeScale(0.01, 1);
        //self.center = CGPointMake(self.center.x + self.frame.size.width/2, self.center.y);
    };
}

- (void) reverseCard {
    self.playingCardLabel.hidden = !self.playingCardLabel.hidden;
    self.backgroundView.hidden = !self.backgroundView.hidden;
}

- (void(^)(void)) flipTheRestOfTheWay {
    return ^{
        self.transform = CGAffineTransformIdentity;
    };
}

- (void) animateFlipTheRestOfTheWay {
    [UIView animateWithDuration:0.15 animations:[self flipTheRestOfTheWay]];
}


@end
