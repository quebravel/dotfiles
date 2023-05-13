Config { overrideRedirect = False
       , font     = "xft:JetBrainsMono-9"
       , bgColor  = "#262626"
       , fgColor  = "#bd93f9"
       , position = TopW L 100
       -- , border = NoBorder
       -- , alpha = 255
       , textOffset = -1
       -- , iconOffset = -1
       -- , pickBroadest = False
       , persistent = False
       , hideOnStart = False
       , lowerOnStart = True
       -- , iconRoot = "."
       -- , allDesktops = True
       , commands = [ Run Weather "SBBE"
                        [ "--template", "<weather> <tempC>°C"
                        , "-L", "15"
                        , "-H", "27"
                        , "--low"   , "lightblue"
                        , "--normal", "#f8f8f2"
                        , "--high"  , "#ff6161"
                        ] 36000
                    , Run Cpu
                        [ "-L", "3"
                        , "-H", "50"
                        , "--high"  , "red"
                        , "--normal", "green"
                        ] 10
                    , Run Alsa "default" "Master"
                        [ "--template", "<volumestatus>"
                        , "--suffix"  , "True"
                        , "--"
                        , "--on", ""
                        ]
                    , Run Memory ["--template", "Mem: <usedratio>%"] 10
                    , Run Swap [] 10
                    , Run Date "%a %Y-%m-%d <fc=#8be9fd>%H:%M</fc>" "date" 10
                    , Run XMonadLog
                    ]
       , sepChar  = "%"
       , alignSep = "}{"
       , template = "%XMonadLog% }{ %alsa:default:Master%  <fc=#ff79c6>•</fc> %cpu% <fc=#ff79c6>•</fc> %memory% * %swap% <fc=#ff79c6>•</fc> %SBBE% <fc=#ff79c6>•</fc> %date% "
       }

