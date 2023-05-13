import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers  -- Flutuar janelas
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Util.EZConfig -- Teclas
import XMonad.Util.Loggers -- Titulo das janelas no xmobar
import XMonad.Util.Ungrab

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Renamed -- Renomear layouts
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders


-- import XMonad.Layout.ToggleLayouts

import XMonad.Hooks.EwmhDesktops

import XMonad.Actions.ToggleFullFloat

import System.IO

-- float
import qualified Data.Map as M
import qualified XMonad.StackSet as W

import XMonad.Actions.FloatKeys -- mover janelas

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . toggleFullFloatEwmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar -d ~/.config/xmonad/xmobarrc.hs" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig
  where
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    toggleStrutsKey XConfig{ modMask = m } = (m, xK_b)

myTerminal :: String
myTerminal = "alacritty"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myConfig = def
    { modMask    = mod4Mask      -- Rebind Mod to the Super key
    , layoutHook =  avoidStruts . smartBorders $ myLayout      -- Use custom layouts
    -- , manageHook = manageDocks <+> myManageHook  -- Match on certain windows
    , manageHook = myManageHook  -- Match on certain windows
    , focusFollowsMouse = myFocusFollowsMouse
    , borderWidth = 2
    , focusedBorderColor = "#4fd3ff"
	  , normalBorderColor  = "#222222"
    }
  `additionalKeysP`
    [ ("M-p"  , spawn "dmenu_run  -y 20 -h 18 -nf '#000' -nb '#bd93f9' -sf '#1d2021' -sb '#ff79c6' -fn 'JetBrainsMono Nerd Font-9:normal' -p 'dmenu2'")
    , ("M-C-s", unGrab *> spawn "maim -uo ~/Imagens/$(date +%d-%m-%y_%H:%M:%S)_maim.png"                                                          )
    , ("M-i"  , spawn "qutebrowser"                                                                                                               )
    , ("M-<Return>", spawn myTerminal                                                                                                             )
    , ("M-c", kill                                                                                                                                )
    , ("M-s", withFocused toggleFloat)
    , ("M-h", sendMessage Shrink)
    , ("M-l", sendMessage Expand)
    , ("M-f", withFocused toggleFullFloat)
	-- Controle para mover Janela
	  , ("C-M1-h", withFocused (keysMoveWindow (-20,0)))
    , ("C-M1-l", withFocused (keysMoveWindow (20,0)))
    , ("C-M1-k", withFocused (keysMoveWindow (0,-20)))
    , ("C-M1-j", withFocused (keysMoveWindow (0,20)))
	-- Redimencionar Janelas
	  , ("M-M1-h", withFocused (keysResizeWindow (20,0) (1,0)))
    , ("M-M1-l", withFocused (keysResizeWindow (-20,0) (1,0)))
    , ("M-M1-k", withFocused (keysResizeWindow (0,20) (0,0)))
    , ("M-M1-j", withFocused (keysResizeWindow (0,-20) (0,0)))
    , ("M-z", sendMessage MirrorShrink)
    , ("M-a", sendMessage MirrorExpand)
  -- Ampitude Som
    , ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
    , ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
    ]

-- Float key
toggleFloat :: Window -> X ()
toggleFloat w =
  windows
    ( \s ->
        if M.member w (W.floating s)
          then W.sink w s
          else (W.float w (W.RationalRect (1 / 3) (1 / 4) (1 / 2) (1 / 2)) s)
    )

myManageHook :: ManageHook
myManageHook = composeAll
    [ isFullscreen        --> doFullFloat
    , className =? "Gimp" --> doFloat
    -- , className =? "Firefox" --> doFloat
    , isDialog            --> doFloat
    , manageDocks
    ]

myLayout = ResizableTall 1 (3/100) (1/2) [] ||| tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
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
    lowWhite = xmobarColor "#696969" ""
