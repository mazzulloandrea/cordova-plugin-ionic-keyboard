/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CDVIonicKeyboard.h"
#import <Cordova/CDVAvailability.h>
// #import <Cordova/NSDictionary+CordovaPreferences.h>
#import <objc/runtime.h>

// typedef enum : NSUInteger {
//     ResizeNone,
//     ResizeNative,
//     ResizeBody,
//     ResizeIonic,
// } ResizePolicy;

// #ifndef __CORDOVA_3_2_0
// #warning "The keyboard plugin is only supported in Cordova 3.2 or greater, it may not work properly in an older version. If you do use this plugin in an older version, make sure the HideKeyboardFormAccessoryBar and KeyboardShrinksView preference values are false."
// #endif

// @interface CDVIonicKeyboard () <UIScrollViewDelegate>

// @property (readwrite, assign, nonatomic) BOOL disableScroll;
// @property (readwrite, assign, nonatomic) BOOL hideFormAccessoryBar;
// @property (readwrite, assign, nonatomic) BOOL keyboardIsVisible;
// @property (nonatomic, readwrite) ResizePolicy keyboardResizes;
// @property (readwrite, assign, nonatomic) NSString* keyboardStyle;
// @property (nonatomic, readwrite) BOOL isWK;
// @property (nonatomic, readwrite) int paddingBottom;

// @end

// @implementation CDVIonicKeyboard

// NSTimer *hideTimer;

// - (id)settingForKey:(NSString *)key
// {
//     return [self.commandDelegate.settings objectForKey:[key lowercaseString]];
// }

// #pragma mark Initialize

// NSString* UIClassString;
// NSString* WKClassString;
// NSString* UITraitsClassString;

// - (void)pluginInitialize
// {
//     UIClassString = [@[@"UI", @"Web", @"Browser", @"View"] componentsJoinedByString:@""];
//     WKClassString = [@[@"WK", @"Content", @"View"] componentsJoinedByString:@""];
//     UITraitsClassString = [@[@"UI", @"Text", @"Input", @"Traits"] componentsJoinedByString:@""];

//     NSDictionary *settings = self.commandDelegate.settings;

//     self.disableScroll = ![settings cordovaBoolSettingForKey:@"ScrollEnabled" defaultValue:NO];

//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarDidChangeFrame:) name: UIApplicationDidChangeStatusBarFrameNotification object:nil];

//     self.keyboardResizes = ResizeNative;
//     BOOL doesResize = [settings cordovaBoolSettingForKey:@"KeyboardResize" defaultValue:YES];
//     if (!doesResize) {
//         self.keyboardResizes = ResizeNone;
//         NSLog(@"CDVIonicKeyboard: no resize");

//     } else {
//         NSString *resizeMode = [settings cordovaSettingForKey:@"KeyboardResizeMode"];
//         if (resizeMode) {
//             if ([resizeMode isEqualToString:@"ionic"]) {
//                 self.keyboardResizes = ResizeIonic;
//             } else if ([resizeMode isEqualToString:@"body"]) {
//                 self.keyboardResizes = ResizeBody;
//             }
//         }
//         NSLog(@"CDVIonicKeyboard: resize mode %lu", (unsigned long)self.keyboardResizes);
//     }
//     self.hideFormAccessoryBar = [settings cordovaBoolSettingForKey:@"HideKeyboardFormAccessoryBar" defaultValue:YES];

//     NSString *keyboardStyle = [settings cordovaSettingForKey:@"KeyboardStyle"];
//     if (keyboardStyle) {
//         [self setKeyboardStyle:keyboardStyle];
//     }

//     if ([settings cordovaBoolSettingForKey:@"KeyboardAppearanceDark" defaultValue:NO]) {
//         [self setKeyboardStyle:@"dark"];
//     }

//     NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];

//     [nc addObserver:self selector:@selector(onKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//     [nc addObserver:self selector:@selector(onKeyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
//     [nc addObserver:self selector:@selector(onKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//     [nc addObserver:self selector:@selector(onKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];

