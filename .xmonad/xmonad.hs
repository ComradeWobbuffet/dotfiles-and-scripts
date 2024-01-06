import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Prompt.ConfirmPrompt
import XMonad.Actions.Volume
import XMonad.Util.Dzen

import Graphics.X11.ExtraTypes.XF86

alert = dzenConfig centered . show . round
centered =
        onCurr (center 150 66)
    >=> font "-*-helvetica-*-r-*-*-64-*-*-*-*-*-*-*"
    >=> addArgs ["-fg", "#80c0ff"]
    >=> addArgs ["-bg", "#000040"]

main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ xmobarProp $ def
        {   modMask = mod4Mask
        , terminal = "urxvt -fg grey -bg black"
        , layoutHook = smartBorders $ layoutHook def
        , startupHook = spawn "~/.session-sounds/play-session-sound.sh --login"
        }
        `additionalKeysP`
        [ ("M-S-z", spawn "xscreensaver --no-splash &" >> spawn "sleep 0.5 && xscreensaver-command -lock")
        , ("M-f", spawn "firefox")
        , ("<XF86AudioRaiseVolume>", raiseVolume 5 >> return ())
        , ("<XF86AudioLowerVolume>", lowerVolume 5 >> return ())
        , ("<XF86AudioMute>", toggleMute >> return ())
        , ("M-S-q", confirmPrompt def "exit" (spawn "~/.session-sounds/play-session-sound.sh --logout 2> /dev/null" >> io (exitWith ExitSuccess))) ]
