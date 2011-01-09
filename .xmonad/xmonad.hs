import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "xmobar /home/cb/.xmobarrc"
    xmonad $ defaultConfig
        { terminal = "urxvt"
        , borderWidth = 4
        , normalBorderColor = "#5c5c5c"
        , focusedBorderColor = "#757575"
        , manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((0, 0x1008ff11), spawn "amixer set Master 2dB- unmute")
        , ((0, 0x1008ff13), spawn "amixer set Master 2dB+ unmute")
        , ((0, 0x1008ff12), spawn "amixer set Master toggle")
        ]