//     // Prevent WKWebView to resize window
//     BOOL isWK = self.isWK = [self.webView isKindOfClass:NSClassFromString(@"WKWebView")];
//     if (!isWK) {
//         NSLog(@"CDVIonicKeyboard: WARNING!!: Keyboard plugin works better with WK");
//     }

//     if (isWK) {
//         [nc removeObserver:self.webView name:UIKeyboardWillHideNotification object:nil];
//         [nc removeObserver:self.webView name:UIKeyboardWillShowNotification object:nil];
//         [nc removeObserver:self.webView name:UIKeyboardWillChangeFrameNotification object:nil];
//         [nc removeObserver:self.webView name:UIKeyboardDidChangeFrameNotification object:nil];
//     }
// }

// -(void)statusBarDidChangeFrame:(NSNotification*)notification
// {
//     [self _updateFrame];
// }


// #pragma mark Keyboard events

// - (void)resetScrollView
// {
//     UIScrollView *scrollView = [self.webView scrollView];
//     [scrollView setContentInset:UIEdgeInsetsZero];
// }

// - (void)onKeyboardWillHide:(NSNotification *)sender
// {
//     if (self.isWK) {
//         [self setKeyboardHeight:0 delay:0.01];
//         [self resetScrollView];
//     }
//     hideTimer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(fireOnHiding) userInfo:nil repeats:NO];
// }

// - (void)fireOnHiding {
//     [self.commandDelegate evalJs:@"Keyboard.fireOnHiding();"];
// }

// - (void)onKeyboardWillShow:(NSNotification *)note
// {
//     if (hideTimer != nil) {
//         [hideTimer invalidate];
//     }
//     CGRect rect = [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//     double height = rect.size.height;

//     if (self.isWK) {
//         double duration = [[note.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//         [self setKeyboardHeight:height delay:duration+0.2];
//         [self resetScrollView];
//     }
    
//     [self setKeyboardStyle:self.keyboardStyle];

//     NSString *js = [NSString stringWithFormat:@"Keyboard.fireOnShowing(%d);", (int)height];
//     [self.commandDelegate evalJs:js];
// }

// - (void)onKeyboardDidShow:(NSNotification *)note
// {
//     CGRect rect = [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//     double height = rect.size.height;

//     if (self.isWK) {
//         [self resetScrollView];
//     }

//     NSString *js = [NSString stringWithFormat:@"Keyboard.fireOnShow(%d);", (int)height];
//     [self.commandDelegate evalJs:js];
// }

// - (void)onKeyboardDidHide:(NSNotification *)sender
// {
//     [self.commandDelegate evalJs:@"Keyboard.fireOnHide();"];
//     [self resetScrollView];
// }

// - (void)setKeyboardHeight:(int)height delay:(NSTimeInterval)delay
// {
//     if (self.keyboardResizes != ResizeNone) {
//         [self setPaddingBottom: height delay:delay];
//     }
// }

// - (void)setPaddingBottom:(int)paddingBottom delay:(NSTimeInterval)delay
// {
//     if (self.paddingBottom == paddingBottom) {
//         return;
//     }

//     self.paddingBottom = paddingBottom;

//     __weak CDVIonicKeyboard* weakSelf = self;
//     SEL action = @selector(_updateFrame);
//     [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:action object:nil];
//     if (delay == 0) {
//         [self _updateFrame];
//     } else {
//         [weakSelf performSelector:action withObject:nil afterDelay:delay];
//     }
// }

// - (void)_updateFrame
// {
//     CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
//     int statusBarHeight = MIN(statusBarSize.width, statusBarSize.height);
    
//     int _paddingBottom = (int)self.paddingBottom;
        
