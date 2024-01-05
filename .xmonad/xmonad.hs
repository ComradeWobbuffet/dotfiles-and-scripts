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
        , ("M-S-q", confirmPrompt def "exit" (spawn "~/.session-sounds/play-session-sound.sh --logout 2> /dev/null" >> io (exitWith ExitSuccess))) ]
