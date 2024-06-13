Config = {}

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
            }
        }
    }
}

Config.Notify = {
    NotEnoughMoney = {
        title = 'Garbage Job',
        description = 'You dont have enough money',
        type = 'error'
    },
    JobStarted = {
        title = 'Garbage Job',
        description = 'Get in the truck and get to work',
        type = 'success'
    }

}