//     if (statusBarHeight == 40) {
//         _paddingBottom = _paddingBottom + 20;
//     }
//     NSLog(@"CDVIonicKeyboard: updating frame");
//     // NOTE: to handle split screen correctly, the application's window bounds must be used as opposed to the screen's bounds.
//     CGRect f = [[[[UIApplication sharedApplication] delegate] window] bounds];
//     CGRect wf = self.webView.frame;
//     switch (self.keyboardResizes) {
//         case ResizeBody:
//         {
//             NSString *js = [NSString stringWithFormat:@"Keyboard.fireOnResize(%d, %d, document.body);",
//                             _paddingBottom, (int)f.size.height];
//             [self.commandDelegate evalJs:js];
//             break;
//         }
//         case ResizeIonic:
//         {
//             NSString *js = [NSString stringWithFormat:@"Keyboard.fireOnResize(%d, %d, document.querySelector('ion-app'));",
//                             _paddingBottom, (int)f.size.height];
//             [self.commandDelegate evalJs:js];
//             break;
//         }
//         case ResizeNative:
//         {
//             [self.webView setFrame:CGRectMake(wf.origin.x, wf.origin.y, f.size.width - wf.origin.x, f.size.height - wf.origin.y - self.paddingBottom)];
//             break;
//         }
//         default:
//             break;
//     }
//     [self resetScrollView];
// }

// #pragma mark Keyboard Style

//  - (void)setKeyboardStyle:(NSString*)style
// {
//     IMP newImp = [style isEqualToString:@"dark"] ? imp_implementationWithBlock(^(id _s) {
//         return UIKeyboardAppearanceDark;
//     }) : imp_implementationWithBlock(^(id _s) {
//         return UIKeyboardAppearanceLight;
//     });
    
//     if (self.isWK) {
//         for (NSString* classString in @[WKClassString, UITraitsClassString]) {
//             Class c = NSClassFromString(classString);
//             Method m = class_getInstanceMethod(c, @selector(keyboardAppearance));
            
//             if (m != NULL) {
//                 method_setImplementation(m, newImp);
//             } else {
//                 class_addMethod(c, @selector(keyboardAppearance), newImp, "l@:");
//             }
//         }
//     }
//     else {
//         for (NSString* classString in @[UIClassString, UITraitsClassString]) {
//             Class c = NSClassFromString(classString);
//             Method m = class_getInstanceMethod(c, @selector(keyboardAppearance));
            
//             if (m != NULL) {
//                 method_setImplementation(m, newImp);
//             } else {
//                 class_addMethod(c, @selector(keyboardAppearance), newImp, "l@:");
//             }
//         }
//     }

//     _keyboardStyle = style;
// }

// #pragma mark HideFormAccessoryBar

// static IMP UIOriginalImp;
// static IMP WKOriginalImp;

// - (void)setHideFormAccessoryBar:(BOOL)hideFormAccessoryBar
// {
//     if (hideFormAccessoryBar == _hideFormAccessoryBar) {
//         return;
//     }

//     Method UIMethod = class_getInstanceMethod(NSClassFromString(UIClassString), @selector(inputAccessoryView));
//     Method WKMethod = class_getInstanceMethod(NSClassFromString(WKClassString), @selector(inputAccessoryView));

//     if (hideFormAccessoryBar) {
//         UIOriginalImp = method_getImplementation(UIMethod);
//         WKOriginalImp = method_getImplementation(WKMethod);

//         IMP newImp = imp_implementationWithBlock(^(id _s) {
//             return nil;
//         });

//         method_setImplementation(UIMethod, newImp);
//         method_setImplementation(WKMethod, newImp);
//     } else {
//         method_setImplementation(UIMethod, UIOriginalImp);
//         method_setImplementation(WKMethod, WKOriginalImp);
//     }

//     _hideFormAccessoryBar = hideFormAccessoryBar;
// }

// #pragma mark scroll

// - (void)setDisableScroll:(BOOL)disableScroll {
//     if (disableScroll == _disableScroll) {
//         return;
//     }
//     if (disableScroll) {
//         self.webView.scrollView.scrollEnabled = NO;
//         self.webView.scrollView.delegate = self;
//     }
//     else {
//         self.webView.scrollView.scrollEnabled = YES;
//         self.webView.scrollView.delegate = nil;
//     }
//     _disableScroll = disableScroll;
// }

// - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//     [scrollView setContentOffset: CGPointZero];
// }

// #pragma mark Plugin interface

// - (void)hideFormAccessoryBar:(CDVInvokedUrlCommand *)command
// {
//     if (command.arguments.count > 0) {
//         id value = [command.arguments objectAtIndex:0];
//         if (!([value isKindOfClass:[NSNumber class]])) {
//             value = [NSNumber numberWithBool:NO];
//         }

