import Service from 'resource:///com/github/Aylur/ags/service.js'
import Utils from 'resource:///com/github/Aylur/ags/utils.js'

class BrightnessService extends Service {
    static {
        Service.register(
            this,
            {
                'screen-changed': ['float'],
            },
            {
                'screen-value': ['float', 'rw'],
            },
        )
    }

    #interface = Utils.exec("sh -c 'ls -w1 /sys/class/backlight | head -1'")
    #screenValue = 0
    #max = Number(Utils.exec('brightnessctl max'))

    get screen_value() {
        return this.#screenValue
    }

    set screen_value(percent) {
        percent = Math.max(0, Math.min(1, percent))
        Utils.execAsync(`brightnessctl set ${percent * 100}% -q`)
    }

    constructor() {
        super()
        const brightness = `/sys/class/backlight/${this.#interface}/brightness`
        Utils.monitorFile(brightness, () => this.#onChange())
        this.#onChange()
    }

    #onChange() {
        this.#screenValue = Number(Utils.exec('brightnessctl get')) / this.#max
        this.changed('screen-value')
        this.emit('screen-changed', this.#screenValue)
    }

    connect(event = 'screen-changed', callback) {
        return super.connect(event, callback)
    }
}

export default new BrightnessService()

