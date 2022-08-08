import XMonad

import System.Exit
import XMonad.Core
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns

import XMonad.Hooks.EwmhDesktops


import qualified XMonad.StackSet as W




-- ghc -package xmonad ~/.xmonad/xmonad.hs
-- https://gist.github.com/micrub/aeebe7eb4d2df9e5e203e76a0fd89542
-- https://github.com/xmonad/xmonad/blob/2e6312776bd277c775c32e35f9c763d3858e32a4/src/XMonad/Config.hs#L184
-- https://xmonad.org/TUTORIAL.html
{-

# xmonad default key bindings

## Action key bindings

| Key binding                                             | Action                                                                        |
|---------------------------------------------------------|-------------------------------------------------------------------------------|
| <kbd>mod</kbd> - <kbd>shift</kbd>   - <kbd>slash</kbd>  | Run xmessage with a summary of the default keybindings (useful for beginners) |
| <kbd>mod</kbd> - <kbd>shift</kbd>   - <kbd>return</kbd> | Launch terminal                                                               |
| <kbd>mod</kbd> - <kbd>p</kbd>                           | Launch dmenu                                                                  |
| <kbd>mod</kbd> - <kbd>shift</kbd>   - <kbd>p</kbd>      | Launch gmrun                                                                  |
| <kbd>mod</kbd> - <kbd>shift</kbd>   - <kbd>c</kbd>      | Close the focused window                                                      |
| <kbd>mod</kbd> - <kbd>shift</kbd>   - <kbd>q</kbd>      | Quit xmonad                                                                   |
| <kbd>mod</kbd> - <kbd>q</kbd>                           | Restart xmonad                                                                |

## Movement key bindings

### Window Movement key bindings

| Key binding                                             | Action                                                                        |
|---------------------------------------------------------|-------------------------------------------------------------------------------|
| <kbd>mod</kbd> - <kbd>space</kbd>                       | Rotate through the available layout algorithms                                |
| <kbd>mod</kbd> - <kbd>shift</kbd>   - <kbd>space</kbd>  | Reset the layouts on the current workspace to default                         |
| <kbd>mod</kbd> - <kbd>n</kbd>                           | Resize viewed windows to the correct size                                     |
| <kbd>mod</kbd> - <kbd>tab</kbd>                         | Move focus to the next window                                                 |
| <kbd>mod</kbd> - <kbd>shift</kbd>   - <kbd>tab</kbd>    | Move focus to the previous window                                             |
| <kbd>mod</kbd> - <kbd>j</kbd>                           | Move focus to the next window                                                 |
| <kbd>mod</kbd> - <kbd>k</kbd>                           | Move focus to the previous window                                             |
| <kbd>mod</kbd> - <kbd>m</kbd>                           | Move focus to the master window                                               |
| <kbd>mod</kbd> - <kbd>return</kbd>                      | Swap the focused window and the master window                                 |
| <kbd>mod</kbd> - <kbd>shift</kbd>   - <kbd>j</kbd>      | Swap the focused window with the next window                                  |
| <kbd>mod</kbd> - <kbd>shift</kbd>   - <kbd>k</kbd>      | Swap the focused window with the previous window                              |
| <kbd>mod</kbd> - <kbd>h</kbd>                           | Shrink the master area                                                        |
| <kbd>mod</kbd> - <kbd>l</kbd>                           | Expand the master area                                                        |
| <kbd>mod</kbd> - <kbd>t</kbd>                           | Push window back into tiling                                                  |
| <kbd>mod</kbd> - <kbd>comma</kbd>                       | Increment the number of windows in the master area                            |
| <kbd>mod</kbd> - <kbd>period</kbd>                      | Deincrement the number of windows in the master area                          |

### Window Movement key and mouse button bindings
| Binding                                                 | Action                                                                        |
|---------------------------------------------------------|-------------------------------------------------------------------------------|
| <kbd>mod</kbd> - <kbd>button1</kbd>                     | Set the window to floating mode and move by dragging                          |
| <kbd>mod</kbd> - <kbd>button3</kbd>                     | Set the window to floating mode and resize by dragging                        |
| <kbd>mod</kbd> - <kbd>button2</kbd>                     | Raise the window to the top of the stack                                      |

### Workspace Movement key bindings

| Key binding                                             | Action                                                                        |
|---------------------------------------------------------|-------------------------------------------------------------------------------|
| <kbd>mod</kbd> - <kbd>[1..9]</kbd>                      | Switch to workspace N                                                         |
| <kbd>mod</kbd> - <kbd>shift</kbd>   - <kbd>[1..9]</kbd> | Move client to workspace N                                                    |

### Screen Movement key bindings
| Key binding                                             | Action                                                                        |
|---------------------------------------------------------|-------------------------------------------------------------------------------|
| <kbd>mod</kbd> - <kbd>{w,e,r}</kbd>                     | Switch to physical/Xinerama screens 1, 2, or 3|
| <kbd>mod</kbd> - <kbd>shift</kbd>   - <kbd>{w,e,r}</kbd>| Move client to screen 1, 2, or 3              |
-}