//         self.hideFormAccessoryBar = [value boolValue];
//     }

//     [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:self.hideFormAccessoryBar]
//                                 callbackId:command.callbackId];
// }

// - (void)hide:(CDVInvokedUrlCommand *)command
// {
//     [self.webView endEditing:YES];
// }

// - (void)setResizeMode:(CDVInvokedUrlCommand *)command
// {
//     NSString * mode = [command.arguments objectAtIndex:0];
//     if ([mode isEqualToString:@"ionic"]) {
//         self.keyboardResizes = ResizeIonic;
//     } else if ([mode isEqualToString:@"body"]) {
//         self.keyboardResizes = ResizeBody;
//     } else if ([mode isEqualToString:@"native"]) {
//         self.keyboardResizes = ResizeNative;
//     } else {
//         self.keyboardResizes = ResizeNone;
//     }
// }

// - (void)keyboardStyle:(CDVInvokedUrlCommand*)command
// {
//     id value = [command.arguments objectAtIndex:0];
//     if ([value isKindOfClass:[NSString class]]) {
//         value = [(NSString*)value lowercaseString];
//     } else {
//         value = @"light";
//     }

//      self.keyboardStyle = value;
// }

// - (void)disableScroll:(CDVInvokedUrlCommand*)command {
//     if (!command.arguments || ![command.arguments count]){
//         return;
//     }
//     id value = [command.arguments objectAtIndex:0];
//     if (value != [NSNull null]) {
//         self.disableScroll = [value boolValue];
//     }
// }

// #pragma mark dealloc

// - (void)dealloc
// {
//     [[NSNotificationCenter defaultCenter] removeObserver:self];
// }

// @end

#ifndef __CORDOVA_3_2_0
#warning "The keyboard plugin is only supported in Cordova 3.2 or greater, it may not work properly in an older version. If you do use this plugin in an older version, make sure the HideKeyboardFormAccessoryBar and KeyboardShrinksView preference values are false."
#endif

@interface CDVKeyboard () <UIScrollViewDelegate>

@property (nonatomic, readwrite, assign) BOOL keyboardIsVisible;

@end

@implementation CDVKeyboard

- (id)settingForKey:(NSString*)key
{
    return [self.commandDelegate.settings objectForKey:[key lowercaseString]];
}

#pragma mark Initialize

