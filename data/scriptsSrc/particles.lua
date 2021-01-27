scaleFactor = 2
featherSizeLarge = 1.35 * scaleFactor
featherSizeMedium = 0.5 * scaleFactor
featherSizeSmall = 0.1 * scaleFactor
lifeTimeRandom = 1
featherSpinSpeed = 5
confettiMinVel = 150
confettiMaxVel = 220
confettiMinAngleVel = -8
confettiMaxAngleVel = 8
confettiMinScaleBegin = 1.4
confettiMaxScaleBegin = 1.9
confettiMinScaleEnd = 1.4
confettiMaxScaleEnd = 1.9
confettiMinAngleEmitter = 130
confettiMaxAngleEmitter = 175
confettiLifeTime = 45
confettiGravityX = 0
confettiGravityY = 0
confettiMinAngle = -180
confettiMaxAngle = 180
levelParticles = {
  "confettisBlue",
  "confettisGreen",
  "confettisSilver",
  "confettisBlueGreen",
  "confettisBlueSilver",
  "confettisGreenSilver",
  "confettisBlueGreenSilver",
  "theme15rain"
}
particles = {
  smokeBuff = {
    sprites = {
      "SMOKE_CLOUD_1",
      "SMOKE_CLOUD_2",
      "SMOKE_CLOUD_3",
      "SMOKE_CLOUD_4",
      "SMOKE_CLOUD_5",
      "SMOKE_CLOUD_6"
    },
    animation = "lifeTime",
    sheet = "INGAME_BIRDS_1",
    emitter_circle = {minVel = 0, maxVel = 0},
    minAngleVel = -2,
    maxAngleVel = 2,
    minScaleBegin = 1.5,
    maxScaleBegin = 1.5,
    minScaleEnd = 1.5,
    maxScaleEnd = 1.5,
    lifeTime = 0.35,
    gravityX = 0,
    gravityY = 0
  },
  bigSmokeBuff = {
    sprites = {
      "SMOKE_CLOUD_1",
      "SMOKE_CLOUD_2",
      "SMOKE_CLOUD_3",
      "SMOKE_CLOUD_4",
      "SMOKE_CLOUD_5",
      "SMOKE_CLOUD_6"
    },
    animation = "lifeTime",
    sheet = "INGAME_BIRDS_1",
    emitter_circle = {minVel = 0, maxVel = 0},
    minAngleVel = -2,
    maxAngleVel = 2,
    minScaleBegin = 6,
    maxScaleBegin = 6,
    minScaleEnd = 4.75,
    maxScaleEnd = 4.75,
    lifeTime = 0.35,
    gravityX = 0,
    gravityY = 0
  },
  explosionBuff = {
    sprites = {
      "EXPLOSION_CLOUD_1",
      "EXPLOSION_CLOUD_2",
      "EXPLOSION_CLOUD_3",
      "EXPLOSION_CLOUD_4",
      "EXPLOSION_CLOUD_5",
      "EXPLOSION_CLOUD_6"
    },
    animation = "lifeTime",
    sheet = "INGAME_BIRDS_1",
    emitter_circle = {minVel = 0, maxVel = 0},
    minAngleVel = -2,
    maxAngleVel = 2,
    minScaleBegin = 2,
    maxScaleBegin = 2,
    minScaleEnd = 1.75,
    maxScaleEnd = 1.75,
    lifeTime = 0.3,
    gravityX = 0,
    gravityY = 0
  },
  bigExplosionBuff = {
    sprites = {
      "EXPLOSION_CLOUD_1",
      "EXPLOSION_CLOUD_2",
      "EXPLOSION_CLOUD_3",
      "EXPLOSION_CLOUD_4",
      "EXPLOSION_CLOUD_5",
      "EXPLOSION_CLOUD_6"
    },
    animation = "lifeTime",
    sheet = "INGAME_BIRDS_1",
    emitter_circle = {minVel = 0, maxVel = 0},
    minAngleVel = -2,
    maxAngleVel = 2,
    minScaleBegin = 8,
    maxScaleBegin = 8,
    minScaleEnd = 6.75,
    maxScaleEnd = 6.75,
    lifeTime = 0.3,
    gravityX = 0,
    gravityY = 0
  },
  woodenBuff = {
    sprites = {
      "WOOD_PARTICLE_1",
      "WOOD_PARTICLE_1",
      "WOOD_PARTICLE_1"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -100,
      maxVelX = 100,
      minVelY = -100,
      maxVelY = 100
    },
    minAngleVel = -8,
    maxAngleVel = 8,
    minScaleBegin = 1.8,
    maxScaleBegin = 2.7,
    minScaleEnd = 0.3,
    maxScaleEnd = 0.5,
    lifeTime = 1.7,
    gravityX = 0,
    gravityY = 120
  },
  rockBuff = {
    sprites = {
      "ROCK_PARTICLE_1",
      "ROCK_PARTICLE_2",
      "ROCK_PARTICLE_3"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -120,
      maxVelX = 120,
      minVelY = -120,
      maxVelY = 120
    },
    minAngleVel = -7,
    maxAngleVel = 7,
    minScaleBegin = 1.7,
    maxScaleBegin = 2.2,
    minScaleEnd = 0.2,
    maxScaleEnd = 0.4,
    lifeTime = 1.3,
    gravityX = 0,
    gravityY = 150
  },
  lightBuff = {
    sprites = {
      "LIGHT_PARTICLE_1",
      "LIGHT_PARTICLE_2",
      "LIGHT_PARTICLE_3",
      "LIGHT_PARTICLE_4",
      "LIGHT_PARTICLE_5"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -120,
      maxVelX = 120,
      minVelY = -120,
      maxVelY = 120
    },
    minAngleVel = -8,
    maxAngleVel = 8,
    minScaleBegin = 1.2,
    maxScaleBegin = 1.5,
    minScaleEnd = 0.2,
    maxScaleEnd = 0.3,
    lifeTime = 1.4,
    gravityX = 0,
    gravityY = 200
  },
  blueBuff = {
    sprites = {
      "BLUE_FEATHER_1",
      "BLUE_FEATHER_2",
      "BLUE_FEATHER_3",
      "BLUE_FEATHER_1",
      "BLUE_FEATHER_2",
      "BLUE_FEATHER_3",
      "SMOKE_BUFF_1",
      "SMOKE_BUFF_2"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -50,
      maxVelX = 50,
      minVelY = -50,
      maxVelY = 50
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium,
    maxScaleBegin = featherSizeLarge,
    minScaleEnd = featherSizeSmall,
    maxScaleEnd = featherSizeMedium,
    lifeTime = lifeTimeRandom,
    gravityX = 0,
    gravityY = -10
  },
  redBuff = {
    sprites = {
      "RED_FEATHER_1",
      "RED_FEATHER_2",
      "RED_FEATHER_3",
      "RED_FEATHER_1",
      "RED_FEATHER_2",
      "RED_FEATHER_3",
      "SMOKE_BUFF_1",
      "SMOKE_BUFF_2"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -50,
      maxVelX = 50,
      minVelY = -50,
      maxVelY = 50
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium,
    maxScaleBegin = featherSizeLarge,
    minScaleEnd = featherSizeSmall,
    maxScaleEnd = featherSizeMedium,
    lifeTime = lifeTimeRandom,
    gravityX = 0,
    gravityY = -10
  },
  bigBrotherBuff = {
    sprites = {
      "BIGBROTHER_FEATHER_1",
      "BIGBROTHER_FEATHER_2",
      "BIGBROTHER_FEATHER_3",
      "BIGBROTHER_FEATHER_1",
      "BIGBROTHER_FEATHER_2",
      "BIGBROTHER_FEATHER_3",
      "SMOKE_BUFF_1",
      "SMOKE_BUFF_2"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -50,
      maxVelX = 50,
      minVelY = -50,
      maxVelY = 50
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium,
    maxScaleBegin = featherSizeLarge,
    minScaleEnd = featherSizeSmall,
    maxScaleEnd = featherSizeMedium,
    lifeTime = lifeTimeRandom,
    gravityX = 0,
    gravityY = -10
  },
  orangeBuff = {
    sprites = {
      "ORANGE_FEATHER_1",
      "ORANGE_FEATHER_2",
      "ORANGE_FEATHER_3",
      "ORANGE_FEATHER_1",
      "ORANGE_FEATHER_2",
      "ORANGE_FEATHER_3",
      "SMOKE_BUFF_1",
      "SMOKE_BUFF_2"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -50,
      maxVelX = 50,
      minVelY = -50,
      maxVelY = 50
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium,
    maxScaleBegin = featherSizeLarge,
    minScaleEnd = featherSizeSmall,
    maxScaleEnd = featherSizeMedium,
    lifeTime = lifeTimeRandom,
    gravityX = 0,
    gravityY = -10
  },
  starBuff = {
    sprites = {
      "EPISODEG_STAR"
    },
    sheet = "",
    emitter_box = {
      minVelX = -55,
      maxVelX = 55,
      minVelY = -55,
      maxVelY = 55
    },
    minAngleVel = -5,
    maxAngleVel = 5,
    minScaleBegin = 0.1,
    maxScaleBegin = 0.1,
    minScaleEnd = 0.2,
    maxScaleEnd = 0.4,
    lifeTime = lifeTimeRandom,
    gravityX = 1,
    gravityY = 1
  },
  greenBuff = {
    sprites = {
      "GREEN_FEATHER_1",
      "GREEN_FEATHER_2",
      "GREEN_FEATHER_3",
      "GREEN_FEATHER_1",
      "GREEN_FEATHER_2",
      "GREEN_FEATHER_3",
      "SMOKE_BUFF_1",
      "SMOKE_BUFF_2"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -50,
      maxVelX = 50,
      minVelY = -50,
      maxVelY = 50
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium,
    maxScaleBegin = featherSizeLarge,
    minScaleEnd = featherSizeSmall,
    maxScaleEnd = featherSizeMedium,
    lifeTime = lifeTimeRandom,
    gravityX = 0,
    gravityY = -10
  },
  boomerangBuff = {
    sprites = {
      "BOOMERANG_FEATHER_1",
      "BOOMERANG_FEATHER_2",
      "BOOMERANG_FEATHER_3",
      "BOOMERANG_FEATHER_1",
      "BOOMERANG_FEATHER_2",
      "BOOMERANG_FEATHER_3",
      "SMOKE_BUFF_1",
      "SMOKE_BUFF_2"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -50,
      maxVelX = 50,
      minVelY = -50,
      maxVelY = 50
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium,
    maxScaleBegin = featherSizeLarge,
    minScaleEnd = featherSizeSmall,
    maxScaleEnd = featherSizeMedium,
    lifeTime = lifeTimeRandom,
    gravityX = 0,
    gravityY = -10
  },
  blackBuff = {
    sprites = {
      "BLACK_FEATHER_1",
      "BLACK_FEATHER_2",
      "BLACK_FEATHER_3"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -50,
      maxVelX = 50,
      minVelY = -50,
      maxVelY = 50
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium,
    maxScaleBegin = featherSizeLarge,
    minScaleEnd = featherSizeSmall,
    maxScaleEnd = featherSizeMedium,
    lifeTime = lifeTimeRandom,
    gravityX = 0,
    gravityY = -10
  },
  yellowBuff = {
    sprites = {
      "YELLOW_FEATHER_1",
      "YELLOW_FEATHER_2",
      "YELLOW_FEATHER_3",
      "YELLOW_FEATHER_1",
      "YELLOW_FEATHER_2",
      "YELLOW_FEATHER_3",
      "SMOKE_BUFF_1",
      "SMOKE_BUFF_2"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -50,
      maxVelX = 50,
      minVelY = -50,
      maxVelY = 50
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium,
    maxScaleBegin = featherSizeLarge,
    minScaleEnd = featherSizeSmall,
    maxScaleEnd = featherSizeMedium,
    lifeTime = lifeTimeRandom,
    gravityX = 0,
    gravityY = -10
  },
  eggShells = {
    sprites = {
      "EGG_SHELL_1",
      "EGG_SHELL_2",
      "EGG_SHELL_3"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -60,
      maxVelX = 60,
      minVelY = -60,
      maxVelY = 60
    },
    minAngleVel = -4,
    maxAngleVel = 4,
    minScaleBegin = 0.8,
    maxScaleBegin = 1.3,
    minScaleEnd = 0.5,
    maxScaleEnd = 0.8,
    lifeTime = 1.5,
    gravityX = 0,
    gravityY = -20
  },
  explosion = {
    sprites = {"EXPLOSION"},
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = 0,
      maxVelX = 0,
      minVelY = 0,
      maxVelY = 0
    },
    minAngleVel = 11,
    maxAngleVel = 11,
    minScaleBegin = 2.5,
    maxScaleBegin = 2.5,
    minScaleEnd = 0,
    maxScaleEnd = 0,
    lifeTime = 0.25,
    gravityX = 0,
    gravityY = 0
  },
  bombBirdTrail = {
    sprites = {
      "EXPLOSION_CLOUD_1"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = 0,
      maxVelX = 0,
      minVelY = 0,
      maxVelY = 0
    },
    minAngleVel = -2,
    maxAngleVel = 2,
    minScaleBegin = 2,
    maxScaleBegin = 2,
    minScaleEnd = 0.1,
    maxScaleEnd = 0.2,
    lifeTime = 0.3,
    gravityX = 0,
    gravityY = 0
  },
  bomberBirdTrail = {
    sprites = {
      "GREEN_FEATHER_1",
      "GREEN_FEATHER_2",
      "GREEN_FEATHER_3"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = 0,
      maxVelX = 0,
      minVelY = 0,
      maxVelY = 0
    },
    minAngleVel = -2,
    maxAngleVel = 2,
    minScaleBegin = 1,
    maxScaleBegin = 1,
    minScaleEnd = 0.1,
    maxScaleEnd = 0.2,
    lifeTime = 0.3,
    gravityX = 0,
    gravityY = 0
  },
  redBirdTrail = {
    sprites = {
      "RED_FEATHER_1",
      "RED_FEATHER_2",
      "RED_FEATHER_3"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = 0,
      maxVelX = 0,
      minVelY = 0,
      maxVelY = 0
    },
    minAngleVel = -2,
    maxAngleVel = 2,
    minScaleBegin = 1,
    maxScaleBegin = 1,
    minScaleEnd = 0.1,
    maxScaleEnd = 0.2,
    lifeTime = 0.3,
    gravityX = 0,
    gravityY = 0
  },
  blueBirdTrail = {
    sprites = {
      "BLUE_FEATHER_1",
      "BLUE_FEATHER_2",
      "BLUE_FEATHER_3"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = 0,
      maxVelX = 0,
      minVelY = 0,
      maxVelY = 0
    },
    minAngleVel = -2,
    maxAngleVel = 2,
    minScaleBegin = 1,
    maxScaleBegin = 1,
    minScaleEnd = 0.1,
    maxScaleEnd = 0.2,
    lifeTime = 0.3,
    gravityX = 0,
    gravityY = 0
  },
  yellowBirdTrail = {
    sprites = {
      "YELLOW_FEATHER_1",
      "YELLOW_FEATHER_2",
      "YELLOW_FEATHER_3"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = 0,
      maxVelX = 0,
      minVelY = 0,
      maxVelY = 0
    },
    minAngleVel = -2,
    maxAngleVel = 2,
    minScaleBegin = 1,
    maxScaleBegin = 1,
    minScaleEnd = 0.1,
    maxScaleEnd = 0.2,
    lifeTime = 0.3,
    gravityX = 0,
    gravityY = 0
  },
  mightyEagleParticles = {
    sprites = {
      "GREEN_FEATHER_1",
      "GREEN_FEATHER_2",
      "BLACK_FEATHER_1",
      "BLACK_FEATHER_2",
      "BLACK_FEATHER_3"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -50,
      maxVelX = 50,
      minVelY = -50,
      maxVelY = 50
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium * 2,
    maxScaleBegin = featherSizeLarge * 2,
    minScaleEnd = featherSizeSmall * 2,
    maxScaleEnd = featherSizeMedium * 2,
    lifeTime = lifeTimeRandom * 3,
    gravityX = 20,
    gravityY = -10
  },
  pumpkinBuff = {
    sprites = {
      "PARTICLE_PUMPKIN_1",
      "PARTICLE_PUMPKIN_2",
      "PARTICLE_PUMPKIN_3"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -300,
      maxVelX = 300,
      minVelY = -300,
      maxVelY = 300
    },
    minAngleVel = -8,
    maxAngleVel = 8,
    minScaleBegin = 0.825,
    maxScaleBegin = 1.75,
    minScaleEnd = 0.1,
    maxScaleEnd = 0.2,
    lifeTime = 1,
    gravityX = 0,
    gravityY = 600
  },
  batBuff = {
    sprites = {
      "BAT_FRAME_1",
      "BAT_FRAME_2",
      "BAT_FRAME_3",
      "BAT_FRAME_1",
      "BAT_FRAME_2",
      "BAT_FRAME_3",
      "BAT_FRAME_1",
      "BAT_FRAME_2",
      "BAT_FRAME_3",
      "BAT_FRAME_1",
      "BAT_FRAME_2",
      "BAT_FRAME_3",
      "BAT_FRAME_1",
      "BAT_FRAME_2",
      "BAT_FRAME_3",
      "BAT_FRAME_1",
      "BAT_FRAME_2"
    },
    animation = "lifeTime",
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -800,
      maxVelX = 800,
      minVelY = -800,
      maxVelY = 800
    },
    angleMinEmitter = -15,
    angleMaxEmitter = 15,
    minAngleVel = -2,
    maxAngleVel = 2,
    minScaleBegin = 0.85,
    maxScaleBegin = 2.25,
    minScaleEnd = 0.5,
    maxScaleEnd = 0.6,
    lifeTime = 1.05,
    gravityX = 0,
    gravityY = -600
  },
  flameBuff = {
    sprites = {
      "FLAME_PARTICLE_1",
      "FLAME_PARTICLE_2",
      "FLAME_PARTICLE_3",
      "FLAME_PARTICLE_4",
      "FLAME_PARTICLE_5",
      "FLAME_PARTICLE_6",
      "FLAME_PARTICLE_7",
      "FLAME_PARTICLE_8"
    },
    animation = "lifeTime",
    sheet = "INGAME_BIRDS_1",
    randomizeBirthPosition = false,
    emitter_box = {
      minVelX = -10,
      maxVelX = 10,
      minVelY = -10,
      maxVelY = 10
    },
    angleMinEmitter = -3,
    angleMaxEmitter = 3,
    minAngleVel = -0.25,
    maxAngleVel = 0.25,
    minScaleBegin = 1.75,
    maxScaleBegin = 2.25,
    minScaleEnd = 0.25,
    maxScaleEnd = 0.25,
    lifeTime = 0.5,
    gravityX = 0,
    gravityY = -600
  },
  amethystBreak = {
    sprites = {
      "AMETHYST_PARTICLE_1",
      "AMETHYST_PARTICLE_2",
      "AMETHYST_PARTICLE_3",
      "AMETHYST_PARTICLE_4"
    },
    sheet = "INGAME_BLOCKS_2",
    emitter_box = {
      minVelX = -100,
      maxVelX = 100,
      minVelY = -100,
      maxVelY = 100
    },
    minAngleVel = -8,
    maxAngleVel = 8,
    minScaleBegin = 1.5,
    maxScaleBegin = 1.8,
    minScaleEnd = 1.9,
    maxScaleEnd = 2.3,
    lifeTime = 3.5,
    gravityX = 0,
    gravityY = 500
  },
  rubyBreak = {
    sprites = {
      "RUBY_PARTICLE_1",
      "RUBY_PARTICLE_2",
      "RUBY_PARTICLE_3"
    },
    sheet = "INGAME_BLOCKS_2",
    emitter_box = {
      minVelX = -100,
      maxVelX = 100,
      minVelY = -100,
      maxVelY = 100
    },
    minAngleVel = -8,
    maxAngleVel = 8,
    minScaleBegin = 1.5,
    maxScaleBegin = 1.8,
    minScaleEnd = 1.9,
    maxScaleEnd = 2.3,
    lifeTime = 3.5,
    gravityX = 0,
    gravityY = 500
  },
  amberBreak = {
    sprites = {
      "AMBER_PARTICLE_1",
      "AMBER_PARTICLE_2",
      "AMBER_PARTICLE_3"
    },
    sheet = "INGAME_BLOCKS_2",
    emitter_box = {
      minVelX = -100,
      maxVelX = 100,
      minVelY = -100,
      maxVelY = 100
    },
    minAngleVel = -8,
    maxAngleVel = 8,
    minScaleBegin = 1.5,
    maxScaleBegin = 1.8,
    minScaleEnd = 1.9,
    maxScaleEnd = 2.3,
    lifeTime = 3.5,
    gravityX = 0,
    gravityY = 500
  },
  stalaktiteBreak = {
    sprites = {
      "STALAKTITE_PARTICLE_1",
      "STALAKTITE_PARTICLE_2",
      "STALAKTITE_PARTICLE_3",
      "STALAKTITE_PARTICLE_4"
    },
    sheet = "INGAME_BLOCKS_2",
    emitter_box = {
      minVelX = -60,
      maxVelX = 60,
      minVelY = -60,
      maxVelY = 60
    },
    minAngleVel = -8,
    maxAngleVel = 8,
    minScaleBegin = 0.7,
    maxScaleBegin = 1,
    minScaleEnd = 1.1,
    maxScaleEnd = 1.5,
    lifeTime = 3.5,
    gravityX = 0,
    gravityY = 500
  },
  stalaktiteWhiteBreak = {
    sprites = {
      "WHITE_STALAKTITE_PARTICLE_1",
      "WHITE_STALAKTITE_PARTICLE_2",
      "WHITE_STALAKTITE_PARTICLE_3"
    },
    sheet = "INGAME_BLOCKS_2",
    emitter_box = {
      minVelX = -60,
      maxVelX = 60,
      minVelY = -60,
      maxVelY = 60
    },
    minAngleVel = -8,
    maxAngleVel = 8,
    minScaleBegin = 0.7,
    maxScaleBegin = 1,
    minScaleEnd = 1.1,
    maxScaleEnd = 1.5,
    lifeTime = 3.5,
    gravityX = 0,
    gravityY = 500
  },
  levelCompleteStars1 = {
    sprites = {
      "P_STAR_1",
      "P_STAR_2",
      "P_STAR_3",
      "P_STAR_4",
      "P_STAR_5",
      "P_SMOKE_3"
    },
    sheet = "INGAME_PARTICLES_1",
    amount = 40,
    emitter_circle = {
      minVel = 400,
      maxVel = 1600,
      minAngleEmitter = 160,
      maxAngleEmitter = 260
    },
    minAngleVel = 2,
    maxAngleVel = 8,
    minScaleBegin = 0.5,
    maxScaleBegin = 2,
    minScaleEnd = 0.2,
    maxScaleEnd = 0.2,
    lifeTime = 5,
    gravityX = 0,
    gravityY = 300,
    minAngle = -180,
    maxAngle = 180
  },
  levelCompleteStars2 = {
    sprites = {
      "P_STAR_1",
      "P_STAR_2",
      "P_STAR_3",
      "P_STAR_4",
      "P_STAR_5",
      "P_SMOKE_3"
    },
    sheet = "INGAME_PARTICLES_1",
    amount = 40,
    emitter_circle = {
      minVel = 300,
      maxVel = 1000,
      minAngleEmitter = -150,
      maxAngleEmitter = -30
    },
    minAngleVel = 2,
    maxAngleVel = 8,
    minScaleBegin = 0.5,
    maxScaleBegin = 2,
    minScaleEnd = 0.2,
    maxScaleEnd = 0.2,
    lifeTime = 5,
    gravityX = 0,
    gravityY = 300,
    minAngle = -180,
    maxAngle = 180
  },
  levelCompleteStars3 = {
    sprites = {
      "P_STAR_1",
      "P_STAR_2",
      "P_STAR_3",
      "P_STAR_4",
      "P_STAR_5",
      "P_SMOKE_3"
    },
    sheet = "INGAME_PARTICLES_1",
    amount = 40,
    emitter_circle = {
      minVel = 400,
      maxVel = 1600,
      minAngleEmitter = 20,
      maxAngleEmitter = -70
    },
    minAngleVel = 2,
    maxAngleVel = 8,
    minScaleBegin = 0.5,
    maxScaleBegin = 2,
    minScaleEnd = 0.2,
    maxScaleEnd = 0.2,
    lifeTime = 5,
    gravityX = 0,
    gravityY = 300,
    minAngle = -180,
    maxAngle = 180
  },
  levelCompleteStars4 = {
    sprites = {
      "BIRD_BOOMERANG_SPECIAL"
    },
    sheet = "INGAME_PARTICLES_1",
    amount = 40,
    emitter_circle = {
      minVel = 400,
      maxVel = 1600,
      minAngleEmitter = 20,
      maxAngleEmitter = -70
    },
    minAngleVel = 2,
    maxAngleVel = 8,
    minScaleBegin = 0.5,
    maxScaleBegin = 2,
    minScaleEnd = 0.2,
    maxScaleEnd = 0.2,
    lifeTime = 5,
    gravityX = 0,
    gravityY = 300,
    minAngle = -180,
    maxAngle = 180
  },
  newHighScoreStars = {
    sprites = {
      "RED_FEATHER_1",
      "RED_FEATHER_2",
      "RED_FEATHER_3",
      "RED_FEATHER_1",
      "RED_FEATHER_2",
      "RED_FEATHER_3",
      "SMOKE_BUFF_1",
      "SMOKE_BUFF_2"
    },
    sheet = "",
    emitter_box = {
      minVel = 200,
      maxVel = 300,
      minAngleEmitter = -180,
      maxAngleEmitter = 180
    },
    minAngleVel = 1,
    maxAngleVel = 8,
    minScaleBegin = 1,
    maxScaleBegin = 1.2,
    minScaleEnd = 0.1,
    maxScaleEnd = 0.1,
    lifeTime = 0.4,
    gravityX = 0,
    gravityY = 0,
    minAngle = -180,
    maxAngle = 180
  },
  cake1Break = {
    sprites = {
      "PARTICLE_CHOCO_1",
      "PARTICLE_CHOCO_2",
      "PARTICLE_CHOCO_3",
      "PARTICLE_CHOCO_4"
    },
    sheet = "INGAME_BLOCKS_2",
    emitter_box = {
      minVelX = -100,
      maxVelX = 100,
      minVelY = -100,
      maxVelY = 100
    },
    minAngleVel = -8,
    maxAngleVel = 8,
    minScaleBegin = 1.5,
    maxScaleBegin = 1.8,
    minScaleEnd = 1.9,
    maxScaleEnd = 2.3,
    lifeTime = 3.5,
    gravityX = 0,
    gravityY = 500
  },
  cake2Break = {
    sprites = {
      "PARTICLE_PINK_1",
      "PARTICLE_PINK_2",
      "PARTICLE_PINK_3",
      "PARTICLE_PINK_4"
    },
    sheet = "INGAME_BLOCKS_2",
    emitter_box = {
      minVelX = -100,
      maxVelX = 100,
      minVelY = -100,
      maxVelY = 100
    },
    minAngleVel = -8,
    maxAngleVel = 8,
    minScaleBegin = 1.5,
    maxScaleBegin = 1.8,
    minScaleEnd = 1.9,
    maxScaleEnd = 2.3,
    lifeTime = 3.5,
    gravityX = 0,
    gravityY = 500
  },
  cake3Break = {
    sprites = {
      "PARTICLE_MINT_1",
      "PARTICLE_MINT_2",
      "PARTICLE_MINT_3",
      "PARTICLE_MINT_4"
    },
    sheet = "INGAME_BLOCKS_2",
    emitter_box = {
      minVelX = -100,
      maxVelX = 100,
      minVelY = -100,
      maxVelY = 100
    },
    minAngleVel = -8,
    maxAngleVel = 8,
    minScaleBegin = 1.5,
    maxScaleBegin = 1.8,
    minScaleEnd = 1.9,
    maxScaleEnd = 2.3,
    lifeTime = 3.5,
    gravityX = 0,
    gravityY = 500
  },
  powerupBuff = {
    sprites = {
      "EXPLOSION_SEQUENCE2_1",
      "EXPLOSION_SEQUENCE2_2",
      "EXPLOSION_SEQUENCE2_3",
      "EXPLOSION_SEQUENCE2_4",
      "EXPLOSION_SEQUENCE2_5"
    },
    sheet = "",
    emitter_box = {
      minVelX = 0,
      maxVelX = 0,
      minVelY = 0,
      maxVelY = 0
    },
    minAngleVel = 0,
    maxAngleVel = 0,
    minScaleBegin = 2.5,
    maxScaleBegin = 2.5,
    minScaleEnd = 2.5,
    maxScaleEnd = 2.5,
    lifeTime = 0.2,
    gravityX = 0,
    gravityY = -10,
    animation = "lifeTime"
  },
  powerupBurst = {
    sprites = {
      "EXPLOSION_PARTICLE1"
    },
    sheet = "INGAME_PARTICLES_1",
    amount = 40,
    emitter_circle = {
      minVel = 200,
      maxVel = 800,
      minAngleEmitter = -180,
      maxAngleEmitter = 180
    },
    minAngleVel = 2,
    maxAngleVel = 8,
    minScaleBegin = 0.5,
    maxScaleBegin = 2,
    minScaleEnd = 0.2,
    maxScaleEnd = 0.2,
    lifeTime = 0.5,
    gravityX = 0,
    gravityY = 300,
    minAngle = -180,
    maxAngle = 180
  },
  powerupSmokeBuff = {
    sprites = {
      "EXPLOSION_CLOUD_1",
      "EXPLOSION_CLOUD_2"
    },
    sheet = "INGAME_BIRDS_1",
    emitter_box = {
      minVelX = -50,
      maxVelX = 50,
      minVelY = -50,
      maxVelY = 50
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium,
    maxScaleBegin = featherSizeLarge,
    minScaleEnd = 0,
    maxScaleEnd = 0,
    lifeTime = 0.5,
    gravityX = 0,
    gravityY = -10
  },
  superSlingTrail = {
    sprites = {
      "SUPERSEED_SEQUENCE_1"
    },
    sheet = "",
    emitter_box = {
      minVelX = 0,
      maxVelX = 50,
      minVelY = 0,
      maxVelY = 50
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium * 0.6,
    maxScaleBegin = featherSizeLarge * 0.6,
    minScaleEnd = featherSizeSmall * 0.6,
    maxScaleEnd = featherSizeMedium * 0.6,
    lifeTime = lifeTimeRandom,
    gravityX = 0,
    gravityY = -10
  },
  superSlingActivation = {
    sprites = {
      "POWERUP_SEQUENCE_1",
      "POWERUP_SEQUENCE_2",
      "POWERUP_SEQUENCE_3",
      "POWERUP_SEQUENCE_4",
      "POWERUP_SEQUENCE_5",
      "POWERUP_SEQUENCE_6",
      "POWERUP_SEQUENCE_7",
      "POWERUP_SEQUENCE_8",
      "POWERUP_SEQUENCE_9"
    },
    sheet = "",
    emitter_circle = {
      minVel = 0,
      maxVel = 0,
      minAngleEmitter = 0,
      maxAngleEmitter = 0
    },
    minAngleVel = 0,
    maxAngleVel = 0,
    minScaleBegin = 3,
    maxScaleBegin = 3,
    minScaleEnd = 3,
    maxScaleEnd = 3,
    lifeTime = 0.5,
    gravityX = 0,
    gravityY = 0,
    animation = "lifeTime"
  },
  superSlingBurst = {
    sprites = {
      "EXPLOSION_PARTICLE1"
    },
    sheet = "INGAME_PARTICLES_1",
    amount = 40,
    emitter_circle = {
      minVel = 400,
      maxVel = 1600,
      minAngleEmitter = -110,
      maxAngleEmitter = -70
    },
    minAngleVel = 2,
    maxAngleVel = 8,
    minScaleBegin = 1,
    maxScaleBegin = 4,
    minScaleEnd = 0,
    maxScaleEnd = 0,
    lifeTime = 0.8,
    gravityX = 0,
    gravityY = 800,
    minAngle = -180,
    maxAngle = 180
  },
  superSeedActivation = {
    sprites = {
      "SUPERSEED_SEQUENCE_1",
      "SUPERSEED_SEQUENCE_2",
      "SUPERSEED_SEQUENCE_3",
      "SUPERSEED_SEQUENCE_4",
      "SUPERSEED_SEQUENCE_5",
      "SUPERSEED_SEQUENCE_6",
      "SUPERSEED_SEQUENCE_7"
    },
    sheet = "",
    emitter_circle = {
      minVel = 0,
      maxVel = 0,
      minAngleEmitter = 0,
      maxAngleEmitter = 0
    },
    minAngleVel = 0,
    maxAngleVel = 0,
    minScaleBegin = 2,
    maxScaleBegin = 2,
    minScaleEnd = 2,
    maxScaleEnd = 2,
    lifeTime = 0.5,
    gravityX = 0,
    gravityY = 0,
    animation = "lifeTime"
  },
  cheaterStamp = {
    sprites = {
      "SUPERSEED_SEQUENCE_1",
      "SUPERSEED_SEQUENCE_2",
      "SUPERSEED_SEQUENCE_3",
      "SUPERSEED_SEQUENCE_4",
      "SUPERSEED_SEQUENCE_5",
      "SUPERSEED_SEQUENCE_6",
      "SUPERSEED_SEQUENCE_7"
    },
    sheet = "",
    emitter_circle = {
      minVel = 0,
      maxVel = 0,
      minAngleEmitter = 0,
      maxAngleEmitter = 0
    },
    minAngleVel = 0,
    maxAngleVel = 0,
    minScaleBegin = 1,
    maxScaleBegin = 1,
    minScaleEnd = 1,
    maxScaleEnd = 1,
    lifeTime = 0.5,
    gravityX = 0,
    gravityY = 0,
    animation = "lifeTime"
  },
  superSeedActivationBurst = {
    sprites = {
      "SUPERSEED_SEQUENCE_1",
      "SUPERSEED_SEQUENCE_2",
      "SUPERSEED_SEQUENCE_3",
      "SUPERSEED_SEQUENCE_4",
      "SUPERSEED_SEQUENCE_5",
      "SUPERSEED_SEQUENCE_6",
      "SUPERSEED_SEQUENCE_7"
    },
    sheet = "",
    emitter_box = {
      minVelX = -100,
      maxVelX = 100,
      minVelY = -100,
      maxVelY = 100
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium * 0.3,
    maxScaleBegin = featherSizeLarge * 0.3,
    minScaleEnd = 0,
    maxScaleEnd = 0,
    lifeTime = 1.5,
    gravityX = 0,
    gravityY = 100,
    animation = "lifeTime"
  },
  quake = {
    sprites = {
      "ROCK_PARTICLE_1",
      "ROCK_PARTICLE_2",
      "ROCK_PARTICLE_3",
      "ROCK_PARTICLE_1",
      "ROCK_PARTICLE_2",
      "ROCK_PARTICLE_3",
      "STALAKTITE_PARTICLE_1",
      "STALAKTITE_PARTICLE_2",
      "STALAKTITE_PARTICLE_3",
      "STALAKTITE_PARTICLE_4"
    },
    sheet = "",
    emitter_box = {
      minVelX = -80,
      maxVelX = 80,
      minVelY = -80,
      maxVelY = 80
    },
    minAngleVel = -7,
    maxAngleVel = 7,
    minScaleBegin = 1.7,
    maxScaleBegin = 2.2,
    minScaleEnd = 0.2,
    maxScaleEnd = 0.4,
    lifeTime = 2.5,
    gravityX = 0,
    gravityY = 300
  },
  quake_smoke = {
    sprites = {
      "EARTHQUAKE_SMOKE"
    },
    sheet = "",
    emitter_box = {
      minVelX = 0,
      maxVelX = 0,
      minVelY = 0,
      maxVelY = 0
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium * 0.6,
    maxScaleBegin = featherSizeLarge * 0.6,
    minScaleEnd = featherSizeSmall * 0.6,
    maxScaleEnd = featherSizeMedium * 0.6,
    lifeTime = lifeTimeRandom,
    gravityX = 0,
    gravityY = 30
  },
  star_bits = {
    sprites = {
      "AWARD_STARDEBRIS_PARTICLE1",
      "AWARD_STARDEBRIS_PARTICLE2",
      "AWARD_STARDEBRIS_PATRICLE3",
      "AWARD_STARDEBRIS_PARTICLE4"
    },
    sheet = "",
    emitter_circle = {
      minVel = 400,
      maxVel = 1600,
      minAngleEmitter = -150,
      maxAngleEmitter = 260
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = 1,
    maxScaleBegin = 1,
    minScaleEnd = 0,
    maxScaleEnd = 0,
    lifeTime = 5,
    gravityX = 0,
    gravityY = 800,
    minAngle = -180,
    maxAngle = 180
  },
  diamond_shine = {
    sprites = {
      "AWARD_UI_STAREFFECT"
    },
    sheet = "",
    emitter_box = {
      minVelX = 0,
      maxVelX = 0,
      minVelY = 0,
      maxVelY = 0
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = 1,
    maxScaleBegin = 1,
    minScaleEnd = 0,
    maxScaleEnd = 0,
    lifeTime = 0.6,
    gravityX = 0,
    gravityY = 0,
    minAngle = -180,
    maxAngle = 180
  },
  dailyRewardCount = {
    sprites = {
      "SUPERSEED_SEQUENCE_1"
    },
    sheet = "",
    emitter_circle = {
      minVel = 100,
      maxVel = 100,
      minAngleEmitter = -180,
      maxAngleEmitter = 0
    },
    minAngleVel = 0,
    maxAngleVel = 0,
    minScaleBegin = 0.7,
    maxScaleBegin = 0.7,
    minScaleEnd = 0,
    maxScaleEnd = 0,
    lifeTime = 0.6,
    gravityX = 0,
    gravityY = 0
  },
  dailyRewardWin = {
    sprites = {
      "SUPERSEED_SEQUENCE_1",
      "SUPERSEED_SEQUENCE_2",
      "SUPERSEED_SEQUENCE_3",
      "SUPERSEED_SEQUENCE_4",
      "SUPERSEED_SEQUENCE_5",
      "SUPERSEED_SEQUENCE_6",
      "SUPERSEED_SEQUENCE_7"
    },
    sheet = "",
    emitter_circle = {
      minVel = 30,
      maxVel = 100,
      minAngleEmitter = -180,
      maxAngleEmitter = 180
    },
    minAngleVel = 0,
    maxAngleVel = 0,
    minScaleBegin = 0.3,
    maxScaleBegin = 0.6,
    minScaleEnd = 0,
    maxScaleEnd = 0,
    lifeTime = 1,
    gravityX = 0,
    gravityY = 30
  },
  shopPowerupReceived = {
    sprites = {
      "SUPERSEED_SEQUENCE_1",
      "SUPERSEED_SEQUENCE_2",
      "SUPERSEED_SEQUENCE_3",
      "SUPERSEED_SEQUENCE_4",
      "SUPERSEED_SEQUENCE_5",
      "SUPERSEED_SEQUENCE_6",
      "SUPERSEED_SEQUENCE_7"
    },
    sheet = "",
    emitter_circle = {
      minVel = 40,
      maxVel = 150,
      minAngleEmitter = -180,
      maxAngleEmitter = 0
    },
    minAngleVel = 0,
    maxAngleVel = 0,
    minScaleBegin = 0.3,
    maxScaleBegin = 0.6,
    minScaleEnd = 0,
    maxScaleEnd = 0,
    lifeTime = 1,
    gravityX = 0,
    gravityY = 30
  },
  confettisBlue = {
    sprites = {
      "P_CONFETTI_BLUE_1",
      "P_CONFETTI_BLUE_2",
      "P_CONFETTI_BLUE_3"
    },
    sheet = "INGAME_PARTICLES_1",
    emitter_circle = {
      minVel = confettiMinVel,
      maxVel = confettiMaxVel,
      minAngleEmitter = confettiMinAngleEmitter,
      maxAngleEmitter = confettiMaxAngleEmitter
    },
    minAngleVel = confettiMinAngleVel,
    maxAngleVel = confettiMaxAngleVel,
    minScaleBegin = confettiMinScaleBegin,
    maxScaleBegin = confettiMaxScaleBegin,
    minScaleEnd = confettiMinScaleEnd,
    maxScaleEnd = confettiMaxScaleEnd,
    lifeTime = confettiLifeTime,
    gravityX = confettiGravityX,
    gravityY = confettiGravityY,
    minAngle = confettiMinAngle,
    maxAngle = confettiMaxAngle
  },
  confettisGreen = {
    sprites = {
      "P_CONFETTI_GREEN_1",
      "P_CONFETTI_GREEN_2",
      "P_CONFETTI_GREEN_3"
    },
    sheet = "INGAME_PARTICLES_1",
    emitter_circle = {
      minVel = confettiMinVel,
      maxVel = confettiMaxVel,
      minAngleEmitter = confettiMinAngleEmitter,
      maxAngleEmitter = confettiMaxAngleEmitter
    },
    minAngleVel = confettiMinAngleVel,
    maxAngleVel = confettiMaxAngleVel,
    minScaleBegin = confettiMinScaleBegin,
    maxScaleBegin = confettiMaxScaleBegin,
    minScaleEnd = confettiMinScaleEnd,
    maxScaleEnd = confettiMaxScaleEnd,
    lifeTime = confettiLifeTime,
    gravityX = confettiGravityX,
    gravityY = confettiGravityY,
    minAngle = confettiMinAngle,
    maxAngle = confettiMaxAngle
  },
  confettisSilver = {
    sprites = {
      "P_CONFETTI_SILVER_1",
      "P_CONFETTI_SILVER_2",
      "P_CONFETTI_SILVER_3"
    },
    sheet = "INGAME_PARTICLES_1",
    emitter_circle = {
      minVel = confettiMinVel,
      maxVel = confettiMaxVel,
      minAngleEmitter = confettiMinAngleEmitter,
      maxAngleEmitter = confettiMaxAngleEmitter
    },
    minAngleVel = confettiMinAngleVel,
    maxAngleVel = confettiMaxAngleVel,
    minScaleBegin = confettiMinScaleBegin,
    maxScaleBegin = confettiMaxScaleBegin,
    minScaleEnd = confettiMinScaleEnd,
    maxScaleEnd = confettiMaxScaleEnd,
    lifeTime = confettiLifeTime,
    gravityX = confettiGravityX,
    gravityY = confettiGravityY,
    minAngle = confettiMinAngle,
    maxAngle = confettiMaxAngle
  },
  confettisBlueGreen = {
    sprites = {
      "P_CONFETTI_BLUE_1",
      "P_CONFETTI_BLUE_2",
      "P_CONFETTI_BLUE_3",
      "P_CONFETTI_GREEN_1",
      "P_CONFETTI_GREEN_2",
      "P_CONFETTI_GREEN_3"
    },
    sheet = "INGAME_PARTICLES_1",
    emitter_circle = {
      minVel = confettiMinVel,
      maxVel = confettiMaxVel,
      minAngleEmitter = confettiMinAngleEmitter,
      maxAngleEmitter = confettiMaxAngleEmitter
    },
    minAngleVel = confettiMinAngleVel,
    maxAngleVel = confettiMaxAngleVel,
    minScaleBegin = confettiMinScaleBegin,
    maxScaleBegin = confettiMaxScaleBegin,
    minScaleEnd = confettiMinScaleEnd,
    maxScaleEnd = confettiMaxScaleEnd,
    lifeTime = confettiLifeTime,
    gravityX = confettiGravityX,
    gravityY = confettiGravityY,
    minAngle = confettiMinAngle,
    maxAngle = confettiMaxAngle
  },
  confettisBlueSilver = {
    sprites = {
      "P_CONFETTI_BLUE_1",
      "P_CONFETTI_BLUE_2",
      "P_CONFETTI_BLUE_3",
      "P_CONFETTI_SILVER_1",
      "P_CONFETTI_SILVER_2",
      "P_CONFETTI_SILVER_3"
    },
    sheet = "INGAME_PARTICLES_1",
    emitter_circle = {
      minVel = confettiMinVel,
      maxVel = confettiMaxVel,
      minAngleEmitter = confettiMinAngleEmitter,
      maxAngleEmitter = confettiMaxAngleEmitter
    },
    minAngleVel = confettiMinAngleVel,
    maxAngleVel = confettiMaxAngleVel,
    minScaleBegin = confettiMinScaleBegin,
    maxScaleBegin = confettiMaxScaleBegin,
    minScaleEnd = confettiMinScaleEnd,
    maxScaleEnd = confettiMaxScaleEnd,
    lifeTime = confettiLifeTime,
    gravityX = confettiGravityX,
    gravityY = confettiGravityY,
    minAngle = confettiMinAngle,
    maxAngle = confettiMaxAngle
  },
  confettisGreenSilver = {
    sprites = {
      "P_CONFETTI_GREEN_1",
      "P_CONFETTI_GREEN_2",
      "P_CONFETTI_GREEN_3",
      "P_CONFETTI_SILVER_1",
      "P_CONFETTI_SILVER_2",
      "P_CONFETTI_SILVER_3"
    },
    sheet = "INGAME_PARTICLES_1",
    emitter_circle = {
      minVel = confettiMinVel,
      maxVel = confettiMaxVel,
      minAngleEmitter = confettiMinAngleEmitter,
      maxAngleEmitter = confettiMaxAngleEmitter
    },
    minAngleVel = confettiMinAngleVel,
    maxAngleVel = confettiMaxAngleVel,
    minScaleBegin = confettiMinScaleBegin,
    maxScaleBegin = confettiMaxScaleBegin,
    minScaleEnd = confettiMinScaleEnd,
    maxScaleEnd = confettiMaxScaleEnd,
    lifeTime = confettiLifeTime,
    gravityX = confettiGravityX,
    gravityY = confettiGravityY,
    minAngle = confettiMinAngle,
    maxAngle = confettiMaxAngle
  },
  confettisBlueGreenSilver = {
    sprites = {
      "P_CONFETTI_BLUE_1",
      "P_CONFETTI_BLUE_2",
      "P_CONFETTI_BLUE_3",
      "P_CONFETTI_GREEN_1",
      "P_CONFETTI_GREEN_2",
      "P_CONFETTI_GREEN_3",
      "P_CONFETTI_SILVER_1",
      "P_CONFETTI_SILVER_2",
      "P_CONFETTI_SILVER_3"
    },
    sheet = "INGAME_PARTICLES_1",
    emitter_circle = {
      minVel = confettiMinVel,
      maxVel = confettiMaxVel,
      minAngleEmitter = confettiMinAngleEmitter,
      maxAngleEmitter = confettiMaxAngleEmitter
    },
    minAngleVel = confettiMinAngleVel,
    maxAngleVel = confettiMaxAngleVel,
    minScaleBegin = confettiMinScaleBegin,
    maxScaleBegin = confettiMaxScaleBegin,
    minScaleEnd = confettiMinScaleEnd,
    maxScaleEnd = confettiMaxScaleEnd,
    lifeTime = confettiLifeTime,
    gravityX = confettiGravityX,
    gravityY = confettiGravityY,
    minAngle = confettiMinAngle,
    maxAngle = confettiMaxAngle
  },
  theme15rain = {
    sprites = {
      "THEME_15_WATERPARTICLE"
    },
    sheet = "",
    emitter_circle = {
      minVel = 1800,
      maxVel = 2400,
      minAngleEmitter = 120,
      maxAngleEmitter = 120
    },
    minAngleVel = 0,
    maxAngleVel = 0,
    minScaleBegin = 0.3,
    maxScaleBegin = 0.5,
    minScaleEnd = 0.3,
    maxScaleEnd = 0.5,
    lifeTime = 2.5,
    gravityX = 0,
    gravityY = 0,
    minAngle = 0,
    maxAngle = 0
  },
  mattelSplashGlass = {
    sprites = {
      "PARTICLE_GLASS"
    },
    sheet = "",
    minAngleVel = 2,
    maxAngleVel = 8,
    minScaleBegin = 0.5,
    maxScaleBegin = 2,
    minScaleEnd = 0.2,
    maxScaleEnd = 0.2,
    lifeTime = 5,
    gravityX = 0,
    gravityY = 1600,
    emitter_circle = {
      minVel = -800,
      maxVel = 800,
      minAngleEmitter = -180,
      maxAngleEmitter = 180
    }
  },
  mattelPigBuff = {
    sprites = {
      "SMOKE_BUFF_1",
      "SMOKE_BUFF_2"
    },
    sheet = "",
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium,
    maxScaleBegin = featherSizeLarge,
    minScaleEnd = featherSizeSmall,
    maxScaleEnd = featherSizeMedium,
    lifeTime = lifeTimeRandom,
    gravityX = 0,
    gravityY = -10,
    emitter_circle = {minVel = -50, maxVel = 50}
  },
  mattelPigTears = {
    sprites = {
      "PARTICLE_CRY"
    },
    sheet = "",
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = 1,
    maxScaleBegin = 0.5,
    minScaleEnd = 0,
    maxScaleEnd = 0,
    lifeTime = 3,
    gravityX = 0,
    gravityY = 1200,
    emitter_circle = {minVel = -350, maxVel = 350}
  },
  totalDestructionExplosion = {
    sprites = {
      "MATTEL_EXPLOSION_1",
      "MATTEL_EXPLOSION_2",
      "MATTEL_EXPLOSION_3",
      "MATTEL_EXPLOSION_4",
      "MATTEL_EXPLOSION_5",
      "MATTEL_EXPLOSION_6",
      "MATTEL_EXPLOSION_7"
    },
    sheet = "",
    minAngleVel = 0,
    maxAngleVel = 0,
    minScaleBegin = 1,
    maxScaleBegin = 1,
    minScaleEnd = 1,
    maxScaleEnd = 1,
    lifeTime = 0.5,
    gravityX = 0,
    gravityY = 0,
    animation = "lifeTime",
    emitter_circle = {
      minVel = 0,
      maxVel = 0,
      minAngleEmitter = 0,
      maxAngleEmitter = 0
    }
  },
  green_rocket = {
    sprites = {
      "SUPERSEED_SEQUENCE_1",
      "SUPERSEED_SEQUENCE_2",
      "SUPERSEED_SEQUENCE_3",
      "SUPERSEED_SEQUENCE_4",
      "SUPERSEED_SEQUENCE_5",
      "SUPERSEED_SEQUENCE_6",
      "SUPERSEED_SEQUENCE_7"
    },
    sheet = "",
    emitter_box = {
      minVelX = -200,
      maxVelX = -200,
      minVelY = -100,
      maxVelY = 100
    },
    minAngleVel = -featherSpinSpeed,
    maxAngleVel = featherSpinSpeed,
    minScaleBegin = featherSizeMedium * 0.3,
    maxScaleBegin = featherSizeLarge * 0.3,
    minScaleEnd = 0,
    maxScaleEnd = 0,
    lifeTime = 1.5,
    gravityX = 0,
    gravityY = 100,
    animation = "lifeTime"
  }
}
filename = "particles.lua"
