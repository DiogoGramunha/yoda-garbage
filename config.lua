Config = {}

Config.GarbageValue = { value = 15,}

Config.NPC = {
    model = 's_m_y_garbage',
    coordx = -322.3729,
    coordy = -1545.8641,
    coordz = 30.0199,
    heading = 265.7856,
}

Config.CarSpawn = {
    coordx = -317.8152,
    coordy = -1523.8256,
    coordz = 27.5562,
    heading = 258.3183,
}

Config.Context = {
    title = 'Garbage Job',
    titleAlone = 'Start Job - Alone',
    descriptionAlone = 'Work alone! \n Collection: 1 \n Delivery: 1',
    iconAlone = 'person',
    labelAlone = 'Truck Rental',
    value = 300,
    titleFriend = 'Start Job - With a Friend',
    descriptionFriend = 'Work with a Friend! \n Collection: 2 \n Delivery: 2',
    iconFriend = 'person',
    labelFriend = 'Truck Rental',
    titleAbort = 'Abort Job',
    descriptionAbort = '',
    iconAbort = 'fa-solid fa-xmark',
    titleFinish = 'Finish Job',
    descriptionFinish = '',
    iconFinish = 'fa-solid fa-money-bill',

}

Config.Bins = {
    "prop_bin_01a",
    "prop_bin_03a",
    "prop_bin_05a"
}

Config.Notify = {
    NotEnoughMoney = {
        title = 'Garbage Job',
        description = 'You dont have enough money',
        duration = 5000,
        type = 'error'
    },
    JobStarted = {
        title = 'Garbage Job',
        description = 'Get in the truck and get to work',
        duration = 5000,
        type = 'success'
    },
    BinDeposited = {
        title = 'Garbage Job',
        description = 'You deposited a bin. Lets get the others!' ,
        duration = 5000,
        type = 'success'
    },
    JobEnded = {
        title = 'Garbage Job',
        description = 'Get back to central and get your payment',
        duration = 10000,
        type = 'success'
    },
    paymentFail = {
        title = 'Garbage Job',
        description = 'Those who dont work dont get paid',
        duration = 10000,
        type = 'error'
    },
    Payment = {
        title = 'Garbage Job',
        description = 'You get paid!',
        duration = 10000,
        type = 'success'
    }
}

