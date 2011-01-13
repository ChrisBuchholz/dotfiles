import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myTerminal    = "urxvt"
myBorderWidth = 3
myWorkspaces  = ["main","www","work","other"]
myModMask = mod4Mask

myManageHooks = composeAll
    [ className =? "Gimp"         --> doFloat
    , className =? "Transmission" --> doFloat
    ]

main = do
    xmproc <- spawnPipe "xmobar /home/cb/.xmobarrc"
    xmonad $ defaultConfig
        { terminal = myTerminal
        , borderWidth = myBorderWidth
        , workspaces = myWorkspaces
        , normalBorderColor = "#5c5c5c"
        , focusedBorderColor = "#757575"
        , manageHook = manageDocks <+> myManageHooks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = myModMask
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, 0x1008ff11), spawn "amixer set Master 2dB- unmute")
        , ((0, 0x1008ff13), spawn "amixer set Master 2dB+ unmute")
        , ((0, 0x1008ff12), spawn "amixer set Master toggle")
        ]