- (void)pluginInitialize
{
    NSString* setting = nil;

    setting = @"HideKeyboardFormAccessoryBar";
    if ([self settingForKey:setting]) {
        self.hideFormAccessoryBar = [(NSNumber*)[self settingForKey:setting] boolValue];
    }

    setting = @"KeyboardShrinksView";
    if ([self settingForKey:setting]) {
        self.shrinkView = [(NSNumber*)[self settingForKey:setting] boolValue];
    }

    setting = @"DisableScrollingWhenKeyboardShrinksView";
    if ([self settingForKey:setting]) {
        self.disableScrollingInShrinkView = [(NSNumber*)[self settingForKey:setting] boolValue];
    }

    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    __weak CDVKeyboard* weakSelf = self;

    _keyboardShowObserver = [nc addObserverForName:UIKeyboardDidShowNotification
                                            object:nil
                                             queue:[NSOperationQueue mainQueue]
                                        usingBlock:^(NSNotification* notification) {
            [weakSelf.commandDelegate evalJs:@"Keyboard.fireOnShow();"];
                                        }];
    _keyboardHideObserver = [nc addObserverForName:UIKeyboardDidHideNotification
                                            object:nil
                                             queue:[NSOperationQueue mainQueue]
                                        usingBlock:^(NSNotification* notification) {
            [weakSelf.commandDelegate evalJs:@"Keyboard.fireOnHide();"];
                                        }];

    _keyboardWillShowObserver = [nc addObserverForName:UIKeyboardWillShowNotification
                                                object:nil
                                                 queue:[NSOperationQueue mainQueue]
                                            usingBlock:^(NSNotification* notification) {
            [weakSelf.commandDelegate evalJs:@"Keyboard.fireOnShowing();"];
            weakSelf.keyboardIsVisible = YES;
                                            }];
    _keyboardWillHideObserver = [nc addObserverForName:UIKeyboardWillHideNotification
                                                object:nil
                                                 queue:[NSOperationQueue mainQueue]
                                            usingBlock:^(NSNotification* notification) {
            [weakSelf.commandDelegate evalJs:@"Keyboard.fireOnHiding();"];
            weakSelf.keyboardIsVisible = NO;
                                            }];

    _shrinkViewKeyboardWillChangeFrameObserver = [nc addObserverForName:UIKeyboardWillChangeFrameNotification
                                                                 object:nil
                                                                  queue:[NSOperationQueue mainQueue]
                                                             usingBlock:^(NSNotification* notification) {
                                                                 [weakSelf performSelector:@selector(shrinkViewKeyboardWillChangeFrame:) withObject:notification afterDelay:0];
                                                                 CGRect screen = [[UIScreen mainScreen] bounds];
                                                                 CGRect keyboard = ((NSValue*)notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"]).CGRectValue;
                                                                 CGRect intersection = CGRectIntersection(screen, keyboard);
                                                                 CGFloat height = MIN(intersection.size.width, intersection.size.height);
                                                                 [weakSelf.commandDelegate evalJs: [NSString stringWithFormat:@"cordova.fireWindowEvent('keyboardHeightWillChange', { 'keyboardHeight': %f })", height]];
                                                             }];

    self.webView.scrollView.delegate = self;
}

#pragma mark HideFormAccessoryBar

static IMP UIOriginalImp;
static IMP WKOriginalImp;

- (void)setHideFormAccessoryBar:(BOOL)hideFormAccessoryBar
{
    if (hideFormAccessoryBar == _hideFormAccessoryBar) {
        return;
    }

    NSString* UIClassString = [@[@"UI", @"Web", @"Browser", @"View"] componentsJoinedByString:@""];
    NSString* WKClassString = [@[@"WK", @"Content", @"View"] componentsJoinedByString:@""];

    Method UIMethod = class_getInstanceMethod(NSClassFromString(UIClassString), @selector(inputAccessoryView));
    Method WKMethod = class_getInstanceMethod(NSClassFromString(WKClassString), @selector(inputAccessoryView));

    if (hideFormAccessoryBar) {
        UIOriginalImp = method_getImplementation(UIMethod);
        WKOriginalImp = method_getImplementation(WKMethod);

        IMP newImp = imp_implementationWithBlock(^(id _s) {
            return nil;
        });

        method_setImplementation(UIMethod, newImp);
        method_setImplementation(WKMethod, newImp);
    } else {
        method_setImplementation(UIMethod, UIOriginalImp);
        method_setImplementation(WKMethod, WKOriginalImp);
    }

    _hideFormAccessoryBar = hideFormAccessoryBar;
}

#pragma mark KeyboardShrinksView

- (void)setShrinkView:(BOOL)shrinkView
{
    // Remove WKWebView's keyboard observers when using shrinkView
    // They've caused several issues with the plugin (#32, #55, #64)
    // Even if you later set shrinkView to false, the observers will not be added back
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    if ([self.webView isKindOfClass:NSClassFromString(@"WKWebView")]) {
        [nc removeObserver:self.webView name:UIKeyboardWillHideNotification object:nil];
        [nc removeObserver:self.webView name:UIKeyboardWillShowNotification object:nil];
        [nc removeObserver:self.webView name:UIKeyboardWillChangeFrameNotification object:nil];
        [nc removeObserver:self.webView name:UIKeyboardDidChangeFrameNotification object:nil];
    }
    _shrinkView = shrinkView;
}

- (void)shrinkViewKeyboardWillChangeFrame:(NSNotification*)notif
{
    // No-op on iOS 7.0.  It already resizes webview by default, and this plugin is causing layout issues
    // with fixed position elements.  We possibly should attempt to implement shrinkview = false on iOS7.0.
    // iOS 7.1+ behave the same way as iOS 6
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_7_1 && NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        return;
    }

    // If the view is not visible, we should do nothing. E.g. if the inappbrowser is open.
    if (!(self.viewController.isViewLoaded && self.viewController.view.window)) {
        return;
    }

    self.webView.scrollView.scrollEnabled = YES;

    CGRect screen = [[[UIApplication sharedApplication] keyWindow] frame];
    CGRect statusBar = [[UIApplication sharedApplication] statusBarFrame];
    CGRect keyboard = ((NSValue*)notif.userInfo[@"UIKeyboardFrameEndUserInfoKey"]).CGRectValue;

    // Work within the webview's coordinate system
    keyboard = [self.webView convertRect:keyboard fromView:nil];
    statusBar = [self.webView convertRect:statusBar fromView:nil];
    screen = [self.webView convertRect:screen fromView:nil];

    // if the webview is below the status bar, offset and shrink its frame
    if ([self settingForKey:@"StatusBarOverlaysWebView"] != nil && ![[self settingForKey:@"StatusBarOverlaysWebView"] boolValue]) {
        CGRect full, remainder;
        CGRectDivide(screen, &remainder, &full, statusBar.size.height, CGRectMinYEdge);
        screen = full;
    }

    // Get the intersection of the keyboard and screen and move the webview above it
    // Note: we check for _shrinkView at this point instead of the beginning of the method to handle
    // the case where the user disabled shrinkView while the keyboard is showing.
    // The webview should always be able to return to full size
    CGRect keyboardIntersection = CGRectIntersection(screen, keyboard);
    if (CGRectContainsRect(screen, keyboardIntersection) && !CGRectIsEmpty(keyboardIntersection) && _shrinkView && self.keyboardIsVisible) {
        screen.size.height -= keyboardIntersection.size.height;
        self.webView.scrollView.scrollEnabled = !self.disableScrollingInShrinkView;
    }

    // A view's frame is in its superview's coordinate system so we need to convert again
    self.webView.frame = [self.webView.superview convertRect:screen fromView:self.webView];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    if (_shrinkView && _keyboardIsVisible) {
        CGFloat maxY = scrollView.contentSize.height - scrollView.bounds.size.height;
        if (scrollView.bounds.origin.y > maxY) {
            scrollView.bounds = CGRectMake(scrollView.bounds.origin.x, maxY,
                                           scrollView.bounds.size.width, scrollView.bounds.size.height);
        }
    }
}

