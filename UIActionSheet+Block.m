//
//  UIActionSheet+Block.m
//  UIActionSheet+Block
//
//  Created by Jonghwan Hyeon on 8/25/14.
//  Copyright (c) 2014 Jonghwan Hyeon. All rights reserved.
//

#import "UIActionSheet+Block.h"
#import <objc/runtime.h>

@interface UIActionSheet () <UIActionSheetDelegate>

@property (copy, nonatomic) void (^block)(UIActionSheet *actionSheet, NSInteger buttonIndex);

@end

@implementation UIActionSheet (Block)

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
{
    self = [self initWithTitle:title delegate:nil
             cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if (self) {
        NSInteger buttonIndex = 0;

        if (destructiveButtonTitle) {
            [self addButtonWithTitle:destructiveButtonTitle];
            self.destructiveButtonIndex = buttonIndex++;
        }

        for (NSString *otherButtonTitle in otherButtonTitles) {
            [self addButtonWithTitle:otherButtonTitle];
            ++buttonIndex;
        }

        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
            self.cancelButtonIndex = buttonIndex++;
        }

    }

    return self;
}

- (instancetype)initWithCancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                        otherButtonTitles:(NSArray *)otherButtonTitles
{
    return [self initWithTitle:nil
             cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle
             otherButtonTitles:otherButtonTitles];
}

- (instancetype)initWithTitle:(NSString *)title
            otherButtonTitles:(NSArray *)otherButtonTitles
{
    return [self initWithTitle:title
             cancelButtonTitle:nil destructiveButtonTitle:nil
             otherButtonTitles:otherButtonTitles];
}

- (instancetype)initWithOtherButtonTitles:(NSArray *)otherButtonTitles
{
    return [self initWithTitle:nil
             cancelButtonTitle:nil destructiveButtonTitle:nil
             otherButtonTitles:otherButtonTitles];
}

- (void)setBlock:(void (^)(UIAlertView *, NSInteger))block
{
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIAlertView *, NSInteger))block
{
    return objc_getAssociatedObject(self, @selector(block));
}

- (void)showFromTabBar:(UITabBar *)view
            usingBlock:(void (^)(UIActionSheet *actionSheet, NSInteger buttonIndex))block
{
    self.delegate = self;
    self.block = block;

    [self showFromTabBar:view];
}

- (void)showFromToolbar:(UIToolbar *)view
             usingBlock:(void (^)(UIActionSheet *actionSheet, NSInteger buttonIndex))block
{
    self.delegate = self;
    self.block = block;

    [self showFromToolbar:view];
}

- (void)showInView:(UIView *)view
        usingBlock:(void (^)(UIActionSheet *actionSheet, NSInteger buttonIndex))block
{
    self.delegate = self;
    self.block = block;

    [self showInView:view];
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated
                   usingBlock:(void (^)(UIActionSheet *actionSheet, NSInteger buttonIndex))block
{
    self.delegate = self;
    self.block = block;

    [self showFromBarButtonItem:item animated:animated];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated
          usingBlock:(void (^)(UIActionSheet *actionSheet, NSInteger buttonIndex))block
{
    self.delegate = self;
    self.block = block;

    [self showFromRect:rect inView:view animated:animated];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.block) {
        self.block(actionSheet, buttonIndex);
    }
}

@end