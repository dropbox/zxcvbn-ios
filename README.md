```
.................................................bbb....................
.zzzzzzzzzz..xxx....xxx....cccccccc..vvv....vvv..bbb.........nnnnnnn....
.....zzzz......xxxxxx....cccc........vvv....vvv..bbbbbbbb....nnn...nnn..
...zzzz........xxxxxx....cccc..........vvvvvv....bbb....bb...nnn...nnn..
.zzzzzzzzzz..xxx....xxx....cccccccc......vv......bbbbbbbb....nnn...nnn..
........................................................................
```

An obj-c port of `zxcvbn`, a password strength estimation library, designed for iOS.

`zxcvbn` attempts to give sound password advice through pattern matching
and conservative entropy calculations. It finds 10k common passwords,
common American names and surnames, common English words, and common
patterns like dates, repeats (aaa), sequences (abcd), and QWERTY
patterns.

For full motivation, see: http://tech.dropbox.com/?p=165

Original JavaScript library: https://github.com/dropbox/zxcvbn

Python port: https://github.com/dropbox/python-zxcvbn

# Installation

Coming soon.

# Use

![zxcvbn example](https://github.com/leah/zxcvbn-ios/blob/master/Zxcvbn/zxcvbn-example.png?raw=true)

The easiest way to use `zxcvbn` is by displaying a `DBPasswordStrengthMeter` in your form. Set up your `UITextFieldDelegate` and add a `DBPasswordStrengthMeter`. As the user types, you can call `scorePassword:` like so:
``` objc
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *password = [textField.text stringByReplacingCharactersInRange:range withString:string];

    [self.passwordStrengthMeterView scorePassword:password];

    return YES;
}
```

To use zxcvbn without the `DBPasswordStrengthMeter` UI element simply import `DBZxcvbn.h`, create a new instance of `DBZxcvbn`, then call `passwordStrength:`.

``` objc
#import "DBZxcvbn.h"

DBZxcvbn *zxcvbn = [[DBZxcvbn alloc] init];
DBResult *result = [zxcvbn passwordStrength:password userInputs:userInputs];
```

The DBResult includes a few properties:

``` objc
result.entropy          // bits

result.crackTime        // estimation of actual crack time, in seconds.

result.crackTimeDisplay // same crack time, as a friendlier string:
                        // "instant", "6 minutes", "centuries", etc.

result.score            // [0,1,2,3,4] if crack time is less than
                        // [10**2, 10**4, 10**6, 10**8, Infinity].
                        // (useful for implementing a strength bar.)

result.matchSequence    // the list of patterns that zxcvbn based the
                        // entropy calculation on.

result.calcTime         // how long it took to calculate an answer,
                        // in milliseconds. usually only a few ms.
````

The optional `userInputs` argument is an array of strings that `zxcvbn`
will add to its internal dictionary. This can be whatever list of
strings you like, but is meant for user inputs from other fields of the
form, like name and email. That way a password that includes the user's
personal info can be heavily penalized. This list is also good for
site-specific vocabulary.

# Acknowledgments

Thanks to Dropbox for supporting independent projects and open source software.

Many thanks to [Dan Wheeler](https://github.com/lowe) for the original [CoffeeScript implementation](https://github.com/dropbox/zxcvbn). Thanks to [Ryan Pearl](https://github.com/dropbox/python-zxcvbn) for his [Python port](). I've enjoyed copying your code :)  

Last but not least, big thanks to xkcd.
https://xkcd.com/936/

