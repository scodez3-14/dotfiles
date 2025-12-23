import App from 'resource:///com/github/Aylur/ags/app.js'
import Widget from 'resource:///com/github/Aylur/ags/widget.js'

import Audio from 'resource:///com/github/Aylur/ags/service/audio.js'
import Network from 'resource:///com/github/Aylur/ags/service/network.js'
import Bluetooth from 'resource:///com/github/Aylur/ags/service/bluetooth.js'
import Brightness from './services/brightness.js'
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js'

// Helper function for toggles
const Toggle = (label, service, prop, toggle) =>
  Widget.Box({
    spacing: 10,
    children: [
      Widget.Label({ label, hexpand: true }),
      Widget.Switch({
        active: service[prop],
        onActivate: () => toggle(),
      }),
    ],
  })

// Define the Control Center window
const ControlCenter = Widget.Window({
  name: 'control-center',
  anchor: ['top', 'right'],
  margins: [10, 10, 10, 10],
  visible: false,
  child: Widget.Box({
    vertical: true,
    spacing: 14,
    class_name: 'panel',
    children: [

      Widget.Label({
        label: 'Quick Settings',
        class_name: 'title',
      }),

      Toggle('Wi-Fi', Network.wifi, 'enabled', () => Network.toggleWifi()),
      Toggle('Bluetooth', Bluetooth, 'enabled', () => Bluetooth.toggle()),

      Widget.Label({ label: 'Volume' }),
      Widget.Slider({
        value: Audio.speaker.volume,
        onChange: ({ value }) => Audio.speaker.volume = value,
      }),

      Widget.Label({ label: 'Brightness' }),
      Widget.Slider({
        value: Brightness.bind('screen-value'),
        onChange: ({ value }) => Brightness.screen_value = value,
      }),

      Widget.Box({
        vertical: true,
        spacing: 6,
        children: [
          Widget.Label({
            label: Mpris.players[0]?.track_title || 'No music playing',
          }),
          Widget.Label({
            label: Mpris.players[0]?.artist || '',
            class_name: 'subtext',
          }),
        ],
      }),
    ],
  }),
})

App.config({
  style: './style.css',
  windows: [ControlCenter],
})

