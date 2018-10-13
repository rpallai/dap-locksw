"Keep awake" switch for Plasma 5
================================

Small switch (plasmoid) for your Plasma panel to temporarily suspend automatic locking of the screen.

The current color indicates the state of automatic screen lock:

- Green: activated
- Gray: inhibited by third party
- Red: suspended by this switch

## Install
```
$ git clone https://github.com/rpallai/dap-locksw
$ plasmapkg2 -i dap-locksw
```
Now add the widget to your panel. Search for the string "dap" in the widget list and choose "Dap's LockSwitch".

That's all!
