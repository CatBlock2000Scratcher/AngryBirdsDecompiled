gamelua.g_episodes = {
  [1] = {
    icon = "LS_PACK_THUMB_01",
    name = "TEXT_LP_NAME_1",
    decor_left = "LS_THEME_1_LEFT",
    decor_right = "LS_THEME_1_RIGHT",
    three_stars_goldenegg = "SOUNDBOARD1",
    score_achievement_limit = 4000000,
    per_page_level_numbering = true,
    pages = {
      {
        folder_name = "free",
        display_number = "1",
        world_number = 1,
        colour = {
          r = 41,
          g = 118,
          b = 142
        },
        level_button = "LS_LEVEL_BG_NORMAL_OPEN_1",
        layout = "grid",
        layout_params = {rows = 1, cols = 3},
        clear_achievement = "Herr Helmet",
        levels = {
          {name = "LevelLite1"},
          {name = "LevelLite2"},
          {name = "LevelLite3"}
        }
      },
      {
        folder_name = "free",
        display_number = "2",
        world_number = 2,
        colour = {
          r = 105,
          g = 184,
          b = 225
        },
        level_button = "LS_LEVEL_BG_NORMAL_OPEN_2",
        layout = "grid",
        layout_params = {rows = 1, cols = 3},
        clear_achievement = "The Imposter",
        levels = {
          {name = "LevelLite4"},
          {name = "LevelLite5"},
          {name = "LevelLite6"}
        }
      },
      {
        folder_name = "free",
        display_number = "3",
        world_number = 3,
        colour = {
          r = 82,
          g = 103,
          b = 43
        },
        level_button = "LS_LEVEL_BG_NORMAL_OPEN_3",
        layout = "grid",
        layout_params = {rows = 1, cols = 3},
        clear_achievement = "Hovering Helmet",
        levels = {
          {name = "LevelLite7"},
          {name = "LevelLite8"},
          {name = "LevelLite9"}
        }
      },
      {
        folder_name = "free",
        display_number = "4",
        world_number = 4,
        colour = {
          r = 41,
          g = 118,
          b = 142
        },
        level_button = "LS_LEVEL_BG_NORMAL_OPEN_4",
        layout = "grid",
        layout_params = {rows = 1, cols = 3},
        clear_achievement = "Hardhat Hidalgo",
        levels = {
          {
            name = "LevelLite10"
          },
          {
            name = "LevelLite11"
          },
          {
            name = "LevelLite12"
          }
        }
      },
      {
        folder_name = "free",
        display_number = "5",
        world_number = 5,
        colour = {
          r = 126,
          g = 113,
          b = 89
        },
        level_button = "LS_LEVEL_BG_NORMAL_OPEN_5",
        layout = "grid",
        layout_params = {rows = 1, cols = 3},
        clear_achievement = "Billy The Pig",
        levels = {
          {
            name = "LevelLite13"
          },
          {
            name = "LevelLite14"
          },
          {
            name = "LevelLite15"
          }
        }
      },
      {
        folder_name = "free",
        display_number = "6",
        world_number = 6,
        colour = {
          r = 41,
          g = 118,
          b = 142
        },
        level_button = "LS_LEVEL_BG_NORMAL_OPEN_6",
        layout = "grid",
        layout_params = {rows = 1, cols = 3},
        clear_achievement = "Cave Explorer",
        levels = {
          {
            name = "LevelLite16"
          },
          {
            name = "LevelLite17"
          },
          {
            name = "LevelLite18"
          }
        }
      },
      {
        folder_name = "free",
        display_number = "7",
        world_number = 7,
        display_dot_numbers = true,
        colour = {
          r = 255,
          g = 174,
          b = 201
        },
        level_button = "LS_LEVEL_BG_NORMAL_OPEN_7",
        layout = "grid",
        layout_params = {rows = 1, cols = 3},
        levels = {
          {
            name = "LevelLite19"
          },
          {
            name = "LevelLite20"
          },
          {
            name = "LevelLite21"
          }
        }
      },
      {
        folder_name = "free",
        display_number = "8",
        world_number = 8,
        display_dot_numbers = true,
        colour = {
          r = 255,
          g = 174,
          b = 201
        },
        level_button = "LS_LEVEL_BG_NORMAL_OPEN_1",
        layout = "grid",
        layout_params = {rows = 1, cols = 3},
        levels = {
          {
            name = "LevelLite22"
          },
          {
            name = "LevelLite23"
          },
          {
            name = "LevelLite24"
          }
        }
      }
    }
  }
}
gamelua.g_episodeIds = {}
for i = 1, #gamelua.g_episodes do
  gamelua.g_episodeIds[i] = i
end
filename = "episodes_free.lua"
