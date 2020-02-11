# Design Goals

Note: much of what is described here is not currently implemented.

We want this router to be easy to use and maintain. Therefore we support
automatic upgrades. We also want to have a minimalistic user interface (UI)
that is extremely easy to use. The UI will not make every feature of the router.
Instead it will make avaiable only what the typical parent needs.

[] Install Once
    [] The user should only have to install Genesis39 once on their router using the factory upgrade method.
    [] All future upgrades will be handled automatically by Genesis39
[] Automatic Upgrades
    [] Scripts in /etc/uci-defaults should be designed to build on one another.
    [] Genesis39 will ensure each script only runs once.
    - This allows us to add bug-fix / feature enhancement scripts "at the end"
    - We do this so that automatic upgrades work correctly no matter what.
[] User Friendly UI
    [] Only allow configuration of wireless network name and password.
    [] Child Friendly
        [] WiFi network for each child. Parent connects child's device to child's network.
            - do this so that the parent dosen't need to figure out which MAC address is which child's device...
        [] Timeout feature for childern disables wifi for specified period of time.
[ ] Things We Don't Do
    [] We don't provide uninstall support. Once installed, the only way to remove is to flash a different firmware, or reset the router (if installed via packages)

