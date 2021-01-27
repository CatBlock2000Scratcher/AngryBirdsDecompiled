collider_types = {--TODO
  default = 0,
  mighty_eagle = 1,
  immovable = 2,
  wind = 3
}
shape_types = {
  box = 0,
  circle = 1,
  polygon = 2
}
materials = {
  balloon = {
    strength = 30,
    defence = 2.5,
    friction = 4,
    restitution = 0.2,
    density = 1.5,
    controllable = false,
    z_order = 1,
    particles = "smokeBuff",
    collisionSound = "",
    damageSound = "",
    destroyedSound = "balloon_pop",
    forceY = -30,
    forceX = -1
  },
  wood = {
    strength = 60,
    defence = 2.5,
    friction = 4,
    restitution = 0.2,
    density = 1.5,
    controllable = false,
    particles = "woodenBuff",
    collisionSound = "wood_collision",
    damageSound = "wood_damage",
    destroyedSound = "wood_destroyed",
    rollingSound = "wood_rolling"
  },
  rock = {
    strength = 120,
    defence = 15,
    friction = 4,
    restitution = 0.1,
    density = 4,
    controllable = false,
    particles = "rockBuff",
    collisionSound = "rock_collision",
    damageSound = "rock_damage",
    destroyedSound = "rock_destroyed",
    rollingSound = "rock_rolling"
  },
  light = {
    strength = 40,
    defence = 2,
    friction = 0.7,
    restitution = 0.2,
    density = 0.75,
    controllable = false,
    particles = "lightBuff",
    collisionSound = "light_collision",
    damageSound = "light_damage",
    destroyedSound = "light_destroyed",
    rollingSound = "light_rolling"
  },
  piglette = {
    strength = 10,
    defence = 1,
    friction = 0.7,
    restitution = 0.05,
    density = 2,
    controllable = false,
    particles = "smokeBuff",
    collisionSound = "piglette_collision",
    damageSound = "piglette_damage",
    destroyedSound = "piglette_destroyed"
  },
  staticGround = {
    strength = 30,
    defence = 100000,
    friction = 0.8,
    restitution = 0,
    density = 0,
    controllable = false,
    particles = "smokeBuff",
    collisionSound = "ground_collision"
  },
  immovable = {
    strength = 30,
    defence = 100000,
    friction = 0.8,
    restitution = 0,
    density = 0,
    controllable = false,
    particles = "smokeBuff",
    collisionSound = "ground_collision",
    collider_type = collider_types.immovable
  },
  immovableFragile = {
    strength = 2,
    defence = 1,
    friction = 0.8,
    restitution = 0,
    density = 0,
    controllable = false,
    particles = "",
    collisionSound = "ground_collision"
  },
  clouds = {
    strength = 0.1,
    defence = 1,
    friction = 0.8,
    restitution = 0,
    density = 0,
    controllable = false,
    particles = "smokeBuff",
    collisionSound = "ground_collision",
    destroyedSound = "balloon_pop"
  },
  immovableRubber = {
    strength = 30,
    defence = 100000,
    friction = 0.8,
    restitution = 0,
    density = 0,
    controllable = false,
    particles = "smokeBuff",
    collisionSound = "trampoline"
  },
  extras = {
    strength = 40,
    defence = 5,
    friction = 0.7,
    restitution = 0.4,
    density = 0.75,
    controllable = false,
    particles = "smokeBuff",
    collisionSound = "ground_collision",
    destroyedSound = "wood damage a1"
  },
  halloween = {
    strength = 40,
    defence = 5,
    friction = 0.7,
    restitution = 0.4,
    density = 1,
    5,
    controllable = false,
    particles = "pumpkinBuff",
    collisionSound = "ground_collision",
    destroyedSound = "halloween_destroyed"
  },
  pumpkin = {
    strength = 40,
    defence = 5,
    friction = 0.7,
    restitution = 0.4,
    density = 1,
    controllable = false,
    particles = "pumpkinBuff",
    collisionSound = "ground_collision",
    destroyedSound = "pumpkin_destroyed"
  },
  lantern = {
    strength = 20,
    defence = 5,
    friction = 0.7,
    restitution = 0.4,
    density = 0.75,
    controllable = false,
    particles = "flameBuff",
    collisionSound = "light_collision",
    destroyedSound = "lantern_break_a1"
  },
  rubber = {
    strength = 40,
    defence = 5,
    friction = 0.7,
    restitution = 0.4,
    density = 0.75,
    controllable = false,
    particles = "smokeBuff",
    collisionSound = "ball_bounce"
  },
  decoration = {
    strength = 30,
    defence = 100000,
    friction = 0.8,
    restitution = 0,
    density = 0,
    controllable = false
  },
  common = {
    strength = 1,
    defence = 1,
    friction = 0.7,
    restitution = 0.2,
    density = 0.75,
    particles = "lightBuff",
    collisionSound = "",
    damageSound = "",
    destroyedSound = ""
  },
  stalaktite = {
    strength = 20,
    defence = 5,
    friction = 0.7,
    restitution = 0.4,
    density = 0.75,
    controllable = false,
    particles = "stalaktiteBreak",
    collisionSound = "rock_collision",
    damageSound = "rock_damage",
    destroyedSound = "rock_destroyed"
  },
  stalaktite_tip = {
    strength = 20,
    defence = 5,
    friction = 0.7,
    restitution = 0.4,
    density = 0.75,
    controllable = false,
    particles = "stalaktiteBreak",
    collisionSound = "rock_collision",
    damageSound = "rock_damage",
    destroyedSound = "stalaktite_break"
  },
  amber = {
    strength = 20,
    defence = 5,
    friction = 0.7,
    restitution = 0.4,
    density = 0.75,
    controllable = false,
    particles = "amberBreak",
    collisionSound = "rock_collision",
    damageSound = "rock_damage",
    destroyedSound = "jewel_break"
  },
  ruby = {
    strength = 20,
    defence = 5,
    friction = 0.7,
    restitution = 0.4,
    density = 0.75,
    controllable = false,
    particles = "rubyBreak",
    collisionSound = "rock_collision",
    damageSound = "rock_damage",
    destroyedSound = "jewel_break"
  },
  amethyst = {
    strength = 20,
    defence = 5,
    friction = 0.7,
    restitution = 0.4,
    density = 0.75,
    controllable = false,
    particles = "amethystBreak",
    collisionSound = "rock_collision",
    damageSound = "rock_damage",
    destroyedSound = "jewel_break"
  },
  cake = {
    strength = 40,
    defence = 5,
    friction = 0.7,
    restitution = 0.4,
    density = 0.75,
    controllable = false,
    particles = "smokeBuff",
    collisionSound = "ground_collision",
    destroyedSound = "birthday_cake"
  },
  wind = {--TODO
    friction = 0,
    restitution = 0,
    density = 0,
    controllable = false,
    collider_type = collider_types.wind
  }
}
themes = {
  settings = {keyCode = "T", themeAmount = 22},
  theme1 = {
    index = 1,
    music = "ambient_theme1",
    graphicSetName = {
      "THEME_01",
      "THEME_01_COMPOSPRITES"
    },
    texture = "THEME_01_THEME_GROUND_1",
	playButtonSprite = {--TODO?
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_1",
        "BACKGROUND_1_LAYER_1",
        0.125,
        2
      },
      {
        "",
        "THEME_1_BG_LAYER_2",
        0.5,
        2
      },
      {
        "",
        "THEME_1_BG_LAYER_3",
        1,
        1.5
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_1_LAYER_1"
      },
      {
        "",
        "FOREGROUND_1_LAYER_2"
      }
    },
    color = {
      r = 146,
      g = 204,
      b = 222
    },
    groundColor = {
      r = 10,
      g = 19,
      b = 57
    }
  },
  theme2 = {
    index = 2,
    music = "ambient_theme2",
    graphicSetName = {
      "THEME_02",
      "THEME_02_COMPOSPRITES"
    },
    texture = "THEME_02_THEME_GROUND_2",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_1",
        "BACKGROUND_2_LAYER_1",
        0.125,
        2
      },
      {
        "",
        "THEME_2_BG_LAYER_2",
        0.5,
        2
      },
      {
        "",
        "THEME_2_BG_LAYER_3",
        1,
        1.5
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_2_LAYER_1"
      },
      {
        "",
        "FOREGROUND_2_LAYER_2"
      }
    },
    color = {
      r = 193,
      g = 231,
      b = 239
    },
    groundColor = {
      r = 10,
      g = 19,
      b = 15
    }
  },
  theme3 = {
    index = 3,
    music = "ambient_theme3",
    graphicSetName = {
      "THEME_03",
      "THEME_03_COMPOSPRITES"
    },
    texture = "THEME_03_THEME_GROUND_3",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_1",
        "BACKGROUND_3_LAYER_1",
        0.125,
        2
      },
      {
        "",
        "THEME_3_BG_LAYER_2",
        0.5,
        2
      },
      {
        "",
        "THEME_3_BG_LAYER_3",
        1,
        1.6
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_3_LAYER_1"
      },
      {
        "",
        "FOREGROUND_3_LAYER_2"
      }
    },
    color = {
      r = 239,
      g = 216,
      b = 115
    },
    groundColor = {
      r = 47,
      g = 23,
      b = 14
    }
  },
  theme4 = {
    index = 4,
    music = "ambient_theme1",
    graphicSetName = {
      "THEME_04",
      "THEME_04_COMPOSPRITES"
    },
    texture = "THEME_04_THEME_GROUND_4",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_1",
        "BACKGROUND_4_LAYER_1",
        0.125,
        2
      },
      {
        "",
        "THEME_4_BG_LAYER_2",
        0.5,
        2
      },
      {
        "",
        "THEME_4_BG_LAYER_3",
        1,
        1.85
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_4_LAYER_1"
      },
      {
        "INGAME_PARALLAX_4",
        "FOREGROUND_4_LAYER_2"
      }
    },
    color = {
      r = 144,
      g = 205,
      b = 237
    },
    groundColor = {
      r = 28,
      g = 18,
      b = 12
    }
  },
  theme5 = {
    index = 5,
    music = "ambient_theme3",
    graphicSetName = {
      "THEME_05",
      "THEME_05_COMPOSPRITES"
    },
    texture = "THEME_05_THEME_GROUND_5",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_1",
        "BACKGROUND_5_LAYER_1",
        0.125,
        2
      },
      {
        "",
        "THEME_5_BG_LAYER_2",
        0.5,
        2
      },
      {
        "",
        "THEME_5_BG_LAYER_3",
        1,
        1.8
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_5_LAYER_1"
      },
      {
        "INGAME_PARALLAX_5",
        "FOREGROUND_5_LAYER_2"
      }
    },
    color = {
      r = 241,
      g = 226,
      b = 140
    },
    groundColor = {
      r = 68,
      g = 39,
      b = 2
    }
  },
  theme6 = {
    index = 6,
    music = "ambient_theme3",
    graphicSetName = {
      "THEME_06",
      "THEME_06_COMPOSPRITES"
    },
    texture = "THEME_06_THEME_GROUND_6",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_2",
        "BACKGROUND_6_LAYER_1",
        0.3,
        4.5
      },
      {
        "",
        "THEME_6_BG_LAYER_2",
        0.55,
        3.3
      },
      {
        "",
        "THEME_6_BG_LAYER_3",
        1,
        2
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_6_LAYER_1"
      },
      {
        "INGAME_PARALLAX_6",
        "FOREGROUND_6_LAYER_2"
      }
    },
    color = {
      r = 73,
      g = 88,
      b = 45
    },
    groundColor = {
      r = 24,
      g = 28,
      b = 15
    }
  },
  theme7 = {
    index = 7,
    music = "ambient_theme7",
    graphicSetName = {
      "THEME_07",
      "THEME_07_COMPOSPRITES"
    },
    texture = "THEME_07_THEME_GROUND_7",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_2",
        "BACKGROUND_7_LAYER_1",
        0.125,
        3.5
      },
      {
        "",
        "THEME_7_BG_LAYER_2",
        0.5,
        3
      },
      {
        "",
        "THEME_7_BG_LAYER_3",
        1,
        2.8
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_7_LAYER_1"
      },
      {
        "INGAME_PARALLAX_7",
        "FOREGROUND_7_LAYER_2"
      }
    },
    color = {
      r = 0,
      g = 0,
      b = 0
    },
    groundColor = {
      r = 17,
      g = 34,
      b = 69
    }
  },
  theme8 = {
    index = 8,
    music = "ambient_theme2",
    graphicSetName = {
      "THEME_08",
      "THEME_08_COMPOSPRITES"
    },
    texture = "THEME_08_THEME_GROUND_8",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_2",
        "BACKGROUND_8_LAYER_1",
        0.125,
        2.5
      },
      {
        "",
        "THEME_8_BG_LAYER_2",
        0.5,
        2.5
      },
      {
        "",
        "THEME_8_BG_LAYER_3",
        1,
        1.8
      }
    },
    fgLayers = {
      {
        "INGAME_PARALLAX_8",
        "FOREGROUND_8_LAYER_1"
      },
      {
        "INGAME_PARALLAX_8",
        "FOREGROUND_8_LAYER_2"
      }
    },
    color = {
      r = 249,
      g = 248,
      b = 235
    },
    groundColor = {
      r = 238,
      g = 255,
      b = 255
    }
  },
  theme9 = {
    index = 9,
    music = "construction_theme1",
    graphicSetName = {
      "THEME_01",
      "THEME_01_COMPOSPRITES",
      "PARALLAX_CRANES"
    },
    texture = "THEME_01_THEME_GROUND_1",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "",
        "BACKGROUND_1_LAYER_1",
        0.125,
        2
      },
      {
        "",
        "THEME_1_BG_LAYER_2",
        0.5,
        2
      },
      {
        "",
        "PARALLAX_CRANE_1",
        0.8,
        1,
        false,
        565
      },
      {
        "",
        "PARALLAX_CRANE_2",
        0.85,
        1.3,
        false,
        645
      },
      {
        "",
        "PARALLAX_CRANE_3",
        0.9,
        1.6,
        false,
        755
      },
      {
        "",
        "PARALLAX_CRANE_4",
        0.95,
        2,
        false,
        822
      },
      {
        "",
        "THEME_1_BG_LAYER_3",
        1,
        1.5
      }
    },
    fgLayers = {
      {
        "",
        "FOREGROUND_1_LAYER_1"
      },
      {
        "",
        "FOREGROUND_1_LAYER_2"
      }
    },
    color = {
      r = 148,
      g = 206,
      b = 222
    },
    groundColor = {
      r = 10,
      g = 19,
      b = 57
    }
  },
  theme10 = {
    index = 10,
    music = "construction_theme1",
    graphicSetName = {
      "THEME_02",
      "THEME_02_COMPOSPRITES",
      "PARALLAX_CRANES"
    },
    texture = "THEME_02_THEME_GROUND_2",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_1",
        "BACKGROUND_2_LAYER_1",
        0.125,
        2
      },
      {
        "",
        "THEME_2_BG_LAYER_2",
        0.5,
        2
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_1",
        0.8,
        1,
        false,
        565
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_2",
        0.85,
        1.3,
        false,
        645
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_3",
        0.9,
        1.6,
        false,
        755
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_4",
        0.95,
        2,
        false,
        822
      },
      {
        "",
        "THEME_2_BG_LAYER_3",
        1,
        1.5
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_2_LAYER_1"
      },
      {
        "INGAME_PARALLAX_2",
        "FOREGROUND_2_LAYER_2"
      }
    },
    color = {
      r = 193,
      g = 231,
      b = 239
    },
    groundColor = {
      r = 10,
      g = 19,
      b = 15
    }
  },
  theme11 = {
    index = 11,
    music = "construction_theme1",
    graphicSetName = {
      "THEME_03",
      "THEME_03_COMPOSPRITES",
      "PARALLAX_CRANES"
    },
    texture = "THEME_03_THEME_GROUND_3",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_1",
        "BACKGROUND_3_LAYER_1",
        0.125,
        2
      },
      {
        "",
        "THEME_3_BG_LAYER_2",
        0.5,
        2
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_1",
        0.8,
        1,
        false,
        565
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_2",
        0.85,
        1.3,
        false,
        645
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_3",
        0.9,
        1.6,
        false,
        755
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_4",
        0.95,
        2,
        false,
        822
      },
      {
        "",
        "THEME_3_BG_LAYER_3",
        1,
        1.6
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_3_LAYER_1"
      },
      {
        "INGAME_PARALLAX_3",
        "FOREGROUND_3_LAYER_2"
      }
    },
    color = {
      r = 239,
      g = 214,
      b = 115
    },
    groundColor = {
      r = 47,
      g = 23,
      b = 14
    }
  },
  theme12 = {
    index = 12,
    music = "construction_theme1",
    graphicSetName = {
      "THEME_04",
      "THEME_04_COMPOSPRITES",
      "PARALLAX_CRANES"
    },
    texture = "THEME_04_THEME_GROUND_4",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_1",
        "BACKGROUND_4_LAYER_1",
        0.125,
        2
      },
      {
        "",
        "THEME_4_BG_LAYER_2",
        0.5,
        2
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_1",
        0.8,
        1,
        false,
        565
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_2",
        0.85,
        1.3,
        false,
        645
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_3",
        0.9,
        1.6,
        false,
        755
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_4",
        0.95,
        2,
        false,
        822
      },
      {
        "",
        "THEME_4_BG_LAYER_3",
        1,
        1.85
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_4_LAYER_1"
      },
      {
        "INGAME_PARALLAX_4",
        "FOREGROUND_4_LAYER_2"
      }
    },
    color = {
      r = 144,
      g = 205,
      b = 237
    },
    groundColor = {
      r = 28,
      g = 18,
      b = 12
    }
  },
  theme13 = {
    index = 13,
    music = "construction_theme1",
    texture = "THEME_05_THEME_GROUND_5",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    graphicSetName = {
      "THEME_05",
      "THEME_05_COMPOSPRITES",
      "PARALLAX_CRANES"
    },
    bgLayers = {
      {
        "INGAME_SKIES_1",
        "BACKGROUND_5_LAYER_1",
        0.125,
        2
      },
      {
        "",
        "THEME_5_BG_LAYER_2",
        0.5,
        2
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_1",
        0.8,
        1,
        false,
        565
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_2",
        0.85,
        1.3,
        false,
        645
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_3",
        0.9,
        1.6,
        false,
        755
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_4",
        0.95,
        2,
        false,
        822
      },
      {
        "",
        "THEME_5_BG_LAYER_3",
        1,
        1.8
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_5_LAYER_1"
      },
      {
        "INGAME_PARALLAX_5",
        "FOREGROUND_5_LAYER_2"
      }
    },
    color = {
      r = 241,
      g = 226,
      b = 140
    },
    groundColor = {
      r = 68,
      g = 39,
      b = 2
    }
  },
  theme14 = {
    index = 14,
    music = "construction_theme1",
    graphicSetName = {
      "THEME_06",
      "THEME_06_COMPOSPRITES",
      "PARALLAX_CRANES"
    },
    texture = "THEME_06_THEME_GROUND_6",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_2",
        "BACKGROUND_6_LAYER_1",
        0.3,
        4.5
      },
      {
        "",
        "THEME_6_BG_LAYER_2",
        0.55,
        3.3
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_1",
        0.8,
        1,
        false,
        565
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_2",
        0.85,
        1.3,
        false,
        645
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_3",
        0.9,
        1.6,
        false,
        755
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_4",
        0.95,
        2,
        false,
        822
      },
      {
        "",
        "THEME_6_BG_LAYER_3",
        1,
        2
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_6_LAYER_1"
      },
      {
        "INGAME_PARALLAX_6",
        "FOREGROUND_6_LAYER_2"
      }
    },
    color = {
      r = 74,
      g = 90,
      b = 44
    },
    groundColor = {
      r = 24,
      g = 28,
      b = 15
    }
  },
  theme15 = {
    index = 15,
    music = "construction_theme1",
    graphicSetName = {
      "THEME_07",
      "THEME_07_COMPOSPRITES",
      "PARALLAX_CRANES"
    },
    texture = "THEME_07_THEME_GROUND_7",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_2",
        "BACKGROUND_7_LAYER_1",
        0.125,
        3.5
      },
      {
        "",
        "THEME_7_BG_LAYER_2",
        0.5,
        3
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_1",
        0.8,
        1,
        false,
        565
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_2",
        0.85,
        1.3,
        false,
        645
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_3",
        0.9,
        1.6,
        false,
        755
      },
      {
        "INGAME_PARALLAX_CRANES",
        "PARALLAX_CRANE_4",
        0.95,
        2,
        false,
        822
      },
      {
        "",
        "THEME_7_BG_LAYER_3",
        1,
        2.8
      }
    },
    fgLayers = {
      {
        "INGAME_GROUNDS_1",
        "FOREGROUND_7_LAYER_1"
      },
      {
        "INGAME_PARALLAX_7",
        "FOREGROUND_7_LAYER_2"
      }
    },
    color = {
      r = 0,
      g = 0,
      b = 0
    },
    groundColor = {
      r = 17,
      g = 34,
      b = 69
    }
  },
  theme16 = {
    index = 16,
    music = "ambient_theme3",
    graphicSetName = {
      "THEME_09",
      "THEME_09_COMPOSPRITES"
    },
    texture = "THEME_09_THEME_GROUND_9",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "INGAME_SKIES_2",
        "BACKGROUND_10_LAYER_1",
        0.125,
        2.35
      },
      {
        "",
        "THEME_9_BG_LAYER_2",
        0.45,
        1.75
      },
      {
        "INGAME_PARALLAX_9",
        "BACKGROUND_10_LAYER_4",
        0.65,
        2
      }
    },
    fgLayers = {
      {
        "INGAME_PARALLAX_9",
        "FOREGROUND_10_LAYER_1"
      }
    },
    color = {
      r = 9,
      g = 85,
      b = 104
    },
    groundColor = {
      r = 51,
      g = 34,
      b = 34
    }
  },
  theme17 = {
    index = 17,
    music = "ambient_cave",
    graphicSetName = {
      "THEME_10",
      "THEME_10_COMPOSPRITES"
    },
    texture = "THEME_10_THEME_GROUND_CAVE",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "",
        "THEME_CAVE_PARALLAX_1",
        0.35,
        1.5
      },
      {
        "",
        "THEME_BG_1",
        0.45,
        2.5
      }
    },
    fgLayers = {
      {
        "",
        "THEME_CAVE_FG_1"
      }
    },
    color = {
      r = 14,
      g = 14,
      b = 27
    },
    groundColor = {
      r = 17,
      g = 17,
      b = 0
    }
  },
  theme18 = {
    index = 18,
    music = "birthday_ambience",
    graphicSetName = {
      "THEME_11",
      "THEME_11_COMPOSPRITES"
    },
    texture = "THEME_11_THEME_GROUND_BIRTHDAY",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "",
        "BIRTHDAY_SKY",
        0.1,
        3
      },
      {
        "",
        "THEME_11_MIDGROUND",
        0.35,
        2.5
      },
      {
        "",
        "THEME_11_MIDGROUND_2",
        0.45,
        2.5
      }
    },
    fgLayers = {
      {
        "",
        "BIRTHDAY_GROUND"
      }
    },
    color = {
      r = 99,
      g = 214,
      b = 244
    },
    groundColor = {
      r = 85,
      g = 0,
      b = 0
    }
  },
  theme19 = {
    index = 19,
    music = "beach_ambience",
    graphicSetName = {
      "THEME_12",
      "THEME_12_COMPOSPRITES",
      "BLOCKS_FB"
    },
    texture = "THEME_12_THEME_GROUND_12",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "",
        "BACKGROUND_12_LAYER_1",
        0.1,
        1.3
      },
      {
        "",
        "BACKGROUND_12_LAYER_3",
        0.25,
        1.25
      },
      {
        "",
        "THEME_12_BG_LAYER_1",
        0.25,
        1.25,
        true
      }
    },
    fgLayers = {
      {
        "",
        "FOREGROUND_12_LAYER_1"
      }
    },
    color = {
      r = 4,
      g = 56,
      b = 123
    },
    groundColor = {
      r = 234,
      g = 238,
      b = 132
    },
    mainMenuScale = 1.5
  },
  theme20 = {
    index = 20,
    music = "ambience_waterfall",
    graphicSetName = {
      "THEME_13",
      "THEME_13_COMPOSPRITES",
      "BLOCKS_FB"
    },
    texture = "THEME_13_THEME_GROUND_13",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "",
        "BACKGROUND_13_LAYER_1",
        0.1,
        1.5
      },
      {
        "",
        "BACKGROUND_13_LAYER_3",
        0.25,
        2,
        false,
        800
      },
      {
        "",
        "BACKGROUND_13_LAYER_2",
        0.375,
        2,
		800
      },
      {
        "",
        "BACKGROUND_13_LAYER_5",
        0.65,
        1.5
      }
    },
    fgLayers = {
      {
        "",
        "FOREGROUND_13_LAYER_1"
      }
    },
    color = {
      r = 248,
      g = 114,
      b = 98
    },
    groundColor = {
      r = 34,
      g = 68,
      b = 0
    },
    mainMenuScale = 2
  },
  theme21 = {
    index = 21,
    music = "rain_ambience",
    graphicSetName = {
	  "THEME_15",
	  "BLOCKS_FB"
	},
    texture = "THEME_15_THEME_GROUND_15", 
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "",
        "INGAME_SKIES_15",
        0.125,
        2
      },
      {
        rect = {
          r = 255,
          g = 255,
          b = 255,
          a = 0
        }
      },
      {
        "",
        "THEME_15_BG_LAYER_1",
        0.25,
        2
      },
      {
        "",
        "THEME_15_MASK",
        0.25,
        2
      },
      {
        "",
        "THEME_15_BG_LAYER_2",
        0.45,
        1.5
      }
    },
    fgLayers = {
      {
        "",
        "FOREGROUND_15_LAYER_1"
      },
      {
        "",
        "FOREGROUND_15_LAYER_2",
        1.2
      }
    },
    effects = {
      {
        type = "Thunder",
        params = {
          flash_layers = {2},
          shadow_layers = {4}
        }
      }
    },
    color = {
      r = 34,
      g = 17,
      b = 87
    },
    groundColor = {
      r = 17,
      g = 17,
      b = 34
    },
    mainMenuScale = 2.5
  },
  theme22 = {
    index = 999,
    music = "beach_ambience",
    graphicSetName = {
      "THEME_14",
      "BLOCKS_ABLAND"
    },
    texture = "THEME_14_THEME_GROUND_14",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "",
        "BACKGROUND_16_LAYER_1",
        1.0E-5,
        1.5
      },
      {
        "",
        "THEME_14_BG_SUN",
        0,
        1
      },
      {
        "",
        "THEME_14_BG_LAYER_4_2",
        0.1,
        1,
        v = 80
      },
      {
        "",
        "THEME_14_BG_LAYER_4",
        0.1,
        1.2,
        v = 180
      },
      {
        "",
        "THEME_14_BG_LAYER_3",
        0.2,
        0.8
      },
      {
        "",
        "THEME_14_BG_LAYER_2",
        0.4,
        1.1
      },
      {
        "",
        "THEME_14_BG_LAYER_1",
        0.65,
        1
      },
      {
        "",
        "THEME_14_BG_LAYER_1_2",
        0.9,
        1
      }
    },
    fgLayers = {
      {
        "",
        "FOREGROUND_16_LAYER_1"
      }
    },
    color = {
      r = 173,
      g = 210,
      b = 222
    },
    groundColor = {
      r = 17,
      g = 17,
      b = 17
    }
  },
  theme23 = {
    index = 22,
    music = "beach_ambience",
    graphicSetName = {
      "THEME_16",
      "BLOCKS_GREEN"
    },
    texture = "THEME_16_THEME_16_GROUND",
    playButtonSprite = {
      group = "TEXTS_BASIC",
      id = "TEXT_PLAY_SPRITE"
    },
    bgLayers = {
      {
        "",
        "INGAME_SKIES_16",
        0,
        2
      },
      {
        "",
        "THEME_16_BG_LAYER_3",
        0.05,
        2.4,
        v = -150
      },
      {
        "",
        "THEME_16_BG_LAYER_2",
        0.1,
        1.9,
        v = -200
      },
      {
        "",
        "THEME_16_BACKGROUND_LAYER_2",
        0.2,
        2.6
      },
      {
        "",
        "THEME_16_BACKGROUND_LAYER_1",
        0.5,
        2.3
      },
      {
        "",
        "THEME_16_BG_LAYER_1",
        0.9,
        0.8
      }
    },
    fgLayers = {
      {
        "",
        "THEME_16_FOREGROUND_SAND"
      },
      {
        "",
        "THEME_16_FOREGROUND_FOAM",
        1,
        1,
        v = -5
      },
      {
        "",
        "THEME_16_FOREGROUND_SEA",
        1,
        1,
        v = -5
      }
    },
    effects = {
      {
        type = "Waves",
        params = {
          water_layer = {
            index = 3,
            sprite = "THEME_16_FOREGROUND_SEA"
          },
          foam_layer = {
            index = 2,
            sprite = "THEME_16_FOREGROUND_FOAM"
          },
          ground_layer = {
            index = 1,
            sprite = "THEME_16_FOREGROUND_SAND"
          }
        }
      }
    },
    color = {
      r = 53,
      g = 174,
      b = 198
    },
    groundColor = {
      r = 68,
      g = 170,
      b = 153
    }
  }
}
groups = {
  staticBlocks = {
    keyUp = "X",
    keyDown = "Z",
    firstIndex = 1,
    lastIndex = 6
  },
  rockBlocks = {
    keyUp = "2",
    keyDown = "1",
    firstIndex = 1,
    lastIndex = 12
  },
  woodBlocks = {
    keyUp = "W",
    keyDown = "Q",
    firstIndex = 1,
    lastIndex = 12
  },
  lightBlocks = {
    keyUp = "S",
    keyDown = "A",
    firstIndex = 1,
    lastIndex = 12
  },
  birds = {
    keyUp = "4",
    keyDown = "3",
    firstIndex = 1,
    lastIndex = 11
  },
  piglettes = {
    keyUp = "R",
    keyDown = "E",
    firstIndex = 1,
    lastIndex = 6
  },
  extras = {
    keyUp = "6",
    keyDown = "5",
    firstIndex = 1,
    lastIndex = 94
  },
  decorations = {
    keyUp = "V",
    keyDown = "C",
    firstIndex = 1,
    lastIndex = 13
  },
  platforms = {
    keyUp = "Y",
    keyDown = "T",
    firstIndex = 1,
    lastIndex = 5
  },
  staticFragile = {
    keyUp = "N",
    keyDown = "M",
    firstIndex = 1,
    lastIndex = 6
  },
  clouds = {
    keyUp = "H",
    keyDown = "J",
    firstIndex = 1,
    lastIndex = 9
  },
  winds = {
    keyUp = "I",
    keyDown = "U",
    firstIndex = 1,
    lastIndex = 2
  }
}
damageFactors = {
  DefaultDamageFactors = {
    damageMultiplier = {
      wood = 1,
      rock = 1,
      light = 1,
      immovable = 0,
      staticGround = 0
    },
    velocityMultiplier = {
      wood = 1,
      rock = 1,
      light = 1,
      immovable = 1
    }
  },
  BlueBirdDamageFactors = {
    damageMultiplier = {
      wood = 1,
      rock = 1,
      light = 2.9,
      immovable = 0,
      staticGround = 0
    },
    velocityMultiplier = {
      wood = 1,
      rock = 1,
      light = 1.9,
      immovable = 1
    }
  },
  YellowBirdDamageFactors = {
    damageMultiplier = {
      wood = 2.4,
      rock = 1,
      light = 1,
      immovable = 0,
      staticGround = 0
    },
    velocityMultiplier = {
      wood = 1,
      rock = 1,
      light = 1,
      immovable = 1
    }
  },
  BlackBirdDamageFactors = {
    damageMultiplier = {
      wood = 1,
      rock = 4,
      light = 1,
      immovable = 0,
      staticGround = 0
    },
    velocityMultiplier = {
      wood = 1,
      rock = 1,
      light = 1,
      immovable = 1
    }
  },
  RedBigBirdDamageFactors = {
    damageMultiplier = {
      wood = 0.3,
      rock = 0.3,
      light = 0.3,
      immovable = 0,
      staticGround = 0
    },
    velocityMultiplier = {
      wood = 1.8,
      rock = 1.8,
      light = 1.8,
      immovable = 1
    }
  },
  BoomerangBirdDamageFactors = {
    damageMultiplier = {
      wood = 1.6,
      rock = 0.8,
      light = 1.4,
      immovable = 0,
      staticGround = 0
    },
    velocityMultiplier = {
      wood = 1.3,
      rock = 1,
      light = 1.3,
      immovable = 1
    }
  },
  GlobeBirdDamageFactors = {
    damageMultiplier = {
      wood = 3,
      rock = 1.5,
      light = 3,
      immovable = 0,
      staticGround = 0,
      snowStaticFragile = 5
    },
    velocityMultiplier = {
      wood = 4,
      rock = 4,
      light = 4,
      immovable = 1
    }
  },
  GlobeBirdBigDamageFactors = {
    damageMultiplier = {
      wood = 0,
      rock = 0,
      light = 0,
      immovable = 0,
      staticGround = 0,
      snowStaticFragile = 0
    },
    velocityMultiplier = {
      wood = 2,
      rock = 2,
      light = 2,
      immovable = 1
    }
  },
  MightyEagleBirdDamageFactors = {
    damageMultiplier = {
      wood = 1000000,
      rock = 1000000,
      light = 1000000,
      immovable = 1000000,
      staticGround = 0
    },
    velocityMultiplier = {
      wood = 555,
      rock = 555,
      light = 555,
      immovable = 555
    }
  }
}
blocks = {
  SmallBlueBird = {
    radius = 0.6,
    friction = 0.3,
    type = "circle",
    restitution = 0.25,
    sprite = "BIRD_BLUE",
    spriteFlying = "BIRD_BLUE",
    spriteCollision = "BIRD_BLUE_COLLISION",
    spriteAction = "HUD_ICON_SPLIT",
    spriteScore = "10K_BLUE",
    spriteYell = "BIRD_BLUE_YELL",
    spriteBlink = "BIRD_BLUE_BLINK",
    allowRoll = true,
    density = 4.5,
    damageFactors = "BlueBirdDamageFactors",
    controllable = true,
    material = "light",
    strength = 60,
    group = "birds",
    groupIndex = 2,
    particles = "blueBuff",
    particlesAmountLimits = {12, 20},
    particlesTrail = "blueBirdTrail",
    collisionSound = "bird_02_collision",
    launchSound = "bird_02_flying",
    specialSound = "special_group",
    selectionSound = "bird_02_select",
    unselectionSound = "bird_02_unselect",
    specialty = "CLUSTER_BOMB",
    tutorialInfo = "TUTORIAL_2",
    useLegacyCollisionPath = true
  },
  RedBird = {
    radius = 0.85,
    friction = 0.3,
    type = "circle",
    restitution = 0.43,
    sprite = "BIRD_RED",
    spriteFlying = "BIRD_RED_FLYING",
    spriteCollision = "BIRD_RED_COLLISION",
    spriteAction = "HUD_ICON_NOTE",
    spriteScore = "10K_RED",
    spriteYell = "BIRD_RED_YELL",
    spriteBlink = "BIRD_RED_BLINK",
    allowRoll = true,
    density = 6,
    damageFactors = "DefaultDamageFactors",
    controllable = true,
    material = "red",
    strength = 60,
    group = "birds",
    groupIndex = 1,
    particles = "redBuff",
    particlesAmountLimits = {12, 20},
    particlesTrail = "redBirdTrail",
    collisionSound = "bird_01_collision",
    launchSound = "bird_01_flying",
    specialSound = "red_special",
    selectionSound = "bird_01_select",
    unselectionSound = "bird_01_unselect",
    specialty = "SOUND",
    tutorialInfo = "TUTORIAL_1",
    useLegacyCollisionPath = true
  },
  YellowBird = {
    radius = 0.8,
    friction = 0.3,
    type = "circle",
    restitution = 0.23,
    sprite = "BIRD_YELLOW",
    spriteFlying = "BIRD_YELLOW_FLYING",
    spriteCollision = "BIRD_YELLOW_COLLISION",
    spriteAction = "HUD_ICON_BOOST",
    spriteScore = "10K_YELLOW",
    spriteYell = "BIRD_YELLOW_YELL",
    spriteBlink = "BIRD_YELLOW_BLINK",
    spriteSpecial = "BIRD_YELLOW_SPECIAL",
    allowRoll = true,
    density = 6,
    damageFactors = "YellowBirdDamageFactors",
    controllable = true,
    material = "wood",
    strength = 60,
    group = "birds",
    groupIndex = 3,
    particles = "yellowBuff",
    particlesAmountLimits = {12, 20},
    particlesTrail = "yellowBirdTrail",
    collisionSound = "bird_03_collision",
    launchSound = "bird_03_flying",
    specialSound = "special_boost",
    selectionSound = "bird_03_select",
    unselectionSound = "bird_03_unselect",
    specialty = "BOOST",
    tutorialInfo = "TUTORIAL_3",
    useLegacyCollisionPath = true
  },
  BlackBird = {
    radius = 1,
    friction = 0.3,
    type = "circle",
    restitution = 0.03,
    sprite = "BIRD_GREY",
    spriteFlying = "BIRD_GREY_FLYING",
    spriteCollision = "BIRD_GREY_FLYING",
    spriteAction = "HUD_ICON_EXPLOSION",
    spriteScore = "10K_BLACK",
    spriteYell = "BIRD_GREY_YELL",
    spriteBlink = "BIRD_GREY_BLINK",
    spriteSpecial1 = "BIRD_GREY_1",
    spriteSpecial2 = "BIRD_GREY_2",
    spriteSpecial3 = "BIRD_GREY_3",
    density = 6,
    damageFactors = "BlackBirdDamageFactors",
    controllable = true,
    material = "rock",
    strength = 60,
    group = "birds",
    groupIndex = 5,
    particles = "blackBuff",
    particlesAmountLimits = {12, 20},
    particlesTrail = "bombBirdTrail",
    collisionSound = "bird_04_collision",
    launchSound = "bird_04_flying",
    specialSound = "special_explosion",
    selectionSound = "bird_04_select",
    unselectionSound = "bird_04_unselect",
    specialty = "BOMB",
    explosionRadius = 15,
    explosionForce = 40000,
    explosionDamageRadius = 5,
    explosionDamage = 300,
    tutorialInfo = "TUTORIAL_4",
    useLegacyCollisionPath = true
  },
  BasicBird2 = {
    radius = 1.3,
    friction = 0.3,
    type = "circle",
    restitution = 0.23,
    sprite = "BIRD_GREEN",
    spriteFlying = "BIRD_GREEN_FLYING",
    spriteCollision = "BIRD_GREEN_COLLISION",
    spriteAction = "HUD_ICON_EGG",
    spriteScore = "10K_WHITE",
    spriteYell = "BIRD_GREEN_YELL",
    spriteBlink = "BIRD_GREEN_BLINK",
    spriteSpecial = "BIRD_GREEN_SPECIAL",
    density = 4.5,
    damageFactors = "DefaultDamageFactors",
    controllable = true,
    material = "red",
    strength = 60,
    group = "birds",
    groupIndex = 4,
    particles = "greenBuff",
    particlesAmountLimits = {12, 20},
    particlesTrail = "bomberBirdTrail",
    collisionSound = "bird_05_collision",
    launchSound = "bird_05_flying",
    specialSound = "special_egg",
    selectionSound = "bird_05_select",
    unselectionSound = "bird_05_unselect",
    specialty = "GRENADE",
    projectile = "EggGranade",
    explosionRadius = 10,
    explosionForce = 20000,
    explosionDamageRadius = 5,
    explosionDamage = 200,
    tutorialInfo = "TUTORIAL_5",
    useLegacyCollisionPath = true
  },
  EggGranade = {
    friction = 0.3,
    type = "circle",
    restitution = 0.23,
    sprite = "DROPPABLE_EGG",
    density = 3,
    damageFactors = "DefaultDamageFactors",
    controllable = true,
    material = "red",
    strength = 60,
    particles = "explosionBuff",
    specialty = "BOMB",
    explosionRadius = 10,
    explosionForce = 10000,
    explosionDamageRadius = 8,
    explosionDamage = 400,
    useLegacyCollisionPath = true,
    particles = "eggShells"
  },
  RedBigBird = {
    radius = 1.8,
    friction = 0.3,
    type = "circle",
    restitution = 0.45,
    sprite = "BIRD_BIG_BROTHER",
    spriteFlying = "BIRD_BIG_BROTHER",
    spriteCollision = "BIRD_BIG_BROTHER",
    spriteAction = "HUD_ICON_NOTE",
    spriteScore = "10K_RED",
    spriteYell = "BIRD_BIG_BROTHER_YELL",
    spriteBlink = "BIRD_BIG_BROTHER_BLINK",
    allowRoll = true,
    density = 10,
    damageFactors = "RedBigBirdDamageFactors",
    controllable = true,
    material = "red",
    strength = 60,
    group = "birds",
    groupIndex = 6,
    particles = "bigBrotherBuff",
    particlesAmountLimits = {12, 20},
    particlesTrail = "redBirdTrail",
    collisionSound = "big_brother_collision",
    launchSound = "big_brother_flying",
    specialSound = "big_brother_special",
    selectionSound = "big_brother_select",
    unselectionSound = "bird_01_unselect",
    specialty = "SOUND",
    tutorialInfo = "TUTORIAL_7"
  },
  BoomerangBird = {
    radius = 1.5,
    friction = 0.3,
    type = "circle",
    restitution = 0.23,
    sprite = "BIRD_BOOMERANG",
    spriteFlying = "BIRD_BOOMERANG",
    spriteCollision = "BIRD_BOOMERANG_COLLISION",
    spriteYell = "BIRD_BOOMERANG_YELL",
    spriteAction = "HUD_ICON_BOOST",
    spriteScore = "10K_BOOMERANG",
    spriteBlink = "BIRD_BOOMERANG_BLINK",
    spriteSpecial = "BIRD_BOOMERANG_SPECIAL",
    allowRoll = true,
    density = 3,
    damageFactors = "BoomerangBirdDamageFactors",
    controllable = true,
    material = "wood",
    strength = 60,
    group = "birds",
    groupIndex = 7,
    particles = "boomerangBuff",
    particlesAmountLimits = {12, 20},
    particlesTrail = "yellowBirdTrail",
    collisionSound = "bird_03_collision",
    launchSound = "bird_06_flying",
    specialSound = "boomerang_activate",
    selectionSound = "boomerang_select",
    unselectionSound = "bird_03_unselect",
    specialty = "BOOMERANG",
    boomerangHorizontalForce = -50,
    boomerangVerticalForce = -350,
    boomerangMaxHorizontalSpeed = 50,
    flyVerticalForce = -60,
    tutorialInfo = "TUTORIAL_6"
  },
  MightyEagleBird = {
    radius = 5,
    friction = 0.1,
    type = "circle",
    restitution = 0.05,
    sprite = "BIRD_MIGHTY_EAGLE_MOTION",
    spriteFlying = "BIRD_MIGHTY_EAGLE_RADIAL",
    spriteCollision = "BIRD_MIGHTY_EAGLE_MOTION",
    spriteAction = "BIRD_MIGHTY_EAGLE_RADIAL",
    spriteScore = "BIRD_MIGHTY_EAGLE_RADIAL",
    spriteYell = "BIRD_MIGHTY_EAGLE_RADIAL",
    spriteBlink = "BIRD_MIGHTY_EAGLE_RADIAL",
    allowRoll = true,
    density = 100,
    damageFactors = "MightyEagleBirdDamageFactors",
    controllable = true,
    material = "red",
    strength = 60000,
    group = "birds",
    groupIndex = 8,
    particles = "smokeBuff",
    particlesAmountLimits = {1, 1},
    particlesTrail = "redBirdTrail",
    collisionSound = "big_brother_collision",
    launchSound = "",
    specialSound = "",
    selectionSound = "",
    unselectionSound = "",
    specialty = "MIGHTY_EAGLE",
    tutorialInfo = "TUTORIAL_8",
    explosionRadius = 100,
    explosionForce = 20000,
    explosionDamageRadius = 100,
    explosionDamage = 1,
    z_order = 999,
    collisionFunction = "mightyEagleCollision",--TODO
    frozenFunction = "mightyEagleFrozen",
    updateFunction = "updateMightyEagle",
    collider_type = collider_types.mighty_eagle
  },
  BaitSardine = {
    friction = 0.25,
    type = "box",
    restitution = 0.05,
    sprite = "BAIT_SARDINE",
    spriteFlying = "BAIT_SARDINE",
    spriteCollision = "BAIT_SARDINE",
    spriteAction = "BAIT_SARDINE",
    spriteScore = "BAIT_SARDINE",
    spriteYell = "BAIT_SARDINE",
    spriteBlink = "BAIT_SARDINE",
    allowRoll = true,
    density = 1,
    damageFactors = "DefaultDamageFactors",
    controllable = true,
    material = "common",
    strength = 1,
    group = "birds",
    groupIndex = 9,
    particles = "",
    particlesAmountLimits = {0, 0},
    particlesTrail = "redBirdTrail",
    collisionSound = "sardine_can_physics_a2",
    launchSound = "sardine_can_shot",
    specialSound = "mighty_eagle_yell",
    selectionSound = "",
    destroyedSound = "light_destroyed",
    unselectionSound = "",
    specialty = "SUMMON_MIGHTY_EAGLE",
    tutorialInfo = "TUTORIAL_8",
    collisionFunction = "mightyEagleBaitCollision",--TODO
    frozenFunction = "mightyEagleBaitFrozen",
    updateFunction = "updateMightyEagleBait",
    timerFunction = "mightyEagleAndBaitTimerUpdate"
  },
  GlobeBird = {
    definition = "GlobeBird",
    type = "circle",
    bounceAmplitudeMultiplier = 1,
    bounceFrequencyMultiplier = 1,
    scale = 0.3,
    radius = 0.85,
    friction = 0.3,
    restitution = 0.25,
    density = 5,
    allowRoll = true,
    group = "birds",
    groupIndex = 10,
    damageFactors = "GlobeBirdDamageFactors",
    controllable = true,
    material = "stone",
    strength = 60,
    particles = {"orangeBuff", "smokeBuff"},
    particlesTrail = "redBirdTrail",
    tutorialInfo = "TUTORIAL_9",
    useLegacyCollisionPath = true,
    rotateWhileFlying = true,
    z_order = 2,
    specialty = "GLOBE",
    explosionRadius = 8,
    explosionForce = 45000,
    explosionDamageRadius = 5,
    explosionDamage = 0,
    puffedDefinition = "GlobeBirdBig",
    sprite = "BIRD_PUFFER_1",
    spriteFlying = "BIRD_PUFFER_1",
    spriteCollision = "BIRD_PUFFER_1",
    spriteYell = "BIRD_PUFFER_YELL",
    spriteAction = "BIRD_PUFFER_1",
    spriteScore = "10K_ORANGE",
    spriteBlink = "BIRD_PUFFER_BLINK",
    collisionSound = "globe_hit",
    launchSound = "Globe_Bird_Launch_3",
    specialSound = "globe_special",
    selectionSound = "Globe_Bird_Selection_1",
    unselectionSound = "bird_03_unselect"
  },
  GlobeBirdBig = {
    definition = "GlobeBirdBig",
    type = "circle",
    bounceAmplitudeMultiplier = 1,
    bounceFrequencyMultiplier = 1,
    radius = 7.5,
    friction = 0.5,
    restitution = 0,
    density = 0.1,
    allowRoll = true,
    group = "birds",
    groupIndex = 11,
    damageFactors = "DefaultDamageFactors",
    controllable = true,
    material = "stone",
    strength = 60,
    particles = "orangeBuff",
    particlesTrail = "redBirdTrail",
    tutorialInfo = "TUTORIAL_9",
    useLegacyCollisionPath = true,
    rotateWhileFlying = true,
    z_order = 2,
    isPuffed = true,
    explosionRadius = 8,
    explosionForce = 15000,
    explosionDamageRadius = 5,
    explosionDamage = 0,
    sprite = "BIRD_PUFFER_2",
    spriteFlying = "BIRD_PUFFER_2",
    spriteCollision = "BIRD_PUFFER_2",
    spriteYell = "BIRD_PUFFER_2",
    spriteAction = "BIRD_PUFFER_2",
    spriteScore = "10K_ORANGE",
    spriteBlink = "BIRD_PUFFER_2",
    collisionSound = "globe_hit",
    launchSound = "Globe_Bird_Launch_3",
    specialSound = "globe_special",
    selectionSound = "Globe_Bird_Selection_1",
    unselectionSound = "bird_03_unselect",
    removeSound = "Globe_Bird_Death_remove_1"
  },
  SmallPiglette = {
    radius = 1.075,
    type = "circle",
    sprite = "PIGLETTE_SMALL_01",
    controllable = false,
    levelGoal = true,
    material = "piglette",
    strength = 4,
    particles = "smokeBuff",
    spriteScore = "5K_GREEN",
    group = "piglettes",
    groupIndex = 1,
    damageSprites = {
      damage1 = {
        sprite = "PIGLETTE_SMALL_01",
        blinkSprite = "PIGLETTE_SMALL_01_BLINK",
        smileSprite = "PIGLETTE_SMALL_01_SMILE",
        max = 100,
        min = 90
      },
      damage2 = {
        sprite = "PIGLETTE_SMALL_02",
        blinkSprite = "PIGLETTE_SMALL_02_BLINK",
        smileSprite = "PIGLETTE_SMALL_02_SMILE",
        max = 90,
        min = 50
      },
      damage3 = {
        sprite = "PIGLETTE_SMALL_03",
        blinkSprite = "PIGLETTE_SMALL_03_BLINK",
        smileSprite = "PIGLETTE_SMALL_03_SMILE",
        max = 50,
        min = -1000
      }
    }
  },
  MediumPiglette = {
    radius = 1.85,
    friction = 0.3,
    type = "circle",
    sprite = "PIGLETTE_MEDIUM_01",
    density = 2,
    controllable = false,
    levelGoal = true,
    material = "piglette",
    strength = 10,
    defence = 1,
    particles = "smokeBuff",
    spriteScore = "5K_GREEN",
    group = "piglettes",
    groupIndex = 2,
    damageSprites = {
      damage1 = {
        sprite = "PIGLETTE_MEDIUM_01",
        blinkSprite = "PIGLETTE_MEDIUM_01_BLINK",
        smileSprite = "PIGLETTE_MEDIUM_01_SMILE",
        max = 100,
        min = 90
      },
      damage2 = {
        sprite = "PIGLETTE_MEDIUM_02",
        blinkSprite = "PIGLETTE_MEDIUM_02_BLINK",
        smileSprite = "PIGLETTE_MEDIUM_02_SMILE",
        max = 90,
        min = 50
      },
      damage3 = {
        sprite = "PIGLETTE_MEDIUM_03",
        blinkSprite = "PIGLETTE_MEDIUM_03_BLINK",
        smileSprite = "PIGLETTE_MEDIUM_03_SMILE",
        max = 50,
        min = -1000
      }
    }
  },
  HelmetPiglette = {
    radius = 1.95,
    friction = 0.3,
    type = "circle",
    sprite = "PIGLETTE_HELMET_01",
    density = 2,
    controllable = false,
    levelGoal = true,
    material = "piglette",
    strength = 15,
    defence = 8,
    particles = "smokeBuff",
    spriteScore = "5K_GREEN",
    group = "piglettes",
    groupIndex = 3,
    damageSprites = {
      damage1 = {
        sprite = "PIGLETTE_HELMET_01",
        blinkSprite = "PIGLETTE_HELMET_01_BLINK",
        smileSprite = "PIGLETTE_HELMET_01_SMILE",
        max = 100,
        min = 90
      },
      damage2 = {
        sprite = "PIGLETTE_HELMET_02",
        blinkSprite = "PIGLETTE_HELMET_02_BLINK",
        smileSprite = "PIGLETTE_HELMET_02_SMILE",
        max = 90,
        min = 50
      },
      damage3 = {
        sprite = "PIGLETTE_HELMET_03",
        blinkSprite = "PIGLETTE_HELMET_03_BLINK",
        smileSprite = "PIGLETTE_HELMET_03_SMILE",
        max = 50,
        min = -1000
      }
    }
  },
  LargePiglette = {
    radius = 2.325,
    friction = 0.3,
    type = "circle",
    sprite = "PIGLETTE_BIG_01",
    density = 1,
    controllable = false,
    levelGoal = true,
    material = "piglette",
    strength = 20,
    particles = "smokeBuff",
    spriteScore = "5K_GREEN",
    group = "piglettes",
    groupIndex = 4,
    damageSprites = {
      damage1 = {
        sprite = "PIGLETTE_BIG_01",
        blinkSprite = "PIGLETTE_BIG_01_BLINK",
        smileSprite = "PIGLETTE_BIG_01_SMILE",
        max = 100,
        min = 90
      },
      damage2 = {
        sprite = "PIGLETTE_BIG_02",
        blinkSprite = "PIGLETTE_BIG_02_BLINK",
        smileSprite = "PIGLETTE_BIG_02_SMILE",
        max = 90,
        min = 50
      },
      damage3 = {
        sprite = "PIGLETTE_BIG_03",
        blinkSprite = "PIGLETTE_BIG_03_BLINK",
        smileSprite = "PIGLETTE_BIG_03_SMILE",
        max = 50,
        min = -1000
      }
    }
  },
  GrandpaPiglette = {
    radius = 2.2,
    friction = 0.3,
    type = "circle",
    sprite = "PIGLETTE_GRANDPA_01",
    density = 1,
    controllable = false,
    levelGoal = true,
    material = "piglette",
    strength = 30,
    particles = "smokeBuff",
    spriteScore = "5K_GREEN",
    group = "piglettes",
    groupIndex = 5,
    damageSprites = {
      damage1 = {
        sprite = "PIGLETTE_GRANDPA_01",
        blinkSprite = "PIGLETTE_GRANDPA_01_BLINK",
        smileSprite = "PIGLETTE_GRANDPA_04_SMILE",
        max = 100,
        min = 90
      },
      damage2 = {
        sprite = "PIGLETTE_GRANDPA_02",
        blinkSprite = "PIGLETTE_GRANDPA_02_BLINK",
        smileSprite = "PIGLETTE_GRANDPA_05_SMILE",
        max = 90,
        min = 50
      },
      damage3 = {
        sprite = "PIGLETTE_GRANDPA_03",
        blinkSprite = "PIGLETTE_GRANDPA_03_BLINK",
        smileSprite = "PIGLETTE_GRANDPA_06_SMILE",
        max = 50,
        min = -1000
      }
    }
  },
  KingPiglette = {
    radius = 2.825,
    friction = 0.3,
    type = "circle",
    sprite = "PIGLETTE_KING_01",
    density = 1,
    controllable = false,
    levelGoal = true,
    material = "piglette",
    defence = 0,
    strength = 100,
    particles = "smokeBuff",
    spriteScore = "5K_GREEN",
    group = "piglettes",
    groupIndex = 6,
    damageSprites = {
      damage1 = {
        sprite = "PIGLETTE_KING_01",
        blinkSprite = "PIGLETTE_KING_01_BLINK",
        smileSprite = "PIGLETTE_KING_07_SMILE",
        max = 100,
        min = 90
      },
      damage2 = {
        sprite = "PIGLETTE_KING_02",
        blinkSprite = "PIGLETTE_KING_02_BLINK",
        smileSprite = "PIGLETTE_KING_08_SMILE",
        max = 90,
        min = 50
      },
      damage3 = {
        sprite = "PIGLETTE_KING_03",
        blinkSprite = "PIGLETTE_KING_03_BLINK",
        smileSprite = "PIGLETTE_KING_09_SMILE",
        max = 50,
        min = -1000
      }
    }
  },
  WoodBlock1 = {
    type = "box",
    sprite = "BLOCK_WOOD_1_1",
    controllable = false,
    material = "wood",
    group = "woodBlocks",
    groupIndex = 1,
    strength = 20,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_WOOD_1_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_WOOD_2_1",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_WOOD_3_1",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_WOOD_4_1",
        max = 25,
        min = -1000
      }
    }
  },
  WoodBlock2 = {
    type = "box",
    sprite = "BLOCK_WOOD_1_2",
    controllable = false,
    material = "wood",
    group = "woodBlocks",
    groupIndex = 2,
    strength = 40,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_WOOD_1_2",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_WOOD_2_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_WOOD_3_2",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_WOOD_4_2",
        max = 25,
        min = -1000
      }
    }
  },
  WoodBlock3 = {
    type = "box",
    sprite = "BLOCK_WOOD_1_3",
    controllable = false,
    material = "wood",
    group = "woodBlocks",
    groupIndex = 3,
    strength = 60,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_WOOD_1_3",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_WOOD_2_3",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_WOOD_3_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_WOOD_4_3",
        max = 25,
        min = -1000
      }
    }
  },
  WoodBlock4 = {
    type = "box",
    sprite = "BLOCK_WOOD_1_4",
    controllable = false,
    material = "wood",
    group = "woodBlocks",
    groupIndex = 4,
    strength = 50,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_WOOD_1_4",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_WOOD_2_4",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_WOOD_3_4",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_WOOD_4_4",
        max = 25,
        min = -1000
      }
    }
  },
  WoodBlock5 = {
    type = "box",
    sprite = "BLOCK_WOOD_1_5",
    controllable = false,
    material = "wood",
    group = "woodBlocks",
    groupIndex = 5,
    strength = 80,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_WOOD_1_5",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_WOOD_2_5",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_WOOD_3_5",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_WOOD_4_5",
        max = 25,
        min = -1000
      }
    }
  },
  WoodBlock6 = {
    type = "box",
    sprite = "BLOCK_WOOD_1_6",
    controllable = false,
    material = "wood",
    group = "woodBlocks",
    groupIndex = 6,
    strength = 70,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_WOOD_1_6",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_WOOD_2_6",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_WOOD_3_6",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_WOOD_4_6",
        max = 25,
        min = -1000
      }
    }
  },
  WoodBlock7 = {
    type = "circle",
    sprite = "BLOCK_WOOD_1_7",
    controllable = false,
    material = "wood",
    group = "woodBlocks",
    groupIndex = 7,
    strength = 200,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_WOOD_1_7",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_WOOD_2_7",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_WOOD_3_7",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_WOOD_4_7",
        max = 25,
        min = -1000
      }
    }
  },
  WoodBlock8 = {
    type = "circle",
    sprite = "BLOCK_WOOD_1_8",
    controllable = false,
    material = "wood",
    group = "woodBlocks",
    groupIndex = 8,
    strength = 150,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_WOOD_1_8",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_WOOD_2_8",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_WOOD_3_8",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_WOOD_4_8",
        max = 25,
        min = -1000
      }
    }
  },
  WoodBlock9 = {
    type = "box",
    sprite = "BLOCK_WOOD_4X4_1",
    controllable = false,
    material = "wood",
    group = "woodBlocks",
    groupIndex = 9,
    strength = 120,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_WOOD_4X4_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_WOOD_4X4_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_WOOD_4X4_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_WOOD_4X4_4",
        max = 25,
        min = -1000
      }
    }
  },
  WoodBlock10 = {
    type = "box",
    sprite = "BLOCK_WOOD_10X1_1",
    controllable = false,
    material = "wood",
    group = "woodBlocks",
    groupIndex = 10,
    strength = 100,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_WOOD_10X1_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_WOOD_10X1_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_WOOD_10X1_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_WOOD_10X1_4",
        max = 25,
        min = -1000
      }
    }
  },
  WoodBlock11 = {
    type = "polygon",
    vertices = {
      {x = 0, y = 0},
      {x = 1, y = 1},
      {x = 0, y = 1}
    },
    sprite = "BLOCK_WOOD_TRIANGLE_L_1",
    controllable = false,
    material = "wood",
    group = "woodBlocks",
    groupIndex = 11,
    strength = 80,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_WOOD_TRIANGLE_L_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_WOOD_TRIANGLE_L_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_WOOD_TRIANGLE_L_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_WOOD_TRIANGLE_L_4",
        max = 25,
        min = -1000
      }
    }
  },
  WoodBlock12 = {
    type = "polygon",
    vertices = {
      {x = 0.5, y = 0},
      {x = 1, y = 1},
      {x = 0, y = 1}
    },
    sprite = "BLOCK_WOOD_TRIANGLE_M_1",
    controllable = false,
    material = "wood",
    group = "woodBlocks",
    groupIndex = 12,
    strength = 70,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_WOOD_TRIANGLE_M_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_WOOD_TRIANGLE_M_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_WOOD_TRIANGLE_M_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_WOOD_TRIANGLE_M_4",
        max = 25,
        min = -1000
      }
    }
  },
  StoneBlock1 = {
    type = "box",
    sprite = "BLOCK_ROCK_1_1",
    controllable = false,
    material = "rock",
    group = "rockBlocks",
    groupIndex = 1,
    strength = 30,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_ROCK_1_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_ROCK_2_1",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_ROCK_3_1",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_ROCK_4_1",
        max = 25,
        min = -1000
      }
    }
  },
  StoneBlock2 = {
    type = "box",
    sprite = "BLOCK_ROCK_1_2",
    controllable = false,
    material = "rock",
    group = "rockBlocks",
    groupIndex = 2,
    strength = 60,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_ROCK_1_2",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_ROCK_2_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_ROCK_3_2",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_ROCK_4_2",
        max = 25,
        min = -1000
      }
    }
  },
  StoneBlock3 = {
    type = "box",
    sprite = "BLOCK_ROCK_1_3",
    controllable = false,
    material = "rock",
    group = "rockBlocks",
    groupIndex = 3,
    strength = 100,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_ROCK_1_3",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_ROCK_2_3",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_ROCK_3_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_ROCK_4_3",
        max = 25,
        min = -1000
      }
    }
  },
  StoneBlock4 = {
    type = "box",
    sprite = "BLOCK_ROCK_1_4",
    controllable = false,
    material = "rock",
    group = "rockBlocks",
    groupIndex = 4,
    strength = 80,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_ROCK_1_4",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_ROCK_2_4",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_ROCK_3_4",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_ROCK_4_4",
        max = 25,
        min = -1000
      }
    }
  },
  StoneBlock5 = {
    type = "box",
    sprite = "BLOCK_ROCK_1_5",
    controllable = false,
    material = "rock",
    group = "rockBlocks",
    groupIndex = 5,
    strength = 140,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_ROCK_1_5",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_ROCK_2_5",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_ROCK_3_5",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_ROCK_4_5",
        max = 25,
        min = -1000
      }
    }
  },
  StoneBlock6 = {
    type = "box",
    sprite = "BLOCK_ROCK_1_6",
    controllable = false,
    material = "rock",
    group = "rockBlocks",
    groupIndex = 6,
    strength = 120,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_ROCK_1_6",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_ROCK_2_6",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_ROCK_3_6",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_ROCK_4_6",
        max = 25,
        min = -1000
      }
    }
  },
  StoneBlock7 = {
    type = "circle",
    sprite = "BLOCK_ROCK_1_7",
    controllable = false,
    material = "rock",
    group = "rockBlocks",
    strength = 600,
    groupIndex = 7,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_ROCK_1_7",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_ROCK_2_7",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_ROCK_3_7",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_ROCK_4_7",
        max = 25,
        min = -1000
      }
    }
  },
  StoneBlock8 = {
    type = "circle",
    sprite = "BLOCK_ROCK_1_8",
    controllable = false,
    material = "rock",
    group = "rockBlocks",
    groupIndex = 8,
    strength = 300,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_ROCK_1_8",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_ROCK_2_8",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_ROCK_3_8",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_ROCK_4_8",
        max = 25,
        min = -1000
      }
    }
  },
  StoneBlock9 = {
    type = "box",
    sprite = "BLOCK_ROCK_4X4_1",
    controllable = false,
    material = "rock",
    group = "rockBlocks",
    groupIndex = 9,
    strength = 160,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_ROCK_4X4_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_ROCK_4X4_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_ROCK_4X4_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_ROCK_4X4_4",
        max = 25,
        min = -1000
      }
    }
  },
  StoneBlock10 = {
    type = "box",
    sprite = "BLOCK_ROCK_10X1_1",
    controllable = false,
    material = "rock",
    group = "rockBlocks",
    groupIndex = 10,
    strength = 140,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_ROCK_10X1_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_ROCK_10X1_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_ROCK_10X1_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_ROCK_10X1_4",
        max = 25,
        min = -1000
      }
    }
  },
  StoneBlock11 = {
    type = "polygon",
    vertices = {
      {x = 0, y = 0},
      {x = 1, y = 1},
      {x = 0, y = 1}
    },
    sprite = "BLOCK_ROCK_TRIANGLE_L_1",
    controllable = false,
    material = "rock",
    group = "rockBlocks",
    groupIndex = 11,
    strength = 140,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_ROCK_TRIANGLE_L_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_ROCK_TRIANGLE_L_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_ROCK_TRIANGLE_L_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_ROCK_TRIANGLE_L_4",
        max = 25,
        min = -1000
      }
    }
  },
  StoneBlock12 = {
    type = "polygon",
    vertices = {
      {x = 0.5, y = 0},
      {x = 1, y = 1},
      {x = 0, y = 1}
    },
    sprite = "BLOCK_ROCK_TRIANGLE_M_1",
    controllable = false,
    material = "rock",
    group = "rockBlocks",
    groupIndex = 12,
    strength = 140,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_ROCK_TRIANGLE_M_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_ROCK_TRIANGLE_M_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_ROCK_TRIANGLE_M_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_ROCK_TRIANGLE_M_4",
        max = 25,
        min = -1000
      }
    }
  },
  LightBlock1 = {
    type = "box",
    sprite = "BLOCK_LIGHT_1_1",
    controllable = false,
    material = "light",
    group = "lightBlocks",
    groupIndex = 1,
    strength = 13,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_LIGHT_1_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_LIGHT_2_1",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_LIGHT_3_1",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_LIGHT_4_1",
        max = 25,
        min = -1000
      }
    }
  },
  LightBlock2 = {
    type = "box",
    sprite = "BLOCK_LIGHT_1_2",
    controllable = false,
    material = "light",
    group = "lightBlocks",
    groupIndex = 2,
    strength = 26,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_LIGHT_1_2",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_LIGHT_2_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_LIGHT_3_2",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_LIGHT_4_2",
        max = 25,
        min = -1000
      }
    }
  },
  LightBlock3 = {
    type = "box",
    sprite = "BLOCK_LIGHT_1_3",
    controllable = false,
    material = "light",
    group = "lightBlocks",
    groupIndex = 3,
    strength = 40,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_LIGHT_1_3",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_LIGHT_2_3",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_LIGHT_3_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_LIGHT_4_3",
        max = 25,
        min = -1000
      }
    }
  },
  LightBlock4 = {
    type = "box",
    sprite = "BLOCK_LIGHT_1_4",
    controllable = false,
    material = "light",
    group = "lightBlocks",
    groupIndex = 4,
    strength = 33,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_LIGHT_1_4",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_LIGHT_2_4",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_LIGHT_3_4",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_LIGHT_4_4",
        max = 25,
        min = -1000
      }
    }
  },
  LightBlock5 = {
    type = "box",
    sprite = "BLOCK_LIGHT_1_5",
    controllable = false,
    material = "light",
    group = "lightBlocks",
    groupIndex = 5,
    strength = 53,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_LIGHT_1_5",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_LIGHT_2_5",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_LIGHT_3_5",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_LIGHT_4_5",
        max = 25,
        min = -1000
      }
    }
  },
  LightBlock6 = {
    type = "box",
    sprite = "BLOCK_LIGHT_1_6",
    controllable = false,
    material = "light",
    group = "lightBlocks",
    groupIndex = 6,
    strength = 47,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_LIGHT_1_6",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_LIGHT_2_6",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_LIGHT_3_6",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_LIGHT_4_6",
        max = 25,
        min = -1000
      }
    }
  },
  LightBlock7 = {
    type = "circle",
    sprite = "BLOCK_LIGHT_1_7",
    controllable = false,
    material = "light",
    group = "lightBlocks",
    groupIndex = 7,
    strength = 125,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_LIGHT_1_7",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_LIGHT_2_7",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_LIGHT_3_7",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_LIGHT_4_7",
        max = 25,
        min = -1000
      }
    }
  },
  LightBlock8 = {
    type = "circle",
    sprite = "BLOCK_LIGHT_1_8",
    controllable = false,
    material = "light",
    group = "lightBlocks",
    groupIndex = 8,
    strength = 100,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_LIGHT_1_8",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_LIGHT_2_8",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_LIGHT_3_8",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_LIGHT_4_8",
        max = 25,
        min = -1000
      }
    }
  },
  LightBlock9 = {
    type = "box",
    sprite = "BLOCK_LIGHT_4X4_1",
    controllable = false,
    material = "light",
    group = "lightBlocks",
    groupIndex = 9,
    strength = 70,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_LIGHT_4X4_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_LIGHT_4X4_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_LIGHT_4X4_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_LIGHT_4X4_4",
        max = 25,
        min = -1000
      }
    }
  },
  LightBlock10 = {
    type = "box",
    sprite = "BLOCK_LIGHT_10X1_1",
    controllable = false,
    material = "light",
    group = "lightBlocks",
    groupIndex = 10,
    strength = 65,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_LIGHT_10X1_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_LIGHT_10X1_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_LIGHT_10X1_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_LIGHT_10X1_4",
        max = 25,
        min = -1000
      }
    }
  },
  LightBlock11 = {
    type = "polygon",
    vertices = {
      {x = 0, y = 0},
      {x = 1, y = 1},
      {x = 0, y = 1}
    },
    sprite = "BLOCK_LIGHT_TRIANGLE_L_1",
    controllable = false,
    material = "light",
    group = "lightBlocks",
    groupIndex = 11,
    strength = 53,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_LIGHT_TRIANGLE_L_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_LIGHT_TRIANGLE_L_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_LIGHT_TRIANGLE_L_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_LIGHT_TRIANGLE_L_4",
        max = 25,
        min = -1000
      }
    }
  },
  LightBlock12 = {
    type = "polygon",
    vertices = {
      {x = 0.5, y = 0},
      {x = 1, y = 1},
      {x = 0, y = 1}
    },
    sprite = "BLOCK_LIGHT_TRIANGLE_M_1",
    controllable = false,
    material = "light",
    group = "lightBlocks",
    groupIndex = 12,
    strength = 48,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_LIGHT_TRIANGLE_M_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "BLOCK_LIGHT_TRIANGLE_M_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_LIGHT_TRIANGLE_M_3",
        max = 50,
        min = 25
      },
      damage4 = {
        sprite = "BLOCK_LIGHT_TRIANGLE_M_4",
        max = 25,
        min = -1000
      }
    }
  },
  DecorationSpotsTheme01_01 = {
    type = "box",
    sprite = "DECORATION_SPOTS_THEME1_01",
    theme = "theme1",
    material = "decoration",
    group = "decorations",
    groupIndex = 1
  },
  DecorationSpotsTheme01_02 = {
    type = "box",
    sprite = "DECORATION_SPOTS_THEME1_02",
    theme = "theme1",
    material = "decoration",
    group = "decorations",
    groupIndex = 2
  },
  DecorationSpotsTheme01_03 = {
    type = "box",
    sprite = "DECORATION_SPOTS_THEME1_03",
    theme = "theme1",
    material = "decoration",
    group = "decorations",
    groupIndex = 3
  },
  DecorationSpotsTheme02_01 = {
    type = "box",
    sprite = "DECORATION_SPOTS_THEME2_01",
    theme = "theme2",
    material = "decoration",
    group = "decorations",
    groupIndex = 1
  },
  DecorationSpotsTheme02_02 = {
    type = "box",
    sprite = "DECORATION_SPOTS_THEME2_02",
    theme = "theme2",
    material = "decoration",
    group = "decorations",
    groupIndex = 2
  },
  DecorationSpotsTheme02_03 = {
    type = "box",
    sprite = "DECORATION_SPOTS_THEME2_03",
    theme = "theme2",
    material = "decoration",
    group = "decorations",
    groupIndex = 3
  },
  DecorationSpotsTheme03_01 = {
    type = "box",
    sprite = "DECORATION_SPOTS_THEME3_01",
    theme = "theme3",
    material = "decoration",
    group = "decorations",
    groupIndex = 1
  },
  DecorationSpotsTheme03_02 = {
    type = "box",
    sprite = "DECORATION_SPOTS_THEME3_02",
    theme = "theme3",
    material = "decoration",
    group = "decorations",
    groupIndex = 2
  },
  DecorationSpotsTheme03_03 = {
    type = "box",
    sprite = "DECORATION_SPOTS_THEME3_03",
    theme = "theme3",
    material = "decoration",
    group = "decorations",
    groupIndex = 3
  },
  DecorationSkull01 = {
    type = "box",
    sprite = "DECORATION_SKULL01",
    material = "decoration",
    group = "decorations",
    groupIndex = 4
  },
  DecorationSkull02 = {
    type = "box",
    sprite = "DECORATION_SKULL02",
    material = "decoration",
    group = "decorations",
    groupIndex = 5
  },
  DecorationBone01 = {
    type = "box",
    sprite = "DECORATION_BONE01",
    material = "decoration",
    group = "decorations",
    groupIndex = 6
  },
  DecorationBone02 = {
    type = "box",
    sprite = "DECORATION_BONE02",
    material = "decoration",
    group = "decorations",
    groupIndex = 7
  },
  DecorationBone03 = {
    type = "box",
    sprite = "DECORATION_BONE03",
    material = "decoration",
    group = "decorations",
    groupIndex = 8
  },
  DecorationBone04 = {
    type = "box",
    sprite = "DECORATION_BONE04",
    material = "decoration",
    group = "decorations",
    groupIndex = 9
  },
  DecorationBoneSet01 = {
    type = "box",
    sprite = "DECORATION_BONESET01",
    material = "decoration",
    group = "decorations",
    groupIndex = 10
  },
  DecorationBoneSet02 = {
    type = "box",
    sprite = "DECORATION_BONESET02",
    material = "decoration",
    group = "decorations",
    groupIndex = 11
  },
  DecorationEstrade01 = {
    type = "box",
    sprite = "ESTRADE_FLAG",
    material = "decoration",
    group = "decorations",
    groupIndex = 12
  },
  DecorationEstrade02 = {
    type = "box",
    sprite = "ESTRADE_THEATER",
    material = "decoration",
    group = "decorations",
    groupIndex = 13
  },
  StaticBlockTheme01_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_01_THEME_GROUND_1",
    theme = "theme1",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme01_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_01_THEME_GROUND_1",
    theme = "theme1",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme01_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_01_THEME_GROUND_1",
    theme = "theme1",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme01_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_01_THEME_GROUND_1",
    theme = "theme1",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme01_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_01_THEME_1",
    theme = "theme1",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme01_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_01_THEME_GROUND_1",
    theme = "theme1",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme02_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_02_THEME_GROUND_2",
    theme = "theme2",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme02_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_02_THEME_GROUND_2",
    theme = "theme2",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme02_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_02_THEME_GROUND_2",
    theme = "theme2",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme02_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_02_THEME_GROUND_2",
    theme = "theme2",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme02_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_02_THEME_GROUND_2",
    theme = "theme2",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme02_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_02_THEME_GROUND_2",
    theme = "theme2",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme03_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme3",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme03_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme3",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme03_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme3",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme03_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme3",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme03_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme3",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme03_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme3",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme04_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_04_THEME_GROUND_4",
    theme = "theme4",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme04_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_04_THEME_GROUND_4",
    theme = "theme4",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme04_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_04_THEME_GROUND_4",
    theme = "theme4",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme04_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_04_THEME_GROUND_4",
    theme = "theme4",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme04_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_04_THEME_GROUND_4",
    theme = "theme4",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme04_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_04_THEME_GROUND_4",
    theme = "theme4",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme05_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_05_THEME_GROUND_5",
    theme = "theme5",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme05_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_05_THEME_GROUND_5",
    theme = "theme5",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme05_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_05_THEME_GROUND_5",
    theme = "theme5",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme05_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_05_THEME_GROUND_5",
    theme = "theme5",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme05_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_05_THEME_GROUND_5",
    theme = "theme5",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme05_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_05_THEME_GROUND_5",
    theme = "theme5",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme06_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_06_THEME_GROUND_6",
    theme = "theme6",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme06_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_06_THEME_GROUND_6",
    theme = "theme6",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme06_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_06_THEME_GROUND_6",
    theme = "theme6",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme06_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_06_THEME_GROUND_6",
    theme = "theme6",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme06_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_06_THEME_GROUND_6",
    theme = "theme6",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme06_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_06_THEME_GROUND_6",
    theme = "theme6",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme07_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_07_THEME_GROUND_7",
    theme = "theme7",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme07_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_07_THEME_GROUND_7",
    theme = "theme7",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme07_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_07_THEME_GROUND_7",
    theme = "theme7",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme07_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_07_THEME_GROUND_7",
    theme = "theme7",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme07_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_07_THEME_GROUND_7",
    theme = "theme7",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme07_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_07_THEME_GROUND_7",
    theme = "theme7",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme08_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_08_THEME_GROUND_8",
    theme = "theme8",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme08_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_08_THEME_GROUND_8",
    theme = "theme8",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme08_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_08_THEME_GROUND_8",
    theme = "theme8",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme08_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_08_THEME_GROUND_8",
    theme = "theme8",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme08_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_08_THEME_GROUND_8",
    theme = "theme8",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme08_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_08_THEME_GROUND_8",
    theme = "theme8",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme09_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_01_THEME_GROUND_1",
    theme = "theme9",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme09_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_01_THEME_GROUND_1",
    theme = "theme9",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme09_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_01_THEME_GROUND_1",
    theme = "theme9",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme09_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_01_THEME_GROUND_1",
    theme = "theme9",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme09_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_01_THEME_GROUND_1",
    theme = "theme9",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme09_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_01_THEME_GROUND_1",
    theme = "theme9",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme10_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_02_THEME_GROUND_2",
    theme = "theme10",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme10_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_02_THEME_GROUND_2",
    theme = "theme10",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme10_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_02_THEME_GROUND_2",
    theme = "theme10",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme10_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_02_THEME_GROUND_2",
    theme = "theme10",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme10_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_02_THEME_GROUND_2",
    theme = "theme10",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme10_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_02_THEME_GROUND_2",
    theme = "theme10",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme11_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme11",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme11_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme11",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme11_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme11",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme11_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme11",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme11_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme11",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme11_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme11",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme12_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme12",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme12_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme12",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme12_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme12",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme12_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme12",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme12_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme12",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme12_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_03_THEME_GROUND_3",
    theme = "theme12",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme13_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_04_THEME_GROUND_4",
    theme = "theme13",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme13_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_04_THEME_GROUND_4",
    theme = "theme13",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme13_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_04_THEME_GROUND_4",
    theme = "theme13",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme13_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_04_THEME_GROUND_4",
    theme = "theme13",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme13_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_04_THEME_GROUND_4",
    theme = "theme13",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme13_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_04_THEME_GROUND_4",
    theme = "theme13",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme14_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_06_THEME_GROUND_6",
    theme = "theme14",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme14_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_06_THEME_GROUND_6",
    theme = "theme14",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme14_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_06_THEME_GROUND_6",
    theme = "theme14",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme14_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_06_THEME_GROUND_6",
    theme = "theme14",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme14_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_06_THEME_GROUND_6",
    theme = "theme14",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme14_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_06_THEME_GROUND_6",
    theme = "theme14",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme15_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_07_THEME_GROUND_7",
    theme = "theme15",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme15_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_07_THEME_GROUND_7",
    theme = "theme15",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme15_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_07_THEME_GROUND_7",
    theme = "theme15",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme15_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_07_THEME_GROUND_7",
    theme = "theme15",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme15_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_07_THEME_GROUND_7",
    theme = "theme15",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme15_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_07_THEME_GROUND_7",
    theme = "theme15",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme16_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_09_THEME_GROUND_9",
    theme = "theme16",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme16_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_09_THEME_GROUND_9",
    theme = "theme16",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme16_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_09_THEME_GROUND_9",
    theme = "theme16",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme16_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_09_THEME_GROUND_9",
    theme = "theme16",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme16_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_09_THEME_GROUND_9",
    theme = "theme16",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme16_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_09_THEME_GROUND_9",
    theme = "theme16",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme17_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_10_THEME_GROUND_CAVE",
    theme = "theme17",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme17_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_10_THEME_GROUND_CAVE",
    theme = "theme17",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme17_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_10_THEME_GROUND_CAVE",
    theme = "theme17",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme17_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_10_THEME_GROUND_CAVE",
    theme = "theme17",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme17_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_10_THEME_GROUND_CAVE",
    theme = "theme17",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme17_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_10_THEME_GROUND_CAVE",
    theme = "theme17",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  StaticBlockTheme18_01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    texture = "THEME_GROUND_TEXTURE_BIRTHDAY",
    theme = "theme18",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 1
  },
  StaticBlockTheme18_02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    texture = "THEME_GROUND_TEXTURE_BIRTHDAY",
    theme = "theme18",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 2
  },
  StaticBlockTheme18_03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    texture = "THEME_GROUND_TEXTURE_BIRTHDAY",
    theme = "theme18",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 3
  },
  StaticBlockTheme18_04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    texture = "THEME_GROUND_TEXTURE_BIRTHDAY",
    theme = "theme18",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 4
  },
  StaticBlockTheme18_05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    texture = "THEME_GROUND_TEXTURE_BIRTHDAY",
    theme = "theme18",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 5
  },
  StaticBlockTheme18_06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    texture = "THEME_GROUND_TEXTURE_BIRTHDAY",
    theme = "theme18",
    material = "immovable",
    group = "staticBlocks",
    groupIndex = 6
  },
  ShootingPlatform01 = {
    type = "box",
    sprite = "SHOOTING_PLATFORM",
    material = "immovable",
    group = "platforms",
    groupIndex = 1
  },
  Estrade01 = {
    type = "box",
    sprite = "ESTRADE_01",
    material = "immovable",
    group = "platforms",
    groupIndex = 2
  },
  Estrade02 = {
    type = "box",
    sprite = "ESTRADE_02",
    material = "immovable",
    group = "platforms",
    groupIndex = 3
  },
  Estrade03 = {
    type = "box",
    sprite = "ESTRADE_03",
    material = "immovable",
    group = "platforms",
    groupIndex = 4
  },
  Estrade04 = {
    type = "box",
    sprite = "ESTRADE_04",
    material = "immovable",
    group = "platforms",
    groupIndex = 5
  },
  ExtraBlockToilet = {
    type = "box",
    sprite = "BLOCK_EXTRA_TOILET",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 1
  },
  ExtraBlockFlag01 = {
    type = "box",
    sprite = "BLOCK_EXTRA_FLAG_01",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 2
  },
  ExtraBlockFlag02 = {
    type = "box",
    sprite = "BLOCK_EXTRA_FLAG_02",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 3
  },
  ExtraBlockTNT = {
    type = "box",
    sprite = "BLOCK_EXTRA_TNT",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 4,
    strength = 10,
    defence = 1,
    particles = "explosionBuff",
    specialty = "BOMB",
    explosionRadius = 10,
    explosionForce = 30000,
    explosionDamageRadius = 5,
    explosionDamage = 150
  },
  ExtraBlockDice = {
    type = "box",
    sprite = "BLOCK_EXTRA_DICE_6",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 5,
    strength = 30,
    defence = 1,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_EXTRA_DICE_6",
        max = 100,
        min = 84
      },
      damage2 = {
        sprite = "BLOCK_EXTRA_DICE_5",
        max = 84,
        min = 68
      },
      damage3 = {
        sprite = "BLOCK_EXTRA_DICE_4",
        max = 68,
        min = 52
      },
      damage4 = {
        sprite = "BLOCK_EXTRA_DICE_3",
        max = 52,
        min = 36
      },
      damage5 = {
        sprite = "BLOCK_EXTRA_DICE_2",
        max = 36,
        min = 20
      },
      damage6 = {
        sprite = "BLOCK_EXTRA_DICE_1",
        max = 20,
        min = -1000
      }
    }
  },
  ExtraBlockStairs = {
    type = "box",
    sprite = "ESTRADE_STAIRS",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 6
  },
  SpecialBlockSwing = {
    type = "box",
    sprite = "SWING_HOLDER_01",
    controllable = false,
    material = "immovable",
    group = "extras",
    groupIndex = 7
  },
  SpecialBlockStart = {
    type = "box",
    sprite = "SWING_BASKET_01",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 8,
    strength = 10,
    defence = 1000000,
    collision = false
  },
  ExtraPoleYellow = {
    type = "box",
    sprite = "POLE_YELLOW",
    controllable = false,
    material = "immovable",
    group = "extras",
    groupIndex = 9,
    strength = 10,
    defence = 1000000,
    collision = false
  },
  ExtraPoleRed = {
    type = "box",
    sprite = "POLE_RED",
    controllable = false,
    material = "immovable",
    group = "extras",
    groupIndex = 10,
    strength = 10,
    defence = 1000000,
    collision = false
  },
  ExtraTire01 = {
    type = "circle",
    sprite = "BLOCK_TIRE_01",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 11,
    strength = 200
  },
  ExtraTire02 = {
    type = "circle",
    sprite = "BLOCK_TIRE_02",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 12,
    strength = 200
  },
  ExtraTire03 = {
    type = "circle",
    sprite = "BLOCK_TIRE_03",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 13,
    strength = 200
  },
  ExtraDonut01 = {
    type = "circle",
    sprite = "BLOCK_DONUT",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 14,
    strength = 50
  },
  ExtraMelon = {
    type = "circle",
    sprite = "BLOCK_WATERMELON",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 15,
    strength = 40
  },
  ExtraHam = {
    type = "circle",
    sprite = "BLOCK_HAM",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 16,
    strength = 60
  },
  ExtraApple = {
    type = "circle",
    sprite = "BLOCK_APPLE",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 17,
    strength = 30
  },
  ExtraStrawberry = {
    type = "circle",
    sprite = "BLOCK_STRAWBERRY",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 18,
    strength = 30
  },
  ExtraBanana = {
    type = "box",
    sprite = "BLOCK_BANANA",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 19,
    strength = 30
  },
  ExtraTreasureChest = {
    type = "box",
    sprite = "BLOCK_TREASURE_CHEST",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 20,
    strength = 20
  },
  ExtraPillar = {
    type = "box",
    sprite = "BLOCK_PILLAR",
    controllable = false,
    density = 10,
    defence = 40,
    material = "extras",
    group = "extras",
    groupIndex = 21,
    strength = 120
  },
  ExtraBeachBall = {
    type = "circle",
    sprite = "BLOCK_BEACHBALL",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 22,
    strength = 15
  },
  ExtraBlockSmiley = {
    type = "circle",
    sprite = "BLOCK_SMILEY_1",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 23,
    strength = 25,
    damageSprites = {
      damage1 = {
        sprite = "BLOCK_SMILEY_1",
        max = 100,
        min = 50
      },
      damage3 = {
        sprite = "BLOCK_SMILEY_3",
        max = 50,
        min = -1000
      }
    }
  },
  ExtraHolyGrail = {
    type = "box",
    sprite = "BLOCK_HOLYGRAIL",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 24,
    strength = 25
  },
  ExtraDiamond = {
    type = "circle",
    sprite = "BLOCK_DIAMOND",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 25,
    strength = 25
  },
  ExtraRubberDuck = {
    type = "circle",
    sprite = "BLOCK_RUBBERDUCK",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 26,
    strength = 25
  },
  ExtraStolenEgg = {
    type = "circle",
    sprite = "BLOCK_STOLEN_EGG",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 27,
    strength = 2000,
    defence = 20000
  },
  ExtraStrongBall = {
    type = "circle",
    sprite = "BLOCK_STEEL_BALL",
    controllable = false,
    material = "rock",
    group = "extras",
    groupIndex = 28,
    strength = 5000,
    defence = 2000
  },
  ExtraRubberBall = {
    type = "circle",
    sprite = "BLOCK_BEACHBALL",
    controllable = false,
    material = "rubber",
    group = "extras",
    groupIndex = 29,
    defence = 50,
    strength = 1000,
    restitution = 1.1
  },
  ExtraTrampoline = {
    type = "circle",
    sprite = "BLOCK_SUPER_BALL",
    material = "rubber",
    group = "extras",
    groupIndex = 30,
    defence = 1000,
    strength = 1000,
    restitution = 5.5
  },
  ExtraBlueBird = {
    radius = 0.6,
    friction = 0.3,
    type = "circle",
    restitution = 0.25,
    sprite = "BIRD_BLUE",
    density = 8,
    material = "extras",
    group = "extras",
    groupIndex = 31,
    strength = 3000,
    defence = 2000
  },
  ExtraTrampoline2 = {
    type = "box",
    sprite = "BLOCK_TRAMPOLINE_01",
    material = "immovableRubber",
    group = "extras",
    groupIndex = 32,
    defence = 1000,
    strength = 1000,
    restitution = 1.1
  },
  ExtraGoldenEgg = {
    type = "circle",
    sprite = "BLOCK_GOLDEN_EGG",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 33,
    strength = 5,
    defence = 1
  },
  ExtraRopeThick01 = {
    type = "box",
    sprite = "BLOCK_ROPE_THICK_1",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 34,
    strength = 5,
    defence = 1,
    destroyedScoreInc = 100
  },
  ExtraRopeThin01 = {
    type = "box",
    sprite = "BLOCK_ROPE_THIN_1",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 35,
    strength = 5,
    defence = 1,
    destroyedScoreInc = 100
  },
  ExtraRopeThin02 = {
    type = "box",
    sprite = "BLOCK_ROPE_THIN_2",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 36,
    strength = 5,
    defence = 1,
    destroyedScoreInc = 100
  },
  ExtraBoomerangBird = {
    radius = 1.1,
    friction = 0.3,
    type = "circle",
    restitution = 0.25,
    sprite = "BIRD_BOOMERANG",
    density = 8,
    material = "immovable",
    group = "extras",
    groupIndex = 37,
    strength = 1000000,
    defence = 1000000
  },
  BlockCarpet = {
    type = "box",
    sprite = "BLOCK_CARPET",
    material = "extras",
    group = "extras",
    groupIndex = 38
  },
  ExtraHelmetSmall = {
    type = "polygon",
    vertices = {
      {x = 0.2, y = 0.3},
      {x = 0.4, y = 0.2},
      {x = 0.6, y = 0.2},
      {x = 0.8, y = 0.3},
      {x = 0.8, y = 0.5},
      {x = 0.2, y = 0.5}
    },
    sprite = "HELMET_SMALL",
    material = "extras",
    group = "extras",
    density = 0.3,
    friction = 1,
    groupIndex = 39,
    defence = 300,
    strength = 10,
    restitution = 0.1,
    z_order = 5,
    destroyedScoreInc = 50
  },
  ExtraHelmetSmall2 = {
    type = "polygon",
    vertices = {
      {x = 0.2, y = 0.2},
      {x = 0.4, y = 0.1},
      {x = 0.8, y = 0.1},
      {x = 1, y = 0.2},
      {x = 1, y = 0.4},
      {x = 0.2, y = 0.4}
    },
    sprite = "BLOCK_RUBBERDUCK",
    material = "extras",
    group = "extras",
    density = 0.5,
    friction = 1,
    groupIndex = 40,
    defence = 300,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 50
  },
  ExtraHelmetBig = {
    type = "polygon",
    vertices = {
      {x = 0.2, y = 0.3},
      {x = 0.4, y = 0.2},
      {x = 0.6, y = 0.2},
      {x = 0.8, y = 0.3},
      {x = 0.8, y = 0.5},
      {x = 0.2, y = 0.5}
    },
    sprite = "HELMET_BIG",
    material = "extras",
    group = "extras",
    density = 0.5,
    friction = 1,
    groupIndex = 41,
    defence = 300,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 50
  },
  ExtraHelmetBig2 = {
    type = "polygon",
    vertices = {
      {x = 0.2, y = 0.2},
      {x = 0.4, y = 0.1},
      {x = 0.8, y = 0.1},
      {x = 1, y = 0.2},
      {x = 1, y = 0.4},
      {x = 0.2, y = 0.4}
    },
    sprite = "BIRD_BOOMERANG_STILL",
    material = "extras",
    group = "extras",
    density = 0.5,
    friction = 1,
    groupIndex = 42,
    defence = 300,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 50
  },
  ExtraHelmetBoss = {
    type = "polygon",
    vertices = {
      {x = 0.2, y = 0.3},
      {x = 0.4, y = 0.2},
      {x = 0.6, y = 0.2},
      {x = 0.8, y = 0.3},
      {x = 0.8, y = 0.5},
      {x = 0.2, y = 0.5}
    },
    sprite = "HELMET_BOSS",
    material = "extras",
    group = "extras",
    density = 0.5,
    friction = 1,
    groupIndex = 43,
    defence = 300,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 50
  },
  ExtraCowboyHelmet_1 = {
    type = "polygon",
    vertices = {
      {x = 0.3, y = 0.3},
      {x = 0.4, y = 0.2},
      {x = 0.6, y = 0.2},
      {x = 0.65, y = 0.3},
      {x = 0.65, y = 0.5},
      {x = 0.3, y = 0.5}
    },
    sprite = "COWBOY_HAT_BIG_1",
    material = "extras",
    group = "extras",
    density = 0.5,
    friction = 1,
    groupIndex = 44,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraCowboyHelmetSmall_1 = {
    type = "polygon",
    vertices = {
      {x = 0.3, y = 0.3},
      {x = 0.4, y = 0.2},
      {x = 0.6, y = 0.2},
      {x = 0.65, y = 0.3},
      {x = 0.65, y = 0.5},
      {x = 0.3, y = 0.5}
    },
    sprite = "COWBOY_HAT_SMALL_1",
    material = "extras",
    group = "extras",
    density = 0.3,
    friction = 1,
    groupIndex = 45,
    defence = 10,
    strength = 10,
    restitution = 0.1,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraSheriffHat_1 = {
    type = "polygon",
    vertices = {
      {x = 0.35, y = 0.3},
      {x = 0.4, y = 0.2},
      {x = 0.6, y = 0.2},
      {x = 0.7, y = 0.3},
      {x = 0.7, y = 0.6},
      {x = 0.35, y = 0.6}
    },
    sprite = "SHERIFF_HAT_1",
    material = "extras",
    group = "extras",
    density = 0.5,
    friction = 1,
    groupIndex = 46,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraSheriffHat_2 = {
    type = "polygon",
    vertices = {
      {x = 0.35, y = 0.3},
      {x = 0.4, y = 0.2},
      {x = 0.6, y = 0.2},
      {x = 0.7, y = 0.3},
      {x = 0.7, y = 0.6},
      {x = 0.35, y = 0.6}
    },
    sprite = "SHERIFF_HAT_2",
    material = "extras",
    group = "extras",
    density = 0.5,
    friction = 1,
    groupIndex = 47,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraBanditoHat_1 = {
    type = "polygon",
    vertices = {
      {x = 0.4, y = 0.3},
      {x = 0.45, y = 0.2},
      {x = 0.55, y = 0.2},
      {x = 0.6, y = 0.3},
      {x = 0.6, y = 0.7},
      {x = 0.4, y = 0.7}
    },
    sprite = "BANDITO_HAT_1",
    material = "extras",
    group = "extras",
    density = 0.5,
    friction = 1,
    groupIndex = 48,
    defence = 30,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraSuperBowl = {
    type = "circle",
    sprite = "B_EGG_SUPER_BOWL",
    controllable = false,
    material = "extras",
    group = "extras",
    groupIndex = 49,
    strength = 5,
    defence = 1,
    density = 0
  },
  StaticFragileBlock01 = {
    type = "box",
    sprite = "GROUND_BLOCK_01",
    material = "immovableFragile",
    group = "staticFragile",
    groupIndex = 1,
    destroyedScoreInc = 50
  },
  StaticFragileBlock02 = {
    type = "box",
    sprite = "GROUND_BLOCK_02",
    material = "immovableFragile",
    group = "staticFragile",
    groupIndex = 2,
    destroyedScoreInc = 50
  },
  StaticFragileBlock03 = {
    type = "box",
    sprite = "GROUND_BLOCK_03",
    material = "immovableFragile",
    group = "staticFragile",
    groupIndex = 3,
    destroyedScoreInc = 50
  },
  StaticFragileBlock04 = {
    type = "box",
    sprite = "GROUND_BLOCK_04",
    material = "immovableFragile",
    group = "staticFragile",
    groupIndex = 4,
    destroyedScoreInc = 50
  },
  StaticFragileBlock05 = {
    type = "box",
    sprite = "GROUND_BLOCK_05",
    material = "immovableFragile",
    group = "staticFragile",
    groupIndex = 5,
    destroyedScoreInc = 50
  },
  StaticFragileBlock06 = {
    type = "box",
    sprite = "GROUND_BLOCK_06",
    material = "immovableFragile",
    group = "staticFragile",
    groupIndex = 6,
    destroyedScoreInc = 50
  },
  StaticBalloon01 = {
    type = "box",
    sprite = "BLOCK_PIG_BALLOON_1",
    material = "clouds",
    group = "clouds",
    groupIndex = 1,
    destroyedScoreInc = 100
  },
  StaticBalloon02 = {
    type = "box",
    sprite = "BLOCK_PIG_BALLOON_2",
    material = "clouds",
    group = "clouds",
    groupIndex = 2,
    destroyedScoreInc = 100
  },
  StaticBalloon03 = {
    type = "box",
    sprite = "BLOCK_BALLOON_1",
    material = "clouds",
    group = "clouds",
    groupIndex = 3,
    destroyedScoreInc = 100
  },
  StaticBalloon04 = {
    type = "box",
    sprite = "BLOCK_BALLOON_2",
    material = "clouds",
    group = "clouds",
    groupIndex = 4,
    destroyedScoreInc = 100
  },
  StaticBalloon05 = {
    type = "box",
    sprite = "BLOCK_BALLOON_3",
    material = "clouds",
    group = "clouds",
    groupIndex = 5,
    destroyedScoreInc = 100
  },
  StaticCloud01 = {
    type = "box",
    sprite = "BLOCK_BANANA",
    material = "immovable",
    group = "clouds",
    groupIndex = 6
  },
  StaticCloud02 = {
    type = "box",
    sprite = "BLOCK_BANANA",
    material = "immovable",
    group = "clouds",
    groupIndex = 7
  },
  StaticCloud03 = {
    type = "box",
    sprite = "BLOCK_BANANA",
    material = "immovable",
    group = "clouds",
    groupIndex = 8
  },
  StaticCloud04 = {
    type = "box",
    sprite = "BLOCK_BANANA",
    material = "immovable",
    group = "clouds",
    groupIndex = 9
  },
  Ground = {
    type = "box",
    sprite = "",
    texture = "",
    theme = "",
    material = "staticGround",
    group = "",
    groupIndex = 1
  },
  ExtraCaveHat_1 = {
    type = "box",
    width = 1,
    height = 0.5,
    sprite = "CAVE_HAT_1",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 50,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraCaveHat_2 = {
    type = "box",
    width = 2,
    height = 1.6,
    sprite = "CAVE_HAT_2",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 51,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraCaveHat_3 = {
    type = "box",
    width = 2,
    height = 1.5,
    sprite = "CAVE_HAT_3",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 52,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraKingCaveHat_1 = {
    type = "box",
    width = 2.2,
    height = 1.7,
    sprite = "KING_CAVE_HAT_1",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 53,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraCaveShovel_1 = {
    type = "box",
    width = 1.2,
    height = 4.7,
    sprite = "CAVE_SHOVEL_1",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 54,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraCaveShovel_2 = {
    type = "box",
    width = 0.8,
    height = 2.5,
    sprite = "CAVE_SHOVEL_2",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 55,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraCavePickaxe_1 = {
    type = "polygon",
    vertices = {
      {x = 0, y = 0},
      {x = 1, y = 0},
      {x = 0.5, y = 1}
    },
    sprite = "CAVE_PICKAXE_1",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 56,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraCavePickaxe_2 = {
    type = "polygon",
    vertices = {
      {x = 0, y = 0},
      {x = 1, y = 0},
      {x = 0.5, y = 1}
    },
    sprite = "CAVE_PICKAXE_2",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 57,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraAmethyst = {
    type = "box",
    width = 2,
    height = 1.6,
    sprite = "BLOCK_AMETHYST",
    material = "amethyst",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 58,
    defence = 2,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 3000,
    spriteScore = "GEM_SCORE_AMETHYST_1"
  },
  ExtraRuby = {
    type = "box",
    width = 1.3,
    height = 2,
    sprite = "BLOCK_RUBY",
    material = "ruby",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 59,
    defence = 2,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 3000,
    spriteScore = "GEM_SCORE_RUBY_1"
  },
  ExtraAmber = {
    type = "circle",
    radius = 1,
    sprite = "BLOCK_AMBER",
    material = "amber",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 60,
    defence = 2,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 3000,
    spriteScore = "GEM_SCORE_AMBER_1"
  },
  ExtraStalaktite_1 = {
    type = "box",
    width = 3,
    height = 13.9,
    sprite = "BLOCK_STALAKTITE_1",
    material = "stalaktite",
    group = "extras",
    density = 0,
    friction = 1,
    groupIndex = 61,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraStalaktite_2 = {
    type = "box",
    width = 1,
    height = 12.5,
    sprite = "BLOCK_STALAKTITE_2",
    particles = "stalaktiteWhiteBreak",
    material = "stalaktite",
    group = "extras",
    density = 0,
    friction = 1,
    groupIndex = 62,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraStalaktite_3 = {
    type = "box",
    width = 1.8,
    height = 17.1,
    sprite = "BLOCK_STALAKTITE_3",
    particles = "stalaktiteWhiteBreak",
    material = "stalaktite",
    group = "extras",
    density = 0,
    friction = 1,
    groupIndex = 63,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraStalaktite_Tip1 = {
    type = "box",
    width = 0.6,
    height = 5,
    sprite = "BLOCK_STALAKTITE_TIP_1",
    material = "stalaktite_tip",
    group = "extras",
    density = 60,
    friction = 1,
    groupIndex = 64,
    defence = 50,
    strength = 400,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraStalaktite_Tip2 = {
    type = "box",
    width = 0.6,
    height = 4,
    sprite = "BLOCK_STALAKTITE_TIP_2",
    material = "stalaktite_tip",
    group = "extras",
    density = 60,
    friction = 1,
    groupIndex = 65,
    defence = 50,
    strength = 400,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraStalaktite_Tip3 = {
    type = "box",
    width = 0.6,
    height = 4,
    sprite = "BLOCK_STALAKTITE_TIP_3",
    material = "stalaktite_tip",
    particles = "stalaktiteWhiteBreak",
    group = "extras",
    density = 60,
    friction = 1,
    groupIndex = 66,
    defence = 50,
    strength = 400,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  ExtraStalaktite_Tip4 = {
    type = "box",
    width = 0.6,
    height = 6,
    sprite = "BLOCK_STALAKTITE_TIP_4",
    material = "stalaktite_tip",
    particles = "stalaktiteWhiteBreak",
    group = "extras",
    density = 60,
    friction = 1,
    groupIndex = 67,
    defence = 50,
    strength = 400,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  BirthdayBalloon_1 = {
    type = "circle",
    radius = 1.2,
    sprite = "BLOCK_BALLOON_BDAY",
    particles = "blueBuff",
    controllable = false,
    material = "balloon",
    defence = 1,
    collision = true,
    strength = 10,
    destroyedScoreInc = 500,
    z_order = 5,
    group = "extras",
    groupIndex = 68
  },
  PartyHat_1 = {
    type = "box",
    width = 1.5,
    height = 1.7,
    sprite = "PARTY_HAT_1",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 69,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  PartyHat_2 = {
    type = "box",
    width = 1.6,
    height = 1.7,
    sprite = "PARTY_HAT_2",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 70,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  PartyHat_3 = {
    type = "box",
    width = 2.2,
    height = 1.7,
    sprite = "PARTY_HAT_3",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 71,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  PartyHat_4 = {
    type = "box",
    width = 2.2,
    height = 1.7,
    sprite = "PARTY_HAT_4",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 72,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  BirthdayCandle_1 = {
    type = "box",
    width = 0.6,
    height = 2.3,
    sprite = "BDAY_CANDLE_1",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 73,
    defence = 10,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 500
  },
  BirthdayCake_1 = {
    type = "box",
    width = 2.5,
    height = 2.9,
    sprite = "CHOCO_CAKE_1",
    material = "cake",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 74,
    defence = 5,
    strength = 10,
    restitution = 0,
    z_order = 5,
    particles = {"cake1Break", "smokeBuff"},
    spriteScore = "CAKE_SCORE_1",
    destroyedScoreInc = 3000
  },
  BirthdayCake_2 = {
    type = "box",
    width = 3,
    height = 3.8,
    sprite = "PINK_CAKE_1",
    material = "cake",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 75,
    defence = 5,
    strength = 10,
    restitution = 0,
    z_order = 5,
    particles = {"cake2Break", "smokeBuff"},
    spriteScore = "CAKE_SCORE_1",
    destroyedScoreInc = 3000
  },
  BirthdayCake_3 = {
    type = "box",
    width = 4,
    height = 2.2,
    sprite = "MINT_CAKE_1",
    material = "cake",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 76,
    defence = 5,
    strength = 10,
    restitution = 0,
    z_order = 5,
    particles = {"cake3Break", "smokeBuff"},
    spriteScore = "CAKE_SCORE_1",
    destroyedScoreInc = 100
  },
  BirthdayBalloon_2 = {
    sprite = "BLOCK_BALLOON_1",
    type = "circle",
    radius = 1.2,
    particles = "blueBuff",
    controllable = false,
    material = "balloon",
    defence = 1,
    collision = true,
    destroyedScoreInc = 100,
    strength = 10,
    z_order = 5,
    group = "extras",
    groupIndex = 77
  },
  BirthdayBalloon_3 = {
    sprite = "BLOCK_BALLOON_2",
    type = "circle",
    radius = 1.2,
    particles = "blueBuff",
    controllable = false,
    material = "balloon",
    defence = 1,
    collision = true,
    destroyedScoreInc = 100,
    strength = 10,
    z_order = 5,
    group = "extras",
    groupIndex = 78
  },
  BirthdayBalloon_4 = {
    sprite = "BLOCK_BALLOON_3",
    type = "circle",
    radius = 1.2,
    particles = "blueBuff",
    controllable = false,
    material = "balloon",
    defence = 1,
    collision = true,
    destroyedScoreInc = 100,
    strength = 10,
    z_order = 5,
    group = "extras",
    groupIndex = 79
  },
  SPECIAL_CAKE_1 = {
    type = "box",
    width = 2,
    height = 2,
    sprite = "SPECIAL_CAKE_1",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 80,
    defence = 5,
    strength = 10,
    restitution = 0,
    z_order = 5,
    particles = {"cake3Break", "smokeBuff"},
    destroyedScoreInc = 100
  },
  MISC_FB_NET = {
    type = "box",
    sprite = "MISC_FB_NET_1",
    material = "light",
    group = "extras",
    groupIndex = 71,
    controllable = false,
    density = 0.1,
    friction = 1,
    defence = 10,
    strength = 5,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_NET_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_NET_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_NET_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_STICK = {
    type = "box",
    sprite = "MISC_FB_STICK_1",
    material = "wood",
    group = "extras",
    groupIndex = 72,
    controllable = false,
    density = 0.1,
    friction = 1,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_STICK_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_STICK_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_STICK_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_ROD = {
    type = "box",
    sprite = "MISC_FB_ROD_1",
    material = "wood",
    group = "extras",
    groupIndex = 73,
    controllable = false,
    density = 0.001,
    friction = 1,
    defence = 10,
    strength = 10,
    restitution = 0,
    z_order = 0,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_ROD_1",
        max = 100,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_ROD_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_HAT = {
    type = "polygon",
    vertices = {
      {x = 0.2, y = 0.3},
      {x = 0.4, y = 0.2},
      {x = 0.6, y = 0.2},
      {x = 0.8, y = 0.3},
      {x = 0.8, y = 0.7},
      {x = 0.2, y = 0.7}
    },
    sprite = "MISC_FB_HAT_1",
    material = "extras",
    group = "extras",
    groupIndex = 74,
    density = 0.5,
    friction = 1,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_HAT_1",
        max = 100,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_HAT_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_GLASSES = {
    type = "polygon",
    vertices = {
      {x = 0.1, y = 0.3},
      {x = 0.4, y = 0.2},
      {x = 0.6, y = 0.2},
      {x = 0.85, y = 0.3},
      {x = 0.85, y = 0.7},
      {x = 0.1, y = 0.7}
    },
    sprite = "MISC_FB_GLASSES_1",
    material = "extras",
    group = "extras",
    groupIndex = 75,
    controllable = false,
    density = 0.1,
    friction = 1,
    defence = 4,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_GLASSES_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_GLASSES_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_GLASSES_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_BUCKET = {
    type = "polygon",
    vertices = {
      {x = 0.1, y = 0.3},
      {x = 0.9, y = 0.3},
      {x = 0.8, y = 0.95},
      {x = 0.2, y = 0.95}
    },
    sprite = "MISC_FB_BUCKET_1",
    material = "light",
    group = "extras",
    groupIndex = 76,
    controllable = false,
    strength = 4,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_BUCKET_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_BUCKET_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_BUCKET_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_SHOVEL = {
    type = "box",
    sprite = "MISC_FB_SHOVEL_1",
    material = "light",
    group = "extras",
    groupIndex = 77,
    controllable = false,
    density = 0.1,
    friction = 1,
    defence = 4,
    strength = 5,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_SHOVEL_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_SHOVEL_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_SHOVEL_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_CASTLE = {
    type = "box",
    sprite = "MISC_FB_CASTLE_1",
    material = "wood",
    group = "extras",
    groupIndex = 78,
    controllable = false,
    density = 0.5,
    friction = 1,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_CASTLE_1",
        max = 100,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_CASTLE_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_TAPE = {
    type = "box",
    sprite = "MISC_FB_TAPE_1",
    material = "extras",
    group = "extras",
    groupIndex = 79,
    controllable = false,
    strength = 5,
    defence = 1,
    destroyedScoreInc = 100
  },
  MISC_FB_HAMMER = {
    type = "box",
    sprite = "MISC_FB_HAMMER_1",
    material = "rock",
    group = "extras",
    groupIndex = 80,
    controllable = false,
    density = 0.2,
    friction = 1,
    defence = 30,
    strength = 20,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_HAMMER_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_HAMMER_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_HAMMER_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_CONE = {
    type = "box",
    sprite = "MISC_FB_CONE_1",
    material = "wood",
    group = "extras",
    groupIndex = 81,
    controllable = false,
    density = 0.1,
    friction = 1,
    defence = 10,
    strength = 5,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_CONE_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_CONE_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_CONE_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_UMBRELLA_TOP = {
    type = "box",
    sprite = "MISC_FB_UMBRELLA_TOP_1",
    material = "wood",
    group = "extras",
    groupIndex = 82,
    controllable = false,
    density = 0.1,
    friction = 1,
    defence = 10,
    strength = 5,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_UMBRELLA_TOP_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_UMBRELLA_TOP_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_UMBRELLA_TOP_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_UMBRELLA_BOTTOM = {
    type = "box",
    sprite = "MISC_FB_UMBRELLA_BOTTOM_1",
    material = "wood",
    group = "extras",
    groupIndex = 83,
    controllable = false,
    density = 0.01,
    friction = 1,
    defence = 10,
    strength = 5,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_UMBRELLA_BOTTOM_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_UMBRELLA_BOTTOM_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_UMBRELLA_BOTTOM_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_BARREL = {
    type = "box",
    sprite = "MISC_FB_BARREL_1",
    material = "wood",
    group = "extras",
    groupIndex = 84,
    controllable = false,
    strength = 80,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_BARREL_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_BARREL_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_BARREL_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_BOBBER = {
    type = "box",
    sprite = "MISC_FB_BOBBER_1",
    material = "light",
    group = "extras",
    groupIndex = 85,
    controllable = false,
    strength = 5,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_BOBBER_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_BOBBER_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_BOBBER_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_SMALL_HAT = {
    type = "polygon",
    vertices = {
      {x = 0.3, y = 0.3},
      {x = 0.4, y = 0.2},
      {x = 0.6, y = 0.2},
      {x = 0.65, y = 0.3},
      {x = 0.65, y = 0.5},
      {x = 0.3, y = 0.5}
    },
    sprite = "MISC_FB_SMALL_HAT_1",
    material = "extras",
    group = "extras",
    groupIndex = 86,
    controllable = false,
    density = 0.3,
    friction = 1,
    defence = 10,
    strength = 10,
    restitution = 0.1,
    z_order = 5,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_SMALL_HAT_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_SMALL_HAT_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_SMALL_HAT_3",
        max = 50,
        min = 0
      }
    }
  },
  MISC_FB_TINYGLASSES = {
    type = "polygon",
    vertices = {
      {x = 0.2, y = 0.3},
      {x = 0.4, y = 0.2},
      {x = 0.6, y = 0.2},
      {x = 0.85, y = 0.3},
      {x = 0.85, y = 0.7},
      {x = 0.2, y = 0.7}
    },
    sprite = "MISC_FB_TINYGLASSES_1",
    material = "extras",
    group = "extras",
    groupIndex = 87,
    controllable = false,
    density = 0.1,
    friction = 1,
    defence = 4,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100,
    damageSprites = {
      damage1 = {
        sprite = "MISC_FB_TINYGLASSES_1",
        max = 100,
        min = 75
      },
      damage2 = {
        sprite = "MISC_FB_TINYGLASSES_2",
        max = 75,
        min = 50
      },
      damage3 = {
        sprite = "MISC_FB_TINYGLASSES_3",
        max = 50,
        min = 0
      }
    }
  },
  HORSE_BASE = {
    type = "box",
    sprite = "BLOCK_HORSE_BASE",
    material = "extras",--TODO materialName
    group = "extras",
    groupIndex = 88,
    controllable = false,
    strength = 80
  },
  BLOCK_GREEN_GOGGLES = {
    type = "box",
    width = 2,
    height = 1,
    sprite = "BLOCK_GREEN_GOGGLES",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 89,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  BLOCK_GREEN_PILOTHELMET = {
    type = "box",
    width = 2,
    height = 1,
    sprite = "BLOCK_GREEN_PILOTHELMET",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 90,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  BLOCK_GREEN_SPANNER_2 = {
    type = "box",
    width = 1,
    height = 4,
    sprite = "BLOCK_GREEN_SPANNER_2",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 91,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  GoldenSpanner = {
    type = "box",
    width = 1,
    height = 4,
    sprite = "BLOCK_GREEN_SPANNER_GOLDEN",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 92,
    defence = 2,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 3000,
    spriteScore = "GEM_SCORE_AMBER_1"
  },
  BLOCK_GREEN_OILCANISTER = {
    type = "box",
    width = 1.5,
    height = 2.7,
    sprite = "BLOCK_GREEN_OILCANISTER",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 93,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  },
  BLOCK_GREEN_BAG = {
    type = "circle",
    radius = 1.3,
    sprite = "BLOCK_GREEN_BAG",
    material = "extras",
    group = "extras",
    density = 0.1,
    friction = 1,
    groupIndex = 94,
    defence = 20,
    strength = 10,
    restitution = 0,
    z_order = 5,
    destroyedScoreInc = 100
  }
}
filename = "blocks.lua"
