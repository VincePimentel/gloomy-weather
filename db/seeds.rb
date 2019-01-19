vince = User.create(
  username: "vince",
  email: "vince@email.com",
  password: "123456"
)

vince_preset = Preset.create(
  title: "A Rainy Day",
  description: "A preset containing rain and thunder.",
  volume: {
    rain: 7,
    river: 0,
    wave: 3,
    wind: 0,
    leaf: 0,
    thunder: 4,
    fire: 4,
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
