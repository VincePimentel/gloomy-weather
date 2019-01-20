vince = User.create(
  username: "vince",
  email: "vince@email.com",
  password: "123456"
)

vince_preset = Preset.create(
  title: "Silence",
  description: "Default settings",
  volume: {
    rain: 0,
    river: 0,
    wave: 0,
    wind: 0,
    leaf: 0,
    thunder: 0,
    fire: 0,
    bird: 0,
    cricket: 0,
    crowd: 0,
    train: 0,
    white: 0,
    pink: 0,
    brown: 0
  }
)

vince.presets << vince_preset

alice = User.create(
  username: "alice",
  email: "alice@email.com",
  password: "123456"
)

alice_preset = Preset.create(
  title: "Focus",
  description: "Mostly sounds of waves",
  volume: {
    rain: 10,
    river: 0,
    wave: 40,
    wind: 0,
    leaf: 0,
    thunder: 10,
    fire: 30,
    bird: 0,
    cricket: 0,
    crowd: 0,
    train: 0,
    white: 0,
    pink: 0,
    brown: 0
  }
)

alice.presets << alice_preset
