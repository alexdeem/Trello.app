//
//  AppDelegate.m
//  Trello
//
//  Created by Hector Vergara on 7/19/12.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize webview;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString *urlAddress = @"https://www.trello.com/login";
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [webview setPolicyDelegate:self];
    [webview setUIDelegate:self];

    [[webview mainFrame] loadRequest:requestObj];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    if (!flag) {
        [self.window makeKeyAndOrderFront:self];
        return YES;
    }
    return NO;
}

- (void)webView:(WebView *)webView
decidePolicyForNavigationAction:(NSDictionary *)actionInformation
        request:(NSURLRequest *)request frame:(WebFrame *)frame
decisionListener:(id < WebPolicyDecisionListener >)listener
{
    NSArray *accepted = [NSArray arrayWithObjects:@"www.trello.com", @"trello.com", @"accounts.google.com", @"www.google.com", nil];
    NSString *host = [[request URL] host];
    if (![accepted containsObject:host]) {
        NSLog(@"Opening page externally: %@", host);
        [[NSWorkspace sharedWorkspace] openURL:[request URL]];
    } else {
        [listener use];
    }
}

- (WebView *)webView:(WebView *)sender createWebViewWithRequest:(NSURLRequest *)request
{
    [[sender mainFrame] loadRequest:request];
    return sender;
}

@end