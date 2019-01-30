vince = User.create(
  username: "vince",
  password: "123456"
)

vince.presets << Preset.create(
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
  womb: 0,
  brown: 0
)