Config.GarbLocation = {
    Loc1 = {
        Location = {
            locx = -1282.0768,
            locy = -815.0269,
        },
        Zone = {
            locx = -1282.0768,
            locy = -815.0269,
            locz = 32.2204,
        },
        Garbages = {
            garbage1 = {
                locx = -1264.1295,
                locy = -824.8027,
                locz = 16.4228
            },
            garbage2 = {
                locx = -1268.9218, 
                locy = -828.4391,
                locz = 16.4678,
            },
            garbage3 = {
                locx = -1262.9154, 
                locy = -826.7088,
                locz = 16.3759,
            },
            garbage4 = {
                locx = -1280.8444,
                locy = -835.6925,
                locz = 16.5228,
            },
            garbage5 = {
                locx = -1285.4049, 
                locy = -829.7740,
                locz = 16.4085,
            },
            garbage6 = {
                locx = -1287.1858, 
                locy = -831.7243,
                locz = 16.4873,
            },
            garbage7 = {
                locx = -1285.4664, 
                locy = -824.3659,
                locz = 16.5010,
            },
            garbage8 = {
                locx = -1284.1257, 
                locy = -799.7050,
                locz = 17.0244,
            },
            garbage9 = {
                locx = -1286.8530, 
                locy = -799.5106,
                locz = 16.9855,
            },
            garbage10 = {
                locx = -1299.8643, 
                locy = -803.6442,
                locz = 16.9868,
            },
            garbage11 = {
                locx = -1301.2631, 
                locy = -806.2493,
                locz = 16.8710,
            },
            garbage12 = {
                locx = -1306.4834, 
                locy = -799.1320,
                locz = 16.8712,
            },
            garbage13 = {
                locx = -1308.6213, 
                locy = -796.9801,
                locz = 16.9670,
            },
            garbage14 = {
                locx = -1299.9502, 
                locy = -783.9673,
                locz = 17.2019,
            },
            garbage15 = {
                locx = -1300.4698, 
                locy = -782.3044,
                locz = 17.3265,
            },
            garbage16 = {
                locx = -1306.1401, 
                locy = -771.8212,
                locz = 19.1525,
            },
            garbage17 = {
                locx = -1321.8707, 
                locy = -775.5303,
                locz = 19.3169,
            },
            garbage18 = {
                locx = -1323.7860, 
                locy = -771.7714,
                locz = 19.5862,
            },
            garbage19 = {
                locx = -1324.3123, 
                locy = -768.3235,
                locz = 19.7779,
            },
            garbage20 = {
                locx = -1325.7537, 
                locy = -766.7503,
                locz = 19.8499,
            },
            garbage21 = {
                locx = -1341.8351, 
                locy = -760.9457,
                locz = 19.5926,
            },
            garbage22 = {
                locx = -1343.5658, 
                locy = -762.1649,
                locz = 19.5929,
            },
            garbage23 = {
                locx = -1349.9286, 
                locy = -758.7980,
                locz = 21.7893,
            },
            garbage24 = {
                locx = -1336.7625, 
                locy = -741.8473,
                locz = 21.7322,
            },
        },
    },
    Loc2 = {
        Location = {
            locx = -137.7775,
            locy = -1633.6963,
        },
        Zone = {
            locx = -137.7775,
            locy = -1633.6963,
            locz = 32.2204,
        },
        Garbages = {
            garbage1 = {
                locx = -141.0130,
                locy = -1628.2512,
                locz = 32.7429,
            },
            garbage2 = {
                locx = -139.8686, 
                locy = -1625.6934,
                locz = 32.5593,
            },
            garbage3 = {
                locx = -157.2027, 
                locy = -1666.3431,
                locz = 32.9133,
            },
            garbage4 = {
                locx = -168.0887,
                locy = -1661.8927,
                locz = 32.8475,
            },
            garbage5 = {
                locx = -165.6185, 
                locy = -1660.2441,
                locz = 32.6371,
            },
            garbage6 = {
                locx = -164.7689, 
                locy = -1659.7020,
                locz = 32.5976,
            },
            garbage7 = {
                locx = -160.7748, 
                locy = -1670.1317,
                locz = 33.0473,
            },
            garbage8 = {
                locx = -161.5689, 
                locy = -1672.5356,
                locz = 32.4357,
            },
            garbage9 = {
                locx = -162.1799, 
                locy = -1673.2296,
                locz = 32.4142,
            },
            garbage10 = {
                locx = -143.3896, 
                locy = -1650.8444,
                locz = 31.8917,
            },
            garbage11 = {
                locx = -143.0115,
                locy = -1650.2867,
                locz = 31.8621,
            },
            garbage12 = {
                locx = -143.9718, 
                locy = -1630.8054,
                locz = 32.2703,
            },
            garbage13 = {
                locx = -143.3951, 
                locy = -1630.2285,
                locz = 32.2311,
            },
            garbage14 = {
                locx = -121.9746, 
                locy = -1622.2192,
                locz = 31.5635,
            },
            garbage15 = {
                locx = -105.3690, 
                locy = -1605.9321,
                locz = 31.0764,
            },
            garbage16 = {
                locx = -100.6263, 
                locy = -1579.8811,
                locz = 30.9737,
            },
            garbage17 = {
                locx = -101.7136, 
                locy = -1581.1531,
                locz = 31.0867,
            },
            garbage18 = {
                locx = -201.4909, 
                locy = -1692.2092,
                locz = 33.4758,
            },
            garbage19 = {
                locx = -51.6025, 
                locy = -1662.1720,
                locz = 28.7297,
            },
            garbage20 = {
                locx = -228.9406, 
                locy = -1637.5586,
                locz = 33.2081,
            }
        },
    },
    Loc3 = {
        Location = {
            locx = 3.2170,
            locy = -1030.7196,
        },
        Zone = {
            locx = 3.2170,
            locy = -1030.7196,
            locz = 29.1262,
        },
        Garbages = {
            garbage1 = {
                locx = 6.7689,
                locy = -1029.3663,
                locz = 28.4273,
            },
            garbage2 = {
                locx = 8.6089, 
                locy = -1029.8416,
                locz = 28.5827,
            },
            garbage3 = {
                locx = -8.3397, 
                locy = -1037.1144,
                locz = 28.3153,
            },
            garbage4 = {
                locx = -18.8888, 
                locy = -1036.1060,
                locz = 28.3074,
            },
            garbage5 = {
                locx = -21.1669, 
                locy = -1035.2896,
                locz = 28.2354,
            },
            garbage6 = {
                locx = -33.2411, 
                locy = -1030.8281,
                locz = 28.1780,
            },
            garbage7 = {
                locx = -34.6058, 
                locy = -1029.8757,
                locz = 28.2194,
            },
            garbage8 = {
                locx = -2.7021, 
                locy = -1082.2042,
                locz = 26.0842,
            },
            garbage9 = {
                locx = -3.4998, 
                locy = -1084.2516,
                locz = 26.0726,
            },
            garbage10 = {
                locx = -36.9748, 
                locy = -1121.7432,
                locz = 25.7391,
            },
            garbage11 = {
                locx = 32.8413, 
                locy = -1009.7021,
                locz = 28.8249,
            },
            garbage12 = {
                locx = 49.2477, 
                locy = -1067.3300,
                locz = 28.9964,
            },
            garbage13 = {
                locx = 48.2201, 
                locy = -1068.9658,
                locz = 28.9988,
            },
            garbage14 = {
                locx = 18.4722, 
                locy = -1118.9470,
                locz = 28.3204,
            },
        },
    },
    Loc4 = {
        Location = {
            locx = -28.7142,
            locy = -1303.5884,
        },
        Zone = {
            locx = -28.7142,
            locy = -1303.5884,
            locz = 28.6887,
        },
        Garbages = {
            garbage1 = {
                locx = -44.5846,
                locy = -1299.8431,
                locz = 28.5477,
            },
            garbage2 = {
                locx = -44.6879,
                locy = -1285.7317,
                locz = 28.4783,
            },
            garbage3 = {
                locx = -49.9649,
                locy = -1266.3652,
                locz = 28.6041,
            },
            garbage4 = {
                locx = -55.8673,
                locy = -1266.2020,
                locz = 28.6029,
            },
            garbage5 = {
                locx = -78.2553,
                locy = -1266.7168,
                locz = 28.5990,
            },
            garbage6 = {
                locx = -80.6487,
                locy = -1266.7460,
                locz = 28.6329,
            },
            garbage7 = {
                locx = -86.5634,
                locy = -1278.1875,
                locz = 28.5839,
            },
            garbage8 = {
                locx = -86.5765,
                locy = -1287.4929,
                locz = 28.6009,
            },
            garbage9 = {
                locx = -86.5172,
                locy = -1298.5403,
                locz = 28.6985,
            },
            garbage10 = {
                locx = -79.9456,
                locy = -1313.1327,
                locz = 28.6149,
            },
            garbage11 = {
                locx = -70.1392,
                locy = -1312.9327,
                locz = 28.6746,
            },
            garbage12 = {
                locx = -49.1114,
                locy = -1315.0305,
                locz = 28.6279,
            },
            garbage13 = {
                locx = -86.3781,
                locy = -1330.2723,
                locz = 28.6724,
            },
            garbage14 = {
                locx = -50.6875,
                locy = -1349.7390,
                locz = 28.7146,
            },
            garbage15 = {
                locx = -38.7960,
                locy = -1351.1110,
                locz = 28.6975,
            },
            garbage16 = {
                locx = -28.0723,
                locy = -1351.2426,
                locz = 28.6984,
            },
            garbage17 = {
                locx = 2.3304,
                locy = -1350.6440,
                locz = 28.5996,
            },
            garbage18 = {
                locx = 2.8675,
                locy = -1387.2550,
                locz = 28.6466,
            },
            garbage19 = {
                locx = 0.6603,
                locy = -1387.3597,
                locz = 28.6764,
            },
            garbage20 = {
                locx = -18.3703,
                locy = -1390.7369,
                locz = 28.6834,
            },
            garbage21 = {
                locx = -18.2433,
                locy = -1388.5934,
                locz = 28.7534,
            },
            garbage22 = {
                locx = -10.7324,
                locy = -1309.4833,
                locz = 28.6446,
            },
            garbage23 = {
                locx = -22.3615,
                locy = -1294.7239,
                locz = 28.7640,
            },
        },
    },
    Loc4 = {
        Location = {
            locx = 149.1974,
            locy = -1298.4204,
        },
        Zone = {
            locx = 149.1974,
            locy = -1298.4204,
            locz = 29.0268,
        },
        Garbages = {
            garbage1 = {
                locx = 156.9748,
                locy = -1307.3336,
                locz = 28.6055,
            },
            garbage2 = {
                locx = 155.8380,
                locy = -1309.2783,
                locz = 28.5794,
            },
            garbage3 = {
                locx = 136.7120,
                locy = -1314.2502,
                locz = 28.5925,
            },
            garbage4 = {
                locx = 122.7098,
                locy = -1327.0269,
                locz = 28.7874,
            },
            garbage5 = {
                locx = 120.8579,
                locy = -1328.5330,
                locz = 28.7608,
            },
            garbage6 = {
                locx = 105.8675,
                locy = -1316.4121,
                locz = 28.5914,
            },
            garbage7 = {
                locx = 103.8196,
                locy = -1317.3258,
                locz = 28.6252,
            },
            garbage8 = {
                locx = 92.8967,
                locy = -1305.7192,
                locz = 28.6412,
            },
            garbage9 = {
                locx = 91.8522,
                locy = -1303.8644,
                locz = 28.6015,
            },
            garbage10 = {
                locx = 84.8366,
                locy = -1291.5573,
                locz = 28.6287,
            },
            garbage11 = {
                locx = 90.0208,
                locy = -1286.0284,
                locz = 28.7338,
            },
            garbage12 = {
                locx = 91.9622,
                locy = -1284.7465,
                locz = 28.6744,
            },
            garbage13 = {
                locx = 97.0241,
                locy = -1282.9956,
                locz = 28.6372,
            },
            garbage14 = {
                locx = 144.2933,
                locy = -1259.8513,
                locz = 29.1107,
            },
            garbage15 = {
                locx = 145.5043,
                locy = -1262.2484,
                locz = 29.9207,
            },
            garbage16 = {
                locx = 146.9817,
                locy = -1290.1985,
                locz = 28.6862,
            },
            garbage17 = {
                locx = 145.0994,
                locy = -1291.3458,
                locz = 28.7399,
            },
            garbage18 = {
                locx = 166.5458,
                locy = -1293.2191,
                locz = 28.7512,
            },
            garbage19 = {
                locx = 165.6605,
                locy = -1287.1000,
                locz = 28.5723,
            },
            garbage20 = {
                locx = 201.3584,
                locy = -1265.9303,
                locz = 28.5398,
            },
            garbage21 = {
                locx = 184.2626,
                locy = -1250.2898,
                locz = 28.4887,
            },
            garbage22 = {
                locx = 182.3322,
                locy = -1249.7029,
                locz = 28.4637,
            },
            garbage23 = {
                locx = 194.1722,
                locy = -1294.4348,
                locz = 28.6087,
            },
            garbage24 = {
                locx = 188.4340,
                locy = -1319.9382,
                locz = 28.6996,
            },
            garbage25 = {
                locx = 166.7802,
                locy = -1344.9294,
                locz = 28.7385,
            },
            garbage26 = {
                locx = 165.8455,
                locy = -1346.5449,
                locz = 28.6964,
            },
            garbage27 = {
                locx = 162.8205,
                locy = -1350.3926,
                locz = 28.6250,
            },
            garbage28 = {
                locx = 140.4577,
                locy = -1362.9507,
                locz = 28.7085,
            },
            garbage29 = {
                locx = 138.7396,
                locy = -1361.7942,
                locz = 28.7295,
            },
        },
    }
}