-- TODO: custom bars
-- barSpawner :: ScreenId -> IO StatusBarConfig
-- barSpawner 0 = pure $ xmobarScreenN 0
-- barSpawner 1 = pure $ xmobarScreenN 1
-- barSpawner _ = mempty -- nothing on the rest of the screens

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig


myStartupHook :: X ()
myStartupHook = do
  spawn "bash /home/bollu/.screenlayout/default.sh"
  spawn "bash /home/bollu/.xmonad/default.sh"

myConfig = def
    { modMask    = mod4Mask      -- Rebind Mod to the Super key
    , layoutHook = myLayout      -- Use custom layouts
    , manageHook = myManageHook  -- Match on certain windows
    , startupHook = myStartupHook
    , borderWidth = 4
    , normalBorderColor = "#cccccc"
    , focusedBorderColor = "#E91E63"
    , terminal = "alacritty"
    }
  `additionalKeysP` (
    -- [ ("M-S-z", spawn "xscreensaver-command -lock")
    -- , ("M-C-s", unGrab *> spawn "scrot -s"        )
    -- , ("M-f"  , spawn "firefox"                   )
    -- ] ++
    [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
         | (key, scr)  <- zip "wer" [1,0,2] -- was [0..] *** change to match your screen order ***
         , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
    ] ++
    [ -- remap keys
      ("M-q", kill) -- close current UI
      , ("M-S-q", kill) -- close current UI
      , ("M-S-]", spawn "pkill -u $USER") -- close current UI
      , ("M-S-e", io (exitWith ExitSuccess)) -- close current UI
      , ("M-r", spawn "ghc -package xmonad ~/.xmonad/xmonad.hs -o ~/.xmonad/xmonad-x86_64-linux && ~/.xmonad/xmonad-x86_64-linux --restart") -- reload
      , ("M-S-]", spawn "ghc -package xmonad ~/.xmonad/xmonad.hs -o ~/.xmonad/xmonad-x86_64-linux && ~/.xmonad/xmonad-x86_64-linux --restart") -- reload
      , ("M-S-r", spawn "ghc -package xmonad ~/.xmonad/xmonad.hs -o ~/.xmonad/xmonad-x86_64-linux && ~/.xmonad/xmonad-x86_64-linux --restart") -- reload
      , ("M-d", spawn "rofi -show run") -- dmenu
      , ("M-<Return>", spawn "alacritty") -- alacritty
    ]) 
    `removeKeysP` ["M-S-p", "M-p", "M-/"]

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , isDialog            --> doFloat
    ]

-- spacingRaw smartBorder (Border 10 10 10 10) screenBorderEnabled (Border 10 10 10 10) True $ rawLayout
myLayout = spacing 20 $ rawLayout 
  where
    rawLayout = tiled ||| Mirror tiled ||| (spacing 40 $ Full) -- ||| threeCol
    -- threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 10
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
