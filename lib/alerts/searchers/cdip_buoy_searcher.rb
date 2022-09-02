# frozen_string_literal: true

module Alerts
  class CdipBuoySearcher
    def search(query)
      options.select { |name, _id| name.downcase.include?(query.downcase) }.first(10)
    end

    private

    # rubocop:disable Metric/MethodLength
    def options
      [
        ['AUNUU, AMERICAN SAMOA', '189'],
        ['NGARAARD, BABELDAOB, PALAU', '219'],
        ['IPAN, GUAM', '121'],
        ['RITIDIAN POINT, GUAM', '196'],
        ['TANAPAG, SAIPAN, NMI', '197'],
        ['HILO, HAWAII, HI', '188'],
        ['KAUMALAPAU SOUTHWEST, LANAI, HI', '239'],
        ['PEARL HARBOR ENTRANCE, HI', '233'],
        ['BARBERS POINT, KALAELOA, HI', '238'],
        ['MOKAPU POINT, HI', '098'],
        ['KANEOHE BAY, HI', '198'],
        ['WAIMEA BAY, HI', '106'],
        ['HANALEI, KAUAI, HI', '202'],
        ['SCRIPPS PIER, CA', '073'],
        ['OCEAN STATION PAPA', '166'],
        ['POINT LOMA SOUTH, CA', '191'],
        ['MISSION BAY WEST, CA', '220'],
        ['SCRIPPS NEARSHORE, CA', '201'],
        ['TORREY PINES OUTER, CA', '100'],
        ['DEL MAR NEARSHORE, CA', '153'],
        ['LEUCADIA NEARSHORE, CA', '262'],
        ['OCEANSIDE OFFSHORE, CA', '045'],
        ['SAN NICOLAS ISLAND, CA', '067'],
        ['SAN PEDRO SOUTH, CA', '213'],
        ['SAN PEDRO, CA', '092'],
        ['LONG BEACH CHANNEL, CA', '215'],
        ['SANTA CRUZ BASIN, CA', '203'],
        ['SANTA MONICA BAY, CA', '028'],
        ['TOPANGA NEARSHORE, CA', '103'],
        ['HARVEST, CA', '071'],
        ['SANTA LUCIA ESCARPMENT, CA', '222'],
        ['DIABLO CANYON, CA', '076'],
        ['POINT SUR, CA', '157'],
        ['CABRILLO POINT NEARSHORE, CA', '158'],
        ['MONTEREY BAY WEST, CA', '185'],
        ['POINT SANTA CRUZ, CA', '254'],
        ['POINT REYES, CA', '029'],
        ['CAPE MENDOCINO, CA', '094'],
        ['HUMBOLDT BAY NORTH SPIT, CA', '168'],
        ['UMPQUA OFFSHORE, OR', '139'],
        ['CLATSOP SPIT, OR', '162'],
        ['GRAYS HARBOR, WA', '036'],
        ['ANGELES POINT, WA', '248'],
        ['LOWER COOK INLET, AK', '204'],
        ['NOME, AK', '241'],
        ['SATAN SHOAL, FL', '244'],
        ['ST. PETERSBURG OFFSHORE, FL', '144'],
        ['EGMONT CHANNEL ENTRANCE, FL', '214'],
        ['SOUTHWEST PASS ENTRANCE W, LA', '256'],
        ['FORT PIERCE, FL', '134'],
        ['CAPE CANAVERAL NEARSHORE, FL', '143'],
        ['ST. AUGUSTINE, FL', '194'],
        ['FERNANDINA BEACH, FL', '132'],
        ['WILMINGTON HARBOR, NC', '200'],
        ['MASONBORO INLET, ILM2, NC', '150'],
        ['ONSLOW BAY OUTER, NC', '217'],
        ['MCGULPIN POINT NORTH, MI', '253'],
        ['ISLE ROYALE EAST, MI', '230'],
        ['RINCON, PUERTO RICO', '181']
      ]
    end
    # rubocop:enable Metric/MethodLength
  end
end