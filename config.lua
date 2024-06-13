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
}

--[[ Config.Local = {
    coordx = ,
    coordy = ,
    coordz = ,
} ]]

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