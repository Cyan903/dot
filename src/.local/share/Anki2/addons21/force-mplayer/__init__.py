import aqt.sound

from aqt import mw, gui_hooks
from aqt.sound import SimpleMplayerSlaveModePlayer, av_player

# sudo pacman -S mplayer
# https://www.reddit.com/r/Anki/comments/ze3jo1/comment/iz98z0g

def force_mplayer():
    av_player.players[0].shutdown()
    aqt.sound.mpvManager = None
    mplayer = SimpleMplayerSlaveModePlayer(mw.taskman, mw.col.media.dir())
    av_player.players[0] = mplayer

gui_hooks.profile_did_open.append(force_mplayer)

