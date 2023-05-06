# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

config.load_autoconfig()

font_name = "10pt tamzenforpowerline"

c.fonts.tabs.selected = font_name
c.fonts.tabs.unselected = font_name
c.fonts.statusbar = font_name
c.fonts.messages.info = font_name
c.fonts.downloads = c.fonts.statusbar
c.fonts.prompts = font_name
c.fonts.keyhint = c.fonts.messages.info
c.fonts.messages.warning = c.fonts.messages.info
c.fonts.messages.error = c.fonts.messages.info
c.fonts.completion.entry = font_name
c.fonts.completion.category = c.fonts.statusbar
#c.fonts.hints = "13px tamzenforpowerline"

# geral
c.new_instance_open_target = "tab"
c.tabs.background = True
c.downloads.location.directory = '$HOME/Downloads'
#  c.downloads.location.directory = "C:\\Users\\Jonatas\\Downloads"
c.spellcheck.languages = ["pt-BR"]
c.content.headers.accept_language = 'pt-BR,pt'
c.tabs.show = 'always' #multiple,never,always,switching
c.url.default_page = "https://start.duckduckgo.com/"
c.url.start_pages = "https://start.duckduckgo.com/"
c.tabs.select_on_remove = "prev"
c.content.notifications.enabled = False
c.content.autoplay = False
c.content.geolocation = True
c.tabs.mode_on_change = "persist"
c.tabs.title.format = "{index}: {current_title} {audio}"
c.colors.webpage.preferred_color_scheme = 'dark'
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.grayscale.all = False
c.colors.webpage.preferred_color_scheme = 'dark'
c.colors.webpage.darkmode.policy.page = 'smart'
c.colors.webpage.darkmode.policy.images = 'smart'
c.colors.webpage.darkmode.threshold.background = 205

#  c.colors.webpage.bg = "#262626"
#  c.content.blocking.hosts.lists.append( str(config.configdir) + "/blockedHosts")
c.scrolling.bar = "when-searching"
c.scrolling.smooth = False
# instalar adblock com o comando pip install adblock
c.content.blocking.method = "adblock"

# plugins
# https://gitlab.com/jgkamat/jblock
#  import sys, os
#  sys.path.append(os.path.join(sys.path[0], 'jblock'))
#  config.source("jblock/jblock/integrations/qutebrowser.py")

# config.source('solarizedark.py')
config.source('gruvbox.py')
config.source('aliases_search.py')
config.source('bindings_commands.py')
