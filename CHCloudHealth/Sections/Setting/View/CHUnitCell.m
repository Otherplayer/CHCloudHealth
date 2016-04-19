//
//   /\_/\
//   \_ _/
//    / \ not
//    \_/
//
//  Created by __无邪_ on 4/5/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "CHUnitCell.h"

@interface CHUnitCell ()
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDetail;
@property (weak, nonatomic) IBOutlet UILabel *labMobile;

@end

@implementation CHUnitCell

- (void)setTitle:(NSString *)title detail:(NSString *)detail{
    [self.labTitle setText:title];
    [self.labDetail setText:detail];
}
- (void)setTitle:(NSString *)title detail:(NSString *)detail mobile:(NSString *)mobile{
    [self.labTitle setText:title];
    [self.labDetail setText:detail];
    [self.labMobile setText:mobile];
}





@end
