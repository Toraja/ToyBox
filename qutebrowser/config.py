# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Name of the session to save by default. If this is set to null, the
# session which was last loaded is saved.
# Type: SessionName
c.session.default_name = None

# Load a restored tab as soon as it takes focus.
# Type: Bool
c.session.lazy_restore = True

# When to use Chromium's low-end device mode. This improves the RAM
# usage of renderer processes, at the expense of performance.
# Type: String
# Valid values:
#   - always: Always use low-end device mode.
#   - auto: Decide automatically (uses low-end mode with < 1 GB available RAM).
#   - never: Never use low-end device mode.
c.qt.low_end_device_mode = 'auto'

# Always restore open sites when qutebrowser is reopened.
# Type: Bool
c.auto_save.session = True

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Timeout (in milliseconds) for partially typed key bindings. If the
# current input forms only partial matches, the keystring will be
# cleared after this time.
# Type: Int
c.input.partial_timeout = 0

# Enable smooth scrolling for web pages. Note smooth scrolling does not
# work with the `:scroll-px` command.
# Type: Bool
c.scrolling.smooth = False

# How to behave when the last tab is closed.
# Type: String
# Valid values:
#   - ignore: Don't do anything.
#   - blank: Load a blank page.
#   - startpage: Load the start page.
#   - default-page: Load the default page.
#   - close: Close the window.
c.tabs.last_close = 'close'

# Position of new tabs which are not opened from another tab. See
# `tabs.new_position.stacking` for controlling stacking behavior.
# Type: NewTabPosition
# Valid values:
#   - prev: Before the current tab.
#   - next: After the current tab.
#   - first: At the beginning.
#   - last: At the end.
c.tabs.new_position.unrelated = 'last'

# Default zoom level.
# Type: Perc
c.zoom.default = '125%'

# Available zoom levels.
# Type: List of Perc
c.zoom.levels = ['25%', '33%', '50%', '67%', '75%', '90%', '100%', '110%', '125%', '150%', '175%', '200%', '250%', '300%', '400%', '500%']

c.tabs.background = True
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'l': 'https://www.ldoceonline.com/dictionary/{}',
    't': 'https://www.thesaurus.com/browse/{}?s=t'
}

# Bindings for normal mode
config.bind('<Ctrl+n>', 'tab-next')
config.bind('<Ctrl+p>', 'tab-prev')
config.bind('<Alt+p>', 'tab-move -')
config.bind('<Alt+n>', 'tab-move +')
config.unbind('J')
config.unbind('K')
config.bind(';k', 'hint all delete')
config.bind(';p', 'hint links run :open -p {hint-url}')
config.unbind('<Ctrl+q>')
config.bind('<Ctrl+Shift+q>', 'quit')
config.unbind('<Ctrl+h>')

# Bindings for command mode
config.bind('<Alt+h>', 'rl-backward-kill-word', mode='command')
config.bind('<Ctrl+d>', 'rl-delete-char', mode='command')
config.bind('<Ctrl+i>', 'completion-item-focus next', mode='command')
config.bind('<Ctrl+n>', 'completion-item-focus --history next', mode='command')
config.bind('<Ctrl+p>', 'completion-item-focus --history prev', mode='command')

# Bindings for insert mode
config.unbind('<Ctrl+e>', mode='insert')
config.bind('<Alt+e>', 'open-editor', mode='insert')
