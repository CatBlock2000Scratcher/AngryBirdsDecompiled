if deviceModel == "ipad" then
  g_iap_products = {
    superseed_10x = "com.chillingo.angrybirdshd.superseed10",
    superseed_30x = "com.chillingo.angrybirdshd.superseed30",
    superseed_80x = "com.chillingo.angrybirdshd.superseed80",
    superseed_180x = "com.chillingo.angrybirdshd.superseed180",
    kingsling_10x = "com.chillingo.angrybirdshd.kingsling10",
    kingsling_30x = "com.chillingo.angrybirdshd.kingsling30",
    kingsling_80x = "com.chillingo.angrybirdshd.kingsling80",
    kingsling_180x = "com.chillingo.angrybirdshd.kingsling180",
    slingscope_10x = "com.chillingo.angrybirdshd.slingscope10",
    slingscope_30x = "com.chillingo.angrybirdshd.slingscope30",
    slingscope_80x = "com.chillingo.angrybirdshd.slingscope80",
    slingscope_180x = "com.chillingo.angrybirdshd.slingscope180",
    birdquake_10x = "com.chillingo.angrybirdshd.birdquake10",
    birdquake_30x = "com.chillingo.angrybirdshd.birdquake30",
    birdquake_80x = "com.chillingo.angrybirdshd.birdquake80",
    birdquake_180x = "com.chillingo.angrybirdshd.birdquake180",
    bundle_5x = "com.chillingo.angrybirdshd.allin_one_bundle_20",
    bundle_15x = "com.chillingo.angrybirdshd.allin_one_bundle_60",
    bundle_60x = "com.chillingo.angrybirdshd.allin_one_bundle_240",
    bundle_125x = "com.chillingo.angrybirdshd.allin_one_bundle_500"
  }
elseif deviceModel == "iphone" then
  g_iap_products = {
    superseed_10x = "com.chillingo.angrybirds.superseed10",
    superseed_30x = "com.chillingo.angrybirds.superseed30",
    superseed_80x = "com.chillingo.angrybirds.superseed80",
    superseed_180x = "com.chillingo.angrybirds.superseed180",
    kingsling_10x = "com.chillingo.angrybirds.kingsling10",
    kingsling_30x = "com.chillingo.angrybirds.kingsling30",
    kingsling_80x = "com.chillingo.angrybirds.kingsling80",
    kingsling_180x = "com.chillingo.angrybirds.kingsling180",
    slingscope_10x = "com.chillingo.angrybirds.slingscope10",
    slingscope_30x = "com.chillingo.angrybirds.slingscope30",
    slingscope_80x = "com.chillingo.angrybirds.slingscope80",
    slingscope_180x = "com.chillingo.angrybirds.slingscope180",
    birdquake_10x = "com.chillingo.angrybirds.birdquake10",
    birdquake_30x = "com.chillingo.angrybirds.birdquake30",
    birdquake_80x = "com.chillingo.angrybirds.birdquake80",
    birdquake_180x = "com.chillingo.angrybirds.birdquake180",
    bundle_5x = "com.chillingo.angrybirds.allin_one_bundle_20",
    bundle_15x = "com.chillingo.angrybirds.allin_one_bundle_60",
    bundle_60x = "com.chillingo.angrybirds.allin_one_bundle_240",
    bundle_125x = "com.chillingo.angrybirds.allin_one_bundle_500"
  }
else
  g_iap_products = {
    superseed_10x = "com.rovio.angrybirds.superseed.1",
    superseed_30x = "com.rovio.angrybirds.superseed.2",
    superseed_80x = "com.rovio.angrybirds.superseed.3",
    superseed_180x = "com.rovio.angrybirds.superseed.4",
    kingsling_10x = "com.rovio.angrybirds.kingsling.1",
    kingsling_30x = "com.rovio.angrybirds.kingsling.2",
    kingsling_80x = "com.rovio.angrybirds.kingsling.3",
    kingsling_180x = "com.rovio.angrybirds.kingsling.4",
    slingscope_10x = "com.rovio.angrybirds.slingscope.1",
    slingscope_30x = "com.rovio.angrybirds.slingscope.2",
    slingscope_80x = "com.rovio.angrybirds.slingscope.3",
    slingscope_180x = "com.rovio.angrybirds.slingscope.4",
    birdquake_10x = "com.rovio.angrybirds.birdquake.1",
    birdquake_30x = "com.rovio.angrybirds.birdquake.2",
    birdquake_80x = "com.rovio.angrybirds.birdquake.3",
    birdquake_180x = "com.rovio.angrybirds.birdquake.4",
    bundle_5x = "com.rovio.angrybirds.bundle.1",
    bundle_15x = "com.rovio.angrybirds.bundle.2",
    bundle_60x = "com.rovio.angrybirds.bundle.3",
    bundle_125x = "com.rovio.angrybirds.bundle.4"
  }
end
function purchaseItem(pid, success, failure)
  print("<IAP> begin init item [" .. _G.tostring(pid) .. "]\n")
  print("<IAP> success callback [" .. _G.tostring(success) .. "]\n")
  print("<IAP> failure callback [" .. _G.tostring(failure) .. "]\n")
  g_iap_success = success
  g_iap_failure = failure
  g_iap_pid = pid
  g_iap_init = iapInitTimeOut
  print("<IAP> init timeout set to " .. _G.tostring(g_iap_init) .. " seconds\n")
  iapInitItemPurchase("iapInitCallback")
end
function iapCallback(pid, status, error)
  print("<IAP> iap callback for product [" .. _G.tostring(pid) .. "]\n")
  print("<IAP> status [" .. _G.tostring(status) .. "]\n")
  print("<IAP> error code [" .. _G.tostring(error) .. "]\n")
  if status and error then
    if status == 2 then
      if g_iap_failure then
        g_iap_failure(pid, status, error)
      end
    elseif (status == 1 or status == 3 or status == 4) and g_iap_success then
      g_iap_success(pid, status, error)
    end
  elseif g_iap_failure then
    g_iap_failure(pid, status, error)
  end
end
function iapInitCallback()
  print("<IAP> init callback\n")
  g_iap_init = 0
end
function iapUpdate(dt)
  if g_iap_init then
    g_iap_init = g_iap_init - dt
    if g_iap_init <= 0 then
      g_iap_init = nil
      print("<IAP> beginning item [" .. _G.tostring(g_iap_pid) .. "] purchase\n")
      iapBuyItem(g_iap_pid, "iapCallback")
    end
  end
end
function iapCancel()
  print("<IAP> iap manual cancel\n")
  if g_iap_failure then
    g_iap_failure(g_iap_pid, 2, 2)
  end
end
filename = "iap.lua"
