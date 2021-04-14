# MLSecurityButton

When the button clicked continuously, this category will be helpful to avoid invoke many times.

The button only response for the first event and then will ignore the remaining actions.

And we can customize the time interval or ignore this function.

```
btn.disableQuickTap = YES;// Disable quick tap to enable security reponse function.
btn.minimumClickInterval = 3.f;// Custom minimum click time interval, default is 0.75.
```
