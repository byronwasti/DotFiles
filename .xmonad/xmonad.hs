import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import Graphics.X11.ExtraTypes.XF86
import System.IO

import XMonad.Actions.WindowMenu
import XMonad.Actions.Navigation2D

main = do
    xmproc <- spawnPipe "xmobar ~/.xmobarcc"

    xmonad $ defaultConfig 
        { terminal = "urxvt"
        , manageHook = manageDocks <+> (isFullscreen --> doFullFloat) <+> manageHook defaultConfig -- Fullscreen goes to float (over xmobar??)
        , layoutHook = smartBorders . avoidStruts $ layoutHook defaultConfig  -- Smart borders to remove borders on fullscreen
        , logHook = dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "grey" "" . shorten 25
                }
        , handleEventHook = mconcat
                [ docksEventHook
                , handleEventHook defaultConfig
                ]
        , modMask = mod4Mask
        , borderWidth = 5
        , normalBorderColor = "#515151"
        , focusedBorderColor = "#ffffff"
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "systemctl suspend")
        , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight +5")
        , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -5")
        , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-mute 0 false && amixer set Master 5%+")
        , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-mute 0 false && amixer set Master 5%-")
        , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute 0 true")

        , ((mod4Mask, xK_Print), spawn "sleep 0.2; scrot -e 'mv $f ~/Photos/screenshots/' ")
        , ((mod4Mask .|. shiftMask, xK_Print), spawn "sleep 0.2; scrot -s -e 'mv $f ~/Photos/screenshots/' ")
        , ((mod4Mask .|. controlMask, xK_Print), spawn "sleep 0.2; scrot -u -e 'mv $f ~/Photos/screenshots/' ")

        , ((mod4Mask, xK_f), sendMessage ToggleStruts)
        ]
