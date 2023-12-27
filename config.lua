Config = {
    Booths = {
        {
            coords = vector3(-132.32, -1399.06, 31.1),
            model = "prop_phonebox_04",
        },
        {
            coords = vector3(55.25, -1081.59, 29.45),
            model = "prop_phonebox_04",
        },
        -- Other booth configurations...
    },

    PhoneModels = {
        "prop_phonebox_04",
    },

    phoneNumbers = {
        "911",
        "000",
        "912",
        "913",
        "0001234567",
        "1234567890",
        "8888888888",
        "9876543210", 
    },     

    CallCooldown = 10,
    CallPrice = 30,

    AnswerCooldown = 5,
    AnswerPrice = 2,

    CallMenu = {
        title = "Phone",
        buttons = {
            {
                text = "Call",
                event = "phonebooth:call",
            },
            {
                text = "Answer",
                event = "phonebooth:answer",
            },
        },
    },

    AnswerMenu = {
        title = "Phone",
        buttons = {
            {
                text = "Answer",
                event = "phonebooth:answer",
            },
            {
                text = "Reject",
                event = "phonebooth:reject",
            },
        },
    },

    CallNotification = {
        title = "Phone",
        text = "You have a incoming call [caller]",
    },

    AnswerNotification = {
        title = "Phone",
        text = "[caller] has called",
    },

    RejectNotification = {
        title = "Phone",
        text = "[caller] has rejected your call",
    },
}