#pragma mark Plugin interface

- (void)shrinkView:(CDVInvokedUrlCommand*)command
{
    if (command.arguments.count > 0) {
        id value = [command.arguments objectAtIndex:0];
        if (!([value isKindOfClass:[NSNumber class]])) {
            value = [NSNumber numberWithBool:NO];
        }

        self.shrinkView = [value boolValue];
    }
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:self.shrinkView]
                                callbackId:command.callbackId];
}

- (void)disableScrollingInShrinkView:(CDVInvokedUrlCommand*)command
{
    if (command.arguments.count > 0) {
        id value = [command.arguments objectAtIndex:0];
        if (!([value isKindOfClass:[NSNumber class]])) {
            value = [NSNumber numberWithBool:NO];
        }

        self.disableScrollingInShrinkView = [value boolValue];
    }
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:self.disableScrollingInShrinkView]
                                callbackId:command.callbackId];
}

- (void)hideFormAccessoryBar:(CDVInvokedUrlCommand*)command
{
    if (command.arguments.count > 0) {
        id value = [command.arguments objectAtIndex:0];
        if (!([value isKindOfClass:[NSNumber class]])) {
            value = [NSNumber numberWithBool:NO];
        }
        
        self.hideFormAccessoryBar = [value boolValue];
    }
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:self.hideFormAccessoryBar]
                                callbackId:command.callbackId];
}

- (void)hide:(CDVInvokedUrlCommand*)command
{
    [self.webView endEditing:YES];
}

#pragma mark dealloc

- (void)dealloc
{
    // since this is ARC, remove observers only
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];

    [nc removeObserver:_keyboardShowObserver];
    [nc removeObserver:_keyboardHideObserver];
    [nc removeObserver:_keyboardWillShowObserver];
    [nc removeObserver:_keyboardWillHideObserver];
    [nc removeObserver:_shrinkViewKeyboardWillChangeFrameObserver];
}

@end