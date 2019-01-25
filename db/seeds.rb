vince = User.create(
  username: "vince",
  password: "123456"
)

preset_1 = Preset.create(
  title: "My preset",
  description: "Hello world!",
  rain: 10,
  thunder: 40,
  beach: 10,
  river: 0,
  garden: 10,
  fire: 0,
  bird: 20,
  night: 0,
  train: 10,
  cafe: 0,
  pink: 0,
  brown: 0
)

vince.presets << preset_1

alice = User.create(
  username: "alice",
  password: "123456"
)

preset_2 = Preset.create(
  title: "Rainy day",
  description: "Hi world!",
  rain: 40,
  thunder: 0,
  beach: 0,
  river: 0,
  garden: 20,
  fire: 0,
  bird: 10,
  night: 0,
  train: 10,
  cafe: 0,
  pink: 0,
  brown: 0
)

alice.presets << preset_2
