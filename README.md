APCNetworkActivityIndicatorManager
==

APCNetworkActivityIndicatorManager is a simple, thread-safe class that manages the network activity indicator across multiple code paths. It solves the problem of interleaving calls to `setNetworkActivityIndicatorVisible` leading to the network activity indicator being in an inconsistent state.

Usage
--
The easiest way to use APCNetworkActivityIndicatorManager is to simply copy the two source files into your project.

```obj-c
#import "APCNetworkActivityIndicatorManager.h"

[NCTNetworkActivityIndicatorManager start]; // start the indicator

// ...

[NCTNetworkActivityIndicatorManager stop];  // stop the indicator

```

APCNetworkActivityIndicatorManager will also restore the indicator to the proper state after the app has been backgrounded and then opened again.

License
--
See included LICENSE file
