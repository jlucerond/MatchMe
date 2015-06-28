//
//  GameBoardViewController.m
//  MatchMe
//
//  Created by Joe Lucero on 6/22/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "GameBoardViewController.h"
#import "MatchMeGame.h"
#import "PlayingCardController.h"

@interface GameBoardViewController () 

@property (nonatomic) MatchMeGame *game;
@property (nonatomic) NSArray *playingCardControllers;

@end

@implementation GameBoardViewController

static NSString * const reuseIdentifier = @"Cell";

- (NSInteger) numberOfPairs {
    return 5;
}

- (NSInteger) numberOfCards {
    return 2 * [self numberOfPairs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpGame];
    [self dealCards];
}

- (void) setUpGame {
    self.game = [[MatchMeGame alloc] initWithPairs:[self numberOfPairs]];
    [self.game fillAndShuffle];
}

- (void) dealCards {
    NSMutableArray *tempControllers = [[NSMutableArray alloc] initWithCapacity:[self numberOfCards]];
    for (int i = 0; i < [self numberOfCards]; i++) {
        [tempControllers addObject:[[PlayingCardController alloc] initWithPlayingCard:[self.game nextCard]]];
    }
    self.playingCardControllers = tempControllers;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2* [self numberOfPairs];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *playingCardCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCardCell" forIndexPath:indexPath];
    PlayingCardController *controllerForCell = self.playingCardControllers[indexPath.item];
    [controllerForCell connectToCell:playingCardCell];
    return playingCardCell;
}

#pragma mark <UICollectionViewDelegate>

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PlayingCardController *selectedController = self.playingCardControllers[indexPath.item];
    [selectedController didTapCell];